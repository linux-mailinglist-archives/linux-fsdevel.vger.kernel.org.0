Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF0C6BC0AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 00:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjCOXNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 19:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjCOXNP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:13:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DE41258A;
        Wed, 15 Mar 2023 16:13:13 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FLeJGX003133;
        Wed, 15 Mar 2023 23:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7X1bj3xjjLVPkP3ZUNrRCXqG49ad4l9IVMNpJwojHsg=;
 b=G6Rc5kYS6YyxwpHVhNMMEoG1M2Hj1TWE3zrX3Dp1U90WewaZoZ0o8k/HWIHyuBgEm+1A
 ZPtASc5v0nxtLvIcfHfX9uwYK/LvwfRpEB82yD5ZmiaAfBOvtJ0g1xzZbbfCoMVpj+/y
 Q+u52RYdDoEsB4QalKm/tfyEDbpPUi6JjH5CRHme5Ag0Ziqxx6TqJ9a6E0w9v1T5wx/0
 UJUVhEhjdjIFf8NU5huIAZRjQkLobxIH8qp3/npwQbSuOOn8AMRUGl2WLTVzj/yjkXqM
 QSn4pyVHwriZQOo7t7zrMbB5CqJ0u+NsyvXLYaY8qVkd4iw0nTxZLZAtfw+A7DheloyN jg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbp4p04qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 23:13:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32FMRNCj039018;
        Wed, 15 Mar 2023 23:13:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbpty17b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 23:13:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fa2ZHe9ZOj942ojjNlfH3CQT+6qZ/Ml6Lqf4ZeMKOYBIYizEs6IjtHCt8jjv5CzTGJRuJdPJXKKMW7Ucq1qEyqlwxCrIQVCDW1shiDulVmkxUTckDux+fk7u6ck2lX9vIXvOgumUwE/Uk4ewPqkTUEcod6Bjiztht/HSaNWflYuu+RgBC3caUoPUPKWX/g1nMxFeo119x0siCe0Bse4nAFCW/UOKWj8B5+JO3WnoRKBRx2n3Kr/MEisOneZWcxrmLK6nVTOgcu0nmXZw0fQ9IF76HmHmBb6OjdKa9nE1YCa0rOX6gWzdIhtK4Vb5G/n5ZxMIGcLMlEkse4fFHcc1NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7X1bj3xjjLVPkP3ZUNrRCXqG49ad4l9IVMNpJwojHsg=;
 b=b6FmAEzQK6DTERbMyP0QdWIisG7qQ0fLXLESQk3DFUi7sndopfiWN1Kl7E1xXoBMcU5OgpzsdmtjB/C3lrQo0BEufoUlx+wy80aR9MCuQKFQuw3ouwtuaK+WGpyIOCPDg9pPwV4mS9AKEqlC+6jUEToKQuHTynYguGAm+6gwGmeRErYfkLiMxjoJirdxBedpUGnkMotlh534sUB2e2h3GaAoS0h0w3rdVvCN+n/Ff37Sv8E+EVtveqoeyR9A031Hl//M27/AWuaUVKCsGFA3cgyZvE9M46zZnMW55UDjpx3Ta4bbkVRuh2t4vmocptgHArjvgloojg8/wGjnAekKGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7X1bj3xjjLVPkP3ZUNrRCXqG49ad4l9IVMNpJwojHsg=;
 b=Mft5RUlx31Xx75V49mHprsyMjpRmU44eCA2GaSS2kVsntNHQSb8cLzf+wnL7RGGelJYHz2VTBwa4X8+5te1FSfo+6zz0VAlet95h4/qzzs9UCqk6lTS+2yZ00qELW67nNI45bILP85dEwb75ABMcj7+9VWM8vip2aMdGkGUlbgo=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by SA2PR10MB4587.namprd10.prod.outlook.com (2603:10b6:806:114::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 23:12:55 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::b647:355b:b589:60c]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::b647:355b:b589:60c%5]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 23:12:55 +0000
From:   Catherine Hoang <catherine.hoang@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH v1 3/4] xfs: add XFS_IOC_SETFSUUID ioctl
Thread-Topic: [PATCH v1 3/4] xfs: add XFS_IOC_SETFSUUID ioctl
Thread-Index: AQHZVixvmgO0q+MEy0S+WtQEAk5lTK75xYmAgAK1dQA=
Date:   Wed, 15 Mar 2023 23:12:55 +0000
Message-ID: <FC1BD250-7179-470B-854E-649E52147219@oracle.com>
References: <20230314042109.82161-1-catherine.hoang@oracle.com>
 <20230314042109.82161-4-catherine.hoang@oracle.com>
 <CAOQ4uxiYVpF9gjt-kTVpnoVYboOFG-Fpfw=KMrM=-aEHod4vXw@mail.gmail.com>
In-Reply-To: <CAOQ4uxiYVpF9gjt-kTVpnoVYboOFG-Fpfw=KMrM=-aEHod4vXw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR10MB5316:EE_|SA2PR10MB4587:EE_
x-ms-office365-filtering-correlation-id: 63f1c9b2-f5d0-4a61-fcd8-08db25aacf0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uRftMyMmdkKBAyEFZfDCiZGOFUaAjl30x2iLmZdVt9NAKh3C2nrsrq7mSCIiuIwGfMWBkz1D7OdICbNxbikyipduNzlDkDKCVpBkzD0Y5T9hid6D3rqR/AjlKCqMNyls8OlaBOBFnEqW6o7HWL/Oe2YPB1CWXiG1K7/JsKdMSKmPhzYNRcO3adq7uvRnbKh/7vPQ0DMuS3WaQxPhfIDstIapD5x3PjlrB3kzHmH9VckpbazpNTN+VgK8Jm+4GA6vNean5DvWQa3scuRMGCTcd5R42fsPFt2i9uLPuDCkWEcQGAVKYgFfVl5lcL3PSXXqhpQvM/53ZzfF3MgM15ix/9KL0vXTEw2ugOmc4CjVySBkn5TYbgkH/sxqdMxYGk3FUJYyc2Bflb9NfeFxx8C3+kD4IcJrY1zjAefKG3cvvy7zwscGy7G0CQxRB1NOBUUUd7DX3KspQ3ISMlw8WSQ6jIYURnLD1ZB+Fps9eaBzqrjCd3pDZle0cmSyUbvxM0SJKVv1CcUGdDb1WFqdEseQeUpebAqW4mpV4lNibpsTF14NBvBF7AlyOiXIwldmnPXPyQAgGlu5qckT5lSfpGYlkfrpFzZ4PpP3eW+oCpOkpb4rg3PH97EoJWRU4zrrYB5X0gI/rcoEwHq1SqXAcALJKx6dliBlEyZSLr0E4UmIVyoQ2qegn66gFMjl475an8z73DVj9prERhv37/zakTrUkMttlb+/JZEd3DCtZe1HdAg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199018)(38100700002)(316002)(54906003)(36756003)(33656002)(38070700005)(2616005)(86362001)(6512007)(122000001)(53546011)(186003)(83380400001)(6506007)(5660300002)(966005)(6486002)(2906002)(71200400001)(478600001)(8676002)(66446008)(6916009)(66556008)(4326008)(76116006)(41300700001)(64756008)(8936002)(44832011)(66946007)(91956017)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFJRT1BYUVpmT21LeENYbC81ZlluNll2MnVZQTVVckxKUDRPZ0wxRWFzanJu?=
 =?utf-8?B?Y1VqYXprbElHQThacTBCMWloeWg0SVBOYTNnT2t2bnpnK0hZRmZiTmxNbWk5?=
 =?utf-8?B?T2JhVVB2REZKK3RNUUlYRWVnZW5wV3loT05VeFBaZnJVSnVjdVVVQ0FpcWtk?=
 =?utf-8?B?RlA5YW9KbzFaQm43THpodDd4UCtqcTExYkwxSnNWaHVsL0loSFZYb2UwMlZw?=
 =?utf-8?B?TEh5RDZpSVoxSytUTEdka2pnTGg3cnFKKzdKU0c3ejNzcXJBNFdjUVNLS1Ey?=
 =?utf-8?B?M2lSbUZ0NnE5L1htMGswUzVhWWF1Z1BrYVpQQWRWOGpRdExnVjExYzRoZHpB?=
 =?utf-8?B?clR5WTJ6QUJOaEFLalp0aThZTzdKRXF0UUxUU253bzlGYmEvY2dBZVlxRVJH?=
 =?utf-8?B?Q0VCd1pPTUwzSTFpNzM0aGhjcURMNi9ZVXVIbWloVVZwQklvRGxyb2VXelJB?=
 =?utf-8?B?N3pjN2tyaEhFbHVOSnlFNjhZZDFXSlFROEU2VjRkZFgyNG1TdzBvOWZCU3ov?=
 =?utf-8?B?bUUrSHdCNDlrOHI2WUo4UEdPenFMQ0VQaFhUOVlmaCtwbFFPK2VMcVV5R1Ar?=
 =?utf-8?B?b3ZwTkV5aGlRZ2RHVHVJT0xtZkZxVUJPaXJxWndQdTRoMHkwejk1dGUrdjBw?=
 =?utf-8?B?QUJqSG5QeFZ1TXpiUVgrZXM2N1hRODN0VVFKekV3dWlBNWxsM3M5VUZ4K3Vp?=
 =?utf-8?B?QzNuZ2lOb3VOV2cwUUU3V05uSU1oU2l6UEhsQUZkbUZtL3N0UHArZEhiQWc4?=
 =?utf-8?B?UEcvVmpSaWp6U1NMalhYN0VvZWtWK2ZQWGVodjB2dzY5MTQ0Ky93NGhEaC9S?=
 =?utf-8?B?WVNoWGlQRHg4UDV4dG43aDFRT0xDWmU3WXFDVEFLcGhwbC9QQ3d6Z2Q1a1o0?=
 =?utf-8?B?V2NtQmdjUUhhUFNrNzdIU2NRRFN3MmFCQVY4VTB0Z242QUxOb3hDSER0b2Ji?=
 =?utf-8?B?dUcvdExsTGdiZkM3a2hrSEh1VE1NYkhZa0t3TXV0RUcyQ1d5REMzRUZDUVRj?=
 =?utf-8?B?dW5aSElqVzk4M282Mkl6c2I1eHYydnJ1OTBUbzlmZ2hWSnl3UEh3ZFZxNEZY?=
 =?utf-8?B?di9KUncrOHFCZC9KMDdYQytZQUZEc2JJU3JxN1lLSXlCTjJZOEFER2NvZGpy?=
 =?utf-8?B?b3Baa0xIS0M0TWFRdjdVMXNJa0NmeUZLL1BhMzBvRHNZZGl4U21KWjlSeDBa?=
 =?utf-8?B?NTdxSDd0blBJeUh2dWUxQjQ3djUzOSt3eElVNnFPMHE1VXFrTXhvVnFKakZW?=
 =?utf-8?B?OUZWTnF3Y1pJNjJ5R2xwdkpFRUVLdzRoZW5JU0NIOVFBSFlkK1FaKytjeUdr?=
 =?utf-8?B?aDR3c3pDNFFBYXMwNnAvN1ZzbXVTZER6WTRHcVIwZm1xY0dId2s1NDh2SGRa?=
 =?utf-8?B?eS9Ia1cxZkxUWWVDNW9DajRBNW5SWjJDTlZYOXZ1WWJlL3VGcmNsLzlqa1ZI?=
 =?utf-8?B?UmlPeERXUy9wNm40ZnYyOXlMZTBEajBKM04wUXRFcTdLaTlBcjdaTnVwZXNZ?=
 =?utf-8?B?WnJoODFtei9RQ2lRQ3NYWnFwNlFEL283QUR1L2FibTluSWp2WGxKTGlYSWJR?=
 =?utf-8?B?QmVtdGpsZ0FaM3hsKzJaZ3puVkpGSXhLNXllVjRtTU80K09PMVVmdUlQYzhi?=
 =?utf-8?B?bEJoWTJMS2ZsNW9SNE9hQ0lZalpPUVhpdmNaQ1l5TDBZSUpVQjVERHNuQk1X?=
 =?utf-8?B?OXk2YkFzemlnWDFpdEo2Q1BSTUVpckZscHR0WFE0eXVKMHZnRUkxTCtQTDhC?=
 =?utf-8?B?eE8xS3pvRjBISzdxQmJFV2ZZeWtRV1pPb0RTTVRoZEFvazNCNFAwc3dCNm84?=
 =?utf-8?B?SFFrV28xVGpXMmRNc0lCVW9pME16YXZ4ZnF5NUFOTThyNEVyUGVlUUx3MUF1?=
 =?utf-8?B?VW8xRmRwR05KQlY0WG5RdzhRcnIwc1ZtckREZVJvWEJIWEw0djUvd1ZUdjho?=
 =?utf-8?B?T2NWRWQ5bmtjcFVpL3BVam5GbEZCeVZudVpBbHorTGxPWEM3TDdlU3RDOTdT?=
 =?utf-8?B?MjVjSVdDZVBwWSsyYWRrbENlNTZjM2pqcG5TVUk5aTJhMGIvMnRCTXlIcW5T?=
 =?utf-8?B?WVk3ZWtWRnVGUFBveHJxaXdlcW9MVGNySDVWbHdPbUt6L0l1cmMwaEdGU3hq?=
 =?utf-8?B?M29FSHZtM053bVZZMktKRjUxdTZjb3huZEUxV2pHTCtNVSt4SXBzeDYzMkVU?=
 =?utf-8?B?SjV2WFdVU1FVdEVzbklVRTM1NW5XdzQ5V1cxQ2V2RG85bmd6NWR0d1RmaWZw?=
 =?utf-8?Q?fEBsRU/Lk9s6NOaZl2eFz7I9+PCc7dumgbjSK4a2UQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E02DFAE0B00C4B4FAE66ADE2B37A9AA3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sQYtyepHSV8M6pokvfIv+zP53WJ8QGo4AMCCUSx60AeE7WygI7UEO6+ttB4X3FmqIKHzAqe1NT7WNUhGGg0zB9ZcJQvUDEnY6man05chcE+GNJcA0OHTKRhtYlkliwXnZzgpyFzUK7yVzJPdLsdNGTZaJgsIe8/55MA5fwvCCgaDbbCrnRFVHqgGRECYT1+7HHmvjAmIsM+ypTzD7cm4Q3JOypp5FkruRu6TT7dOlGK5Y2OCeU3u8frOwUNi87qLpWIYJYo5B5w8fFj7joCz0us8bs13Ew3RpEqSpf58Bg0NN8+OJCCW9wmZ19UYVQvcvJagzYc28ygyW480km0ZZjKFNofcT36gvt7qG7Z5+AC5yaMGd6JJx819JqrNjk4w8vMIjSBfzKBqVHVtc5mr3p1wk7uB+vFn2uYWiAWFTAgq6svUHx/C+TSOamxE/2SBQHP3/Pnm1V7YKPuz4AiOD9WTiBY50kvecy32EmHUXC72Z1GhsSUwu30GqUGdbktteAMu5V/3MqwSnMzyfw7DWGAr3tHfym/Ng7y1pTXSu6DXb4jbzG21R6BwcLvs32IHftZw5GSW+cQpgqdQ4ePIWaZ3DsWSlKZewK/MDH7V6pGvjkmxMdyNGTAWihGXsGBvbzDR64WuUFnLx8hhQqs3AhoSCQBODsd797Ozoiy1I1nXbPfrREgWGb4PDptARl5KyruUwqFFSrU6Jv+io/o+H1MR1/Xi5PhWsuIYKeMIkTqpsfVPE8gyaeBB6Csqw9YYX//F6PRiPI3oUO7LGTQCnhc+btK+w1HCW8cCRdLvwEl50WcMgCKZU5SZm9t3B3BQ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f1c9b2-f5d0-4a61-fcd8-08db25aacf0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 23:12:55.1500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dpqLtR01oVVX/5RVNe5yEGMuCfvbs2MH0akWkreGRN26Siogr2VVh++EFikhkBTU3UTRU9TVH4fWQWAS4w/hVaLL4o6uYolA1RTlSjYpLUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4587
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_12,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150001 definitions=main-2303150190
X-Proofpoint-ORIG-GUID: hp7jHPBY0PLT_wtTbBsq1wi9OZFMvcei
X-Proofpoint-GUID: hp7jHPBY0PLT_wtTbBsq1wi9OZFMvcei
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBPbiBNYXIgMTMsIDIwMjMsIGF0IDEwOjUwIFBNLCBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxA
Z21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgTWFyIDE0LCAyMDIzIGF0IDY6MjfigK9B
TSBDYXRoZXJpbmUgSG9hbmcNCj4gPGNhdGhlcmluZS5ob2FuZ0BvcmFjbGUuY29tPiB3cm90ZToN
Cj4+IA0KPj4gQWRkIGEgbmV3IGlvY3RsIHRvIHNldCB0aGUgdXVpZCBvZiBhIG1vdW50ZWQgZmls
ZXN5c3RlbS4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogQ2F0aGVyaW5lIEhvYW5nIDxjYXRoZXJp
bmUuaG9hbmdAb3JhY2xlLmNvbT4NCj4+IC0tLQ0KPj4gZnMveGZzL2xpYnhmcy94ZnNfZnMuaCB8
ICAgMSArDQo+PiBmcy94ZnMveGZzX2lvY3RsLmMgICAgIHwgMTA3ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+PiBmcy94ZnMveGZzX2xvZy5jICAgICAgIHwgIDE5
ICsrKysrKysrDQo+PiBmcy94ZnMveGZzX2xvZy5oICAgICAgIHwgICAyICsNCj4+IDQgZmlsZXMg
Y2hhbmdlZCwgMTI5IGluc2VydGlvbnMoKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2ZzL3hmcy9s
aWJ4ZnMveGZzX2ZzLmggYi9mcy94ZnMvbGlieGZzL3hmc19mcy5oDQo+PiBpbmRleCAxY2ZkNWJj
NjUyMGEuLmEzNTA5NjZjY2U5OSAxMDA2NDQNCj4+IC0tLSBhL2ZzL3hmcy9saWJ4ZnMveGZzX2Zz
LmgNCj4+ICsrKyBiL2ZzL3hmcy9saWJ4ZnMveGZzX2ZzLmgNCj4+IEBAIC04MzEsNiArODMxLDcg
QEAgc3RydWN0IHhmc19zY3J1Yl9tZXRhZGF0YSB7DQo+PiAjZGVmaW5lIFhGU19JT0NfRlNHRU9N
RVRSWSAgICAgICAgICBfSU9SICgnWCcsIDEyNiwgc3RydWN0IHhmc19mc29wX2dlb20pDQo+PiAj
ZGVmaW5lIFhGU19JT0NfQlVMS1NUQVQgICAgICAgICAgICBfSU9SICgnWCcsIDEyNywgc3RydWN0
IHhmc19idWxrc3RhdF9yZXEpDQo+PiAjZGVmaW5lIFhGU19JT0NfSU5VTUJFUlMgICAgICAgICAg
ICBfSU9SICgnWCcsIDEyOCwgc3RydWN0IHhmc19pbnVtYmVyc19yZXEpDQo+PiArI2RlZmluZSBY
RlNfSU9DX1NFVEZTVVVJRCAgICAgICAgICAgX0lPUiAoJ1gnLCAxMjksIHV1aWRfdCkNCj4gDQo+
IFNob3VsZCBiZSBfSU9XLg0KDQpPaywgd2lsbCBmaXggdGhhdC4NCj4gDQo+IFdvdWxkIHlvdSBj
b25zaWRlciBkZWZpbmluZyB0aGF0IGFzIEZTX0lPQ19TRVRGU1VVSUQgaW4gZnMuaCwNCj4gc28g
dGhhdCBvdGhlciBmcyBjb3VsZCBpbXBsZW1lbnQgaXQgbGF0ZXIgb24sIGluc3RlYWQgb2YgaG9p
c3RpbmcgaXQgbGF0ZXI/DQo+IA0KPiBJdCB3b3VsZCBiZSBlYXN5IHRvIGFkZCBzdXBwb3J0IGZv
ciBGU19JT0NfU0VURlNVVUlEIHRvIGV4dDQNCj4gYnkgZ2VuZXJhbGl6aW5nIGV4dDRfaW9jdGxf
c2V0dXVpZCgpLg0KPiANCj4gQWx0ZXJuYXRpdmVseSwgd2UgY291bGQgaG9pc3QgRVhUNF9JT0Nf
U0VURlNVVUlEIGFuZCBzdHJ1Y3QgZnN1dWlkDQo+IHRvIGZzLmggYW5kIHVzZSB0aGF0IGlvY3Rs
IGFsc28gZm9yIHhmcy4NCg0KSSBhY3R1YWxseSBkaWQgdHJ5IHRvIGhvaXN0IHRoZSBleHQ0IGlv
Y3RscyBwcmV2aW91c2x5LCBidXQgd2Ugd2VyZW7igJl0IGFibGUgdG8gY29tZQ0KdG8gYSBjb25z
ZW5zdXMgb24gdGhlIGltcGxlbWVudGF0aW9uLg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC14ZnMvMjAyMjExMTgyMTE0MDguNzI3OTYtMi1jYXRoZXJpbmUuaG9hbmdAb3JhY2xlLmNv
bS8NCg0KSSB3b3VsZCBwcmVmZXIgdG8ga2VlcCB0aGlzIGRlZmluZWQgYXMgYW4geGZzIHNwZWNp
ZmljIGlvY3RsIHRvIGF2b2lkIGFsbCBvZiB0aGUNCmZzZGV2ZWwgYmlrZXNoZWRkaW5nLg0KPiAN
Cj4gVXNpbmcgYW4gZXh0ZW5zaWJsZSBzdHJ1Y3Qgd2l0aCBmbGFncyBmb3IgdGhhdCBpb2N0bCBt
YXkgdHVybiBvdXQgdG8gYmUgdXNlZnVsLA0KPiBmb3IgZXhhbXBsZSwgdG8gdmVyaWZ5IHRoYXQg
dGhlIG5ldyB1dWlkIGlzIHVuaXF1ZSwgZGVzcGl0ZSB0aGUgZmFjdA0KPiB0aGF0IHhmcyB3YXMN
Cj4gbW91bnRlZCB3aXRoIC1vbm91dWlkICh1c2VmdWwgSU1PKSBvciB0byBleHBsaWNpdGx5IHJl
cXVlc3QgYSByZXN0b3JlIG9mIG9sZA0KPiB1dWlkIHRoYXQgd291bGQgZmFpbCBpZiBuZXdfdXVp
ZCAhPSBtZXRhIHV1aWQuDQoNCkkgdGhpbmsgdXNpbmcgYSBzdHJ1Y3QgaXMgcHJvYmFibHkgYSBn
b29kIGlkZWEsIEkgY2FuIGFkZCB0aGF0IGluIHRoZSBuZXh0IHZlcnNpb24uDQo+IA0KPiBUaGFu
a3MsDQo+IEFtaXIuDQoNCg==
