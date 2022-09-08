Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BF95B27AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 22:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiIHUYK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 16:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiIHUYJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 16:24:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD81112136;
        Thu,  8 Sep 2022 13:24:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288HJM7e012363;
        Thu, 8 Sep 2022 20:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Q0EhrsC8J6dUO4y5adoq+GLe1rX/J2u0VitsFj5DW6o=;
 b=I0cSGwpmtOTsg16jC1vyrsCKzglFAqm7HEygTk3NZ1m/qLMsrcSQcdWp6NHc+egn1xpt
 YaSWFhPC7vs3V9++AhFZfJHSg/kNDEsiDoRIu9hf/UVNRC2cYwNrs0OPefXujVs0phGa
 pHiPozZ7Ul9amIoj0pBbI+HoCD0u5bFLfuDme0AJRV1sBYE0JOCxc3CBM32baPyRfI7J
 m1nMRWrM8ud8BJcGDk+JekSKq2M7AaL0EGh5SwRAdnfak1t/vAh4KURWAmsuP+j0oDxR
 dCV6+7c/6sXM+OYeoTgpX0HC6SBCAKZYfvvSdK69xcEItkpIAU+qrfL/nGrOz07vSWgx wQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1n2pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 20:24:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 288IHGAl019301;
        Thu, 8 Sep 2022 20:24:05 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwccqj28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 20:24:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgdMsbqVvMuGD0+GxSE+baqRVzGsnloq0u0uC7O4OMJnWCfwhmyqAyYYOoa0H9/CwckfLLKy4s/1ibBjBnQrBo9BUSY36dYifEAvirAiRUMUrHnOAueEI1INdT3flABn4osMkFrvyIc8jaeuzZNjp3RJnBHBwlBywi78z3I57v8jGZr1KCi2AsbOh7casT6CfMcfkekaEn1ouBk9v/5+DYE4zWygneFcZVtrZ1nzN9+D+Ct2KEzVimSOljsMg7ykBjuRAh0bzmbFWoSBSCpU2eImCe9XHeDwOkP52i2k+5KcyB7AbDr5nNHdlIhJXW6l03WLMjJHjDcdMvWRbzRWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0EhrsC8J6dUO4y5adoq+GLe1rX/J2u0VitsFj5DW6o=;
 b=gXl82JD72lEVGDPg3QGARDLBp8HcLTOOrHY5EWKaZr8HMMTiyox3CmPpK8d9XJDoyt9/1iCwgTtYxxHwCZegd6EAA+MizE22G3tsQOvU3J269xdo0vcNuZI36zpD4P0c01YjVNUxVgHxYg4VLpqPJiy9misP9fuBhB72Z4hu5A3ZhR6KW6E2o9YpP48keFAqa6KmZ76vL8jmfX35dER7ThcfpKBsQW277B7QDJFtQnabq7IjsGn1Uk2jKkRElT6ECsmvL2DjAYIJH0506C5M9H0o4YBcmfAM6WHNp26Peg/hvBbpYrU4DPgSggGWQy9BrHCbKOlGmL5hzvxAa7LH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0EhrsC8J6dUO4y5adoq+GLe1rX/J2u0VitsFj5DW6o=;
 b=RUlfLgXZzNlk6u6E6K6Cx8ydLUceuJt7SdW/qrOJtgiBnKsJCKbfqUpC7gKXuvpWErfdSw5fdN3m8lwkx51UeKh++It1pnc16y7v6Mn9BgSUEzDvp/OdjM/RaxbTetQxlU5kKp1uBZwwGx9rBRA8on/i/udL4mFKCYCdI91t5Zo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4630.namprd10.prod.outlook.com (2603:10b6:510:33::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 20:24:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 20:24:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     battery dude <jyf007@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: Does NFS support Linux Capabilities
Thread-Topic: Does NFS support Linux Capabilities
Thread-Index: AQHYw36p6D3ymO0jXE6pVWwFMO2Oyq3V+t+A
Date:   Thu, 8 Sep 2022 20:24:02 +0000
Message-ID: <1D8F1768-D42A-4775-9B0E-B507D5F9E51E@oracle.com>
References: <CAMBbDaF2Ni0gMRKNeFTQwgAOPPYy7RLXYwDJyZ1edq=tfATFzw@mail.gmail.com>
In-Reply-To: <CAMBbDaF2Ni0gMRKNeFTQwgAOPPYy7RLXYwDJyZ1edq=tfATFzw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4630:EE_
x-ms-office365-filtering-correlation-id: 82a30317-00b8-4131-e809-08da91d811bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gXDhRfY3peTuUAkG81c2Y8IVaH9K++FruZD3gKUFbnpFljPugCXU8DuLOoH42RDfPpzqvqCePXmso0xaeAeyQfuJDNQROHfDq0vxn/xTwnaIiKlIDg3RGVTsVmBKXjuFqfLEEyrEPFzl7VhkPgsNhCNEkWYF6TX0XrDY7DYYz7kZfM0Lf2HqiLXC5VW927WGBzNzRALjSv0wNF6cJmPEAk+dB02pSDgqIIZx2JiHH/wl1jCS+a3Y0JT6Qsoc8AHvsU9USyUFri6TrjlKELlDI7tpGmKZLzM0c9Njl/KFuJHdQdwVrbgPLjxuJbk+tNkFljTbV3zv+p2PB8payLHGseC88DSIiXTFMjUQ7OXfT8v/oDX1L3efRk5pK5U3pb7JY/okUEXDEEy6d8x/7KHHZN2Q/Sw2rbRXFRKrct+go+qLZ+1Yx6PFUcTseRKjPQAeG83h7zdRplTcFKMXfEcVQGZVQUDN7JtOcBExYNiItzOAPSDm/BUHTHtp5fnw1tVu5fi2MyM7BBfYJ/2Lhiy7fypsDKMMENhB7rz2rdQ/mLNTZKqa/WAEq8NRvH5SWvxa5AvgAF9Zgwu4nW1i9urN5tFPbwG3THnkKpGmRrFqlQfbWLQzlcOaKO73MTnnBE+sMFXfRMFm87JO4poQhP7Uuzf2lLl1WFzVFftonvFC/8gjKb8Couawm+zwBpgoL4Y8zEXMxAMdXO402zhLTWboilvwfH38z04Fl04CzsQYkmrhcQrOI2uDCLUx1zWocEaxZV91X2ycuMa2UyO8UzpOse1EMRpH477RWhUPVpsHS5oVUTTcbOqsvXoNho1bx60xZiRkRqc3FFsja0fcVQL0Qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(396003)(376002)(39860400002)(66574015)(38070700005)(66946007)(54906003)(2616005)(6486002)(966005)(6512007)(6506007)(26005)(53546011)(71200400001)(86362001)(6916009)(316002)(36756003)(122000001)(66556008)(66446008)(478600001)(76116006)(4326008)(64756008)(91956017)(5660300002)(8676002)(66476007)(38100700002)(8936002)(41300700001)(2906002)(186003)(33656002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXdVSXdBcjRSNWhKaXRLVG5jZFZKakdKbjZ3cWxUU2xDc3Z6TjZ6M0gvQjh0?=
 =?utf-8?B?dlpTMExvNWw4WFB6Z2FBb1lJajZQVHVoU2k1T2RiWEZwVHNkdFFUZUM0S1A2?=
 =?utf-8?B?K2xTenlQUTFJeW9KYjZObkc4MTlyQ1dGVEhHYzZYSFlBM2doWm01a21GNnVY?=
 =?utf-8?B?YTZydm5uTGhWTXQza2ZuRHh6eFdqb216YUdaOVR1QU1Ic1p3NERaL2YwWkw0?=
 =?utf-8?B?RDRjRVpvVzVoUmVwUld3YzNRRjZZLzcwRWtCMmVkSVpjajFxS3A2NUxTTURD?=
 =?utf-8?B?K2lnUDIvY1RHWUdzYWVWQzdUZlNYRUl6L3lGV0hLWFJqRkN0d1ZsMlFzTmZB?=
 =?utf-8?B?RDNveVphMks2ZXQyc0hKUDE2RFR5U08wdUoyWE8xTGVmbFQ3OGVLcDdyK0Rk?=
 =?utf-8?B?NEJwaVB6dkhIN2dFMnJrRWx1NG1NWjA1WmZ0c1FqOC9XaDlaTjNYMmhsYWp1?=
 =?utf-8?B?QXFpaHorcytRMEFITmx6NEluVWxqZlJpL2d5d3Nsb3ptWVUvN0t4Qkd5em85?=
 =?utf-8?B?WVV3eU1HaWVlOWtOM3RTNW9QbXh4Q1VlM1dPQ1BtRksvbmlGRW00NzNzcXcr?=
 =?utf-8?B?V2NXNWY3OEh4dkhBcnpnZ1AwM0dRVXRQWGZTSGNXYStOYVRsZDN5ZUlodHlT?=
 =?utf-8?B?Q3JQR1Q5aUdzY1REK1FCaHI2d3ViMUoydEdtYXdxWmU5aGVWSXV1RXZ4dnd0?=
 =?utf-8?B?Z1NDZUd1cmt5aURiTU5IRmtTb1hBeVVnVktMaWx4WmRQK20wcFZuSnR1QlFy?=
 =?utf-8?B?aTdvMUh5d3NsS2U5N3pRRU4renBYcmhNTHYrWVJvK0Q3c1F3SUZoNVpxdE1u?=
 =?utf-8?B?eFJPVW1MSG9YTVRtcFBabHdOY1pzVXA1dURaTWJZVk9IRTVabDl1QU5rTlU3?=
 =?utf-8?B?MmNqV0pyYUk1MEk5Z0lyVnhHbXFZTVAzSmlGNjNqeVJCZGRRaEszSzJ2eWtw?=
 =?utf-8?B?WXlEckJwUUUvd0Ura3BpMlpQdkR5YjdVcDNWRlhUMkxwSEVoZ3h3RjlSeWc0?=
 =?utf-8?B?cUhhMmRhMVA3L2wwNi93ek5GSXUxZktkTDhJenhaQVNBMUlidHdZSkFUZ2FP?=
 =?utf-8?B?d3ZqTmtRSlNEWFBEMUZkUjNRZHh5NmgxUjUvVHVRYkJtWXoxMTVJdzJPbEtD?=
 =?utf-8?B?aldFaFlKOVl2S1RVSHJFQmZHQnZtZlpyZkZEUDN6dXY2cjR6Wm4vY3Vaanph?=
 =?utf-8?B?bEVTYzcwcnN6N1pPb0ZKUGhqK2VrUE9jbzQvTXpLb1Q5c1BoeFRESnJoaTdx?=
 =?utf-8?B?YVJtd05ua1lkamZMWDJMSm9ySzZ3UDRLSnF6V2NOZjFPQU1qU0xJVHlrM3Jp?=
 =?utf-8?B?ZXlFQm0wM2h4OFRtZkRVVVZYRXJUSU9LVUlyY0xyamZST0ZJNGkyRGFXT3pr?=
 =?utf-8?B?TDNyQklpVGhNMnlpanp2TElvNjFZTGNFZ001ZGJ2bVQxNk9VNExsTjNJY0g4?=
 =?utf-8?B?NG9PMmNzVUpWYmpHNE04dUM0OHpudGNqL3pXVXFOaCt0RGFnb3ZwaUlMeGhm?=
 =?utf-8?B?RVJXSWREY1VxeU1ZQnliZkpOMFQvS3dOV2h4UmhaWkRtR3p5WUxBQWpMdWJx?=
 =?utf-8?B?bW8zeXRic2d1bmF2TnNxTEpRSXAxMEJWZ2RaaHdkUlJxd2NJZUwrZFJvNm5L?=
 =?utf-8?B?MGJqbkxadTRrMGRhSWVSdkd5ZjlnL0FxSDRMM3dYZXdXcW93TzZFbEVBQ1o0?=
 =?utf-8?B?YnQ5ZWN4WUFZcVlNckI4M0dNUFBHMzNCR0tCRW9OS3duQ1FKYlVzaGQwNWlu?=
 =?utf-8?B?azFJdGkxaXhrS1JDNkFFWmtteTlwZ3drK2F3VStjNStqUHV1cmx5bFpMcWZ4?=
 =?utf-8?B?ZGFKd01pdlIvZk54dXFxNEZVZWlVU1M3NWo3U0ZrbEt3WE8wZG1aa09LZEIz?=
 =?utf-8?B?bkxuaDU1UXczajkvV1QweVhIRUhESTBTNlkrL1FkWUY0dXErUlMwQ0swYkhq?=
 =?utf-8?B?SG05bzZaWmwydEc5WkRsNkYvWkQ4VEtrT0JZZURuQkczbHF3VElZUkZsTHBV?=
 =?utf-8?B?TGpYaElOL0ZydUhVQWFYaDgyYlZOKytwelZNMTVPaThwY3ZzbTVBbnNTcHpY?=
 =?utf-8?B?b09Hd2YvTUVoUFJmbmlNdTdpVjVEcUo2ZittSU5oc09zQk4yTDEwbFdZRHFy?=
 =?utf-8?B?dm9vdUZCUGtqU2o0SGJSY0lhTlY1NlcvaHgyQWloOUpTcGFQcVJ5SDVqQWQ4?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9716D63F52D01248BF3A95390CD7A19C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a30317-00b8-4131-e809-08da91d811bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 20:24:02.2590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2E99C9P7E21zrj19Y/Zo7qL3k7z0qtV32mW4zTYESFlEudJLyHSnyLwWVwYIGPSUaCXLT3p7L07ElKHp1/gzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080073
X-Proofpoint-GUID: rykopenLqu1T4sDBlpTsOlvPWG9r0FwB
X-Proofpoint-ORIG-GUID: rykopenLqu1T4sDBlpTsOlvPWG9r0FwB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

WyBUaGlzIHF1ZXN0aW9uIGNvbWVzIHVwIG9uIG9jY2FzaW9uLCBzbyBJJ3ZlIGFkZGVkIGEgZmV3
IGludGVyZXN0ZWQNCiAgcGFydGllcyB0byB0aGUgQ2M6IGxpc3QgXQ0KDQo+IE9uIFNlcCA4LCAy
MDIyLCBhdCA4OjI3IEFNLCBiYXR0ZXJ5IGR1ZGUgPGp5ZjAwN0BnbWFpbC5jb20+IHdyb3RlOg0K
PiANCj4gQWNjb3JkaW5nIHRvIGh0dHBzOi8vYWNjZXNzLnJlZGhhdC5jb20vc29sdXRpb25zLzIx
MTczMjEgdGhpcyBhcnRpY2xlLA0KPiBJIHdhbnQgdG8gYXNrLCBob3cgdG8gbWFrZSBORlMgc3Vw
cG9ydCB0aGUgcGVuZXRyYXRpb24gb2YgTGludXgNCj4gQ2FwYWJpbGl0aWVzDQoNClRoYXQgbGlu
ayBpcyBhY2Nlc3MtbGltaXRlZCwgc28gSSB3YXMgYWJsZSB0byB2aWV3IG9ubHkgdGhlIHRvcA0K
ZmV3IHBhcmFncmFwaHMgb2YgaXQuIE5vdCB2ZXJ5IG9wZW4sIFJlZCBIYXQuDQoNClRMO0RSOiBJ
IGxvb2tlZCBpbnRvIHRoaXMgd2hpbGUgdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgaG93IHRvIGVuYWJs
ZQ0KSU1BIG9uIE5GUyBmaWxlcy4gSXQncyBkaWZmaWN1bHQgZm9yIG1hbnkgcmVhc29ucy4NCg0K
DQpBIGZldyBvZiB0aGVzZSByZWFzb25zIGluY2x1ZGU6DQoNClRoZSBORlMgcHJvdG9jb2wgaXMg
YSBzdGFuZGFyZCwgYW5kIGlzIGltcGxlbWVudGVkIG9uIGEgd2lkZSB2YXJpZXR5DQpvZiBPUyBw
bGF0Zm9ybXMuIEVhY2ggT1MgaW1wbGVtZW50cyBpdHMgb3duIGZsYXZvciBvZiBjYXBhYmlsaXRp
ZXMuDQpUaGVyZSdzIG5vIHdheSB0byB0cmFuc2xhdGUgYW1vbmdzdCB0aGUgdmFyaWF0aW9ucyB0
byBlbnN1cmUNCmludGVyb3BlcmF0aW9uLiBPbiBMaW51eCwgY2FwYWJpbGl0aWVzKDcpIHNheXM6
DQoNCj4gTm8gc3RhbmRhcmRzIGdvdmVybiBjYXBhYmlsaXRpZXMsIGJ1dCB0aGUgTGludXggY2Fw
YWJpbGl0eSBpbXBsZW1lbnRhdGlvbiBpcyBiYXNlZCBvbiB0aGUgd2l0aGRyYXduIFBPU0lYLjFl
IGRyYWZ0IHN0YW5kYXJkOyBzZWUg4p+oaHR0cHM6Ly9hcmNoaXZlLm9yZy9kZXRhaWxzL3Bvc2l4
XzEwMDMuMWUtOTkwMzEw4p+pLg0KDQpJJ20gbm90IHN1cmUgaG93IGNsb3NlbHkgb3RoZXIgaW1w
bGVtZW50YXRpb25zIGNvbWUgdG8gaW1wbGVtZW50aW5nDQpQT1NJWC4xZSwgYnV0IHRoZXJlIGFy
ZSBlbm91Z2ggZGlmZmVyZW5jZXMgdGhhdCBpbnRlcm9wZXJhYmlsaXR5DQpjb3VsZCBiZSBhIG5p
Z2h0bWFyZS4gQW55dGhpbmcgTGludXggaGFzIGRvbmUgZGlmZmVyZW50bHkgdGhhbg0KUE9TSVgu
MWUgd291bGQgYmUgZW5jdW1iZXJlZCBieSBHUEwsIG1ha2luZyBpdCBuZWFybHkgaW1wb3NzaWJs
ZSB0bw0Kc3RhbmRhcmRpemUgdGhvc2UgZGlmZmVyZW5jZXMuIChMZXQgYWxvbmUgdGhlIHBvc3Np
YmxlIHByb2JsZW1zDQp0cnlpbmcgdG8gY2l0ZSBhIHdpdGhkcmF3biBQT1NJWCBzdGFuZGFyZCBp
biBhbiBJbnRlcm5ldCBSRkMhKQ0KDQpUaGUgTkZTdjQgV0cgY291bGQgaW52ZW50IG91ciBvd24g
Y2FwYWJpbGl0aWVzIHNjaGVtZSwganVzdCBhcyB3YXMNCmRvbmUgd2l0aCBORlN2NCBBQ0xzLiBJ
J20gbm90IHN1cmUgZXZlcnlvbmUgd291bGQgYWdyZWUgdGhhdCBlZmZvcnQNCndhcyAxMDAlIHN1
Y2Nlc3NmdWwuDQoNCg0KQ3VycmVudGx5LCBhbiBORlMgc2VydmVyIGJhc2VzIGl0cyBhY2Nlc3Mg
Y29udHJvbCBjaG9pY2VzIG9uIHRoZQ0KUlBDIHVzZXIgdGhhdCBtYWtlcyBlYWNoIHJlcXVlc3Qu
IFdlJ2QgaGF2ZSB0byBmaWd1cmUgb3V0IGEgd2F5IHRvDQplbmFibGUgTkZTIGNsaWVudHMgYW5k
IHNlcnZlcnMgdG8gY29tbXVuaWNhdGUgbW9yZSB0aGFuIGp1c3QgdXNlcg0KaWRlbnRpdHkgdG8g
ZW5hYmxlIGFjY2VzcyBjb250cm9sIHZpYSBjYXBhYmlsaXRpZXMuDQoNCldoZW4gc2VuZGluZyBh
biBORlMgcmVxdWVzdCwgYSBjbGllbnQgd291bGQgaGF2ZSB0byBwcm92aWRlIGEgc2V0DQpvZiBj
YXBhYmlsaXRpZXMgdG8gdGhlIHNlcnZlciBzbyB0aGUgc2VydmVyIGNhbiBtYWtlIGFwcHJvcHJp
YXRlDQphY2Nlc3MgY29udHJvbCBjaG9pY2VzIGZvciB0aGF0IHJlcXVlc3QuDQoNClRoZSBzZXJ2
ZXIgd291bGQgaGF2ZSB0byByZXBvcnQgdGhlIHVwZGF0ZWQgY2Fwc2V0IHdoZW4gYSBjbGllbnQN
CmFjY2Vzc2VzIGFuZCBleGVjdXRlcyBhIGZpbGUgd2l0aCBjYXBhYmlsaXRpZXMsIGFuZCB0aGUg
c2VydmVyDQp3b3VsZCBoYXZlIHRvIHRydXN0IHRoYXQgaXRzIGNsaWVudHMgYWxsIHJlc3BlY3Qg
dGhvc2UgY2Fwc2V0cw0KY29ycmVjdGx5Lg0KDQoNCkJlY2F1c2UgY2FwYWJpbGl0aWVzIGFyZSBz
ZWN1cml0eS1yZWxhdGVkLCBzZXR0aW5nIGFuZCByZXRyaWV2aW5nDQpjYXBhYmlsaXRpZXMgc2hv
dWxkIGJlIGRvbmUgb25seSBvdmVyIG5ldHdvcmtzIHRoYXQgZW5zdXJlDQppbnRlZ3JpdHkgb2Yg
Y29tbXVuaWNhdGlvbi4gU28sIHByb3RlY3Rpb24gdmlhIFJQQy13aXRoLVRMUyBvcg0KUlBDU0VD
IEdTUyB3aXRoIGFuIGludGVncml0eSBzZXJ2aWNlIG91Z2h0IHRvIGJlIGEgcmVxdWlyZW1lbnQN
CmJvdGggZm9yIHNldHRpbmcgYW5kIHVwZGF0aW5nIGNhcGFiaWxpdGllcyBhbmQgZm9yIHRyYW5z
bWl0dGluZw0KYW55IHByb3RlY3RlZCBmaWxlIGNvbnRlbnQuIFdlIGhhdmUgaW1wbGVtZW50YXRp
b25zLCBidXQgdGhlcmUNCmlzIGFsd2F5cyBhbiBvcHRpb24gb2Ygbm90IGRlcGxveWluZyB0aGlz
IGtpbmQgb2YgcHJvdGVjdGlvbg0Kd2hlbiBORlMgaXMgYWN0dWFsbHkgaW4gdXNlLCBtYWtpbmcg
Y2FwYWJpbGl0aWVzIGp1c3QgYSBiaXQgb2YNCnNlY3VyaXR5IHRoZWF0ZXIgaW4gdGhvc2UgY2Fz
ZXMuDQoNCg0KR2l2ZW4gdGhlc2UgZW5vcm1vdXMgY2hhbGxlbmdlcywgd2hvIHdvdWxkIGJlIHdp
bGxpbmcgdG8gcGF5IGZvcg0Kc3RhbmRhcmRpemF0aW9uIGFuZCBpbXBsZW1lbnRhdGlvbj8gSSdt
IG5vdCBzYXlpbmcgaXQgY2FuJ3Qgb3INCnNob3VsZG4ndCBiZSBkb25lLCBqdXN0IHRoYXQgaXQg
d291bGQgYmUgYSBtaWdodHkgaGVhdnkgbGlmdC4NCkJ1dCBtYXliZSBvdGhlciBmb2xrcyBvbiB0
aGUgQ2M6IGxpc3QgaGF2ZSBpZGVhcyB0aGF0IGNvdWxkDQptYWtlIHRoaXMgZWFzaWVyIHRoYW4g
SSBiZWxpZXZlIGl0IHRvIGJlLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg0K
