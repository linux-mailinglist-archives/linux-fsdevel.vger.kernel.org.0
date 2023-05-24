Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FA470FD3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 19:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbjEXRw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 13:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjEXRw4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 13:52:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A46D3;
        Wed, 24 May 2023 10:52:55 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OHdthB007611;
        Wed, 24 May 2023 17:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=a5z3jYeo11BCACDq+iGgV+Sqj1w1KILDEwmkXR0CCrI=;
 b=lIx39pWkxvckP0OIsCizgn0IkSvLyVDhCTGGN4dhyEcluZrP+ASPCY0XqvqwXc0QVqLX
 3oP5heS7u/D9ET/gw9p7qjakvdjPORIrdj4GNj56uwWMxrEzpdazAF8KCAC47t8oFsBe
 ZMaq4SwQSaDL8GXPI65+6k7qPgrXrA+mEOacaMw5dlPT1vnY8HFwFNqGfsfOs0nLTKjD
 wlfqff18+jjVPoy/yFEL5z92xesRhqi3kFXGqC0tLDjV0zdhPHMJHcfnS39vq4U6Jnwo
 +7XyoWFw1QZciwLdWs5DqqRi7nihZe//R9JShD2he18GnoV9b3ItYdQ1OAtfzKZE1ybd JQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsq62g13m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 17:52:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OH6NjI028926;
        Wed, 24 May 2023 17:52:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2ck0ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 17:52:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnImEFTdx9wxaqi+jerlb8ebE83HZNIkzpqAwT2UeWJVpKD1/12/jxpVDwFA8fDaXrDxDzMs3Me3jvCo8LKyLXpdS35iJ2TWY8BotIIsR7OXW5k+N77Od5te0A9Bn4AfbyeK4reIej+kd3/Ftxo4ZNiZvOGt5p5H6XEEB/gicY+dUXPbgNxi3F1tGqm0x1Fyvzw4VXeCLbLBuccgrhvJNIyMQrIBICXwz8+toZIlzNKA8BOybdypjUNy885N8mEwbYmgfAk1OSxsK2Tc5L1jdKcjvxc7yXOOrj8lbvQg4ETQsH2tKlWi3RK0OgRQmkVqgNwcKsl2y7JZkiHCekSpnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5z3jYeo11BCACDq+iGgV+Sqj1w1KILDEwmkXR0CCrI=;
 b=XawAMbVi4MXh5LCJhBugPIL/Bg0weP8nnO7moGWifnOAawtVCAal4NY0FLq87mTEuTvXkZdfjVQb74tW1DksalIm+N01b7+UvFysaELJE/XeKMz3kHKt859GfiXrDqykkvLIPqBvgqEYsv8tdFDFYLdXDcDBqePRPZOqAsSHgqCGF9TT2Q2j+QjjOZAmn9VhI/cTMxrnZ66ApaPCmrmTmFiDWjOjQCAuAnuq5Wq7FMgR/xhK0khxiJ50qEVuyeIFdiRde07bj4e8sf2oO8C5TjvRmEELIXAJ2uJ4okbNhQbpPihlPWRwrwID1C9gDH/x2KLcTAazQavKdB2eys9IIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5z3jYeo11BCACDq+iGgV+Sqj1w1KILDEwmkXR0CCrI=;
 b=Chvxei8wrdcCjpZ97/BgfesotvOcCClTzW3jpJ+zaWMXm7he+ycLt+g/nkwCtBwdJsWtwiOuFtV3Mg/XIfPCnapsHbb3GSMmDuEkjzvbeS0IXrroqz5td1AMRlJizhYGGsvzOYtXYtEXEzg6L2wyYWgdH0a7QwvcWWN0bHx2p6U=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 17:52:50 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 17:52:50 +0000
Message-ID: <78348390-c5d9-f6e1-de8b-ec2b60f8a185@oracle.com>
Date:   Wed, 24 May 2023 10:52:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/3] locks: allow support for write delegation
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
 <1684799560-31663-4-git-send-email-dai.ngo@oracle.com>
 <32e880c5f66ce8a6f343c01416fcc8b791cc1302.camel@kernel.org>
 <D8739068-BCAD-4E47-A2E2-1467F9DC32ED@oracle.com>
 <bc960c7251781f912d2d0d4271702d15f19fb34a.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <bc960c7251781f912d2d0d4271702d15f19fb34a.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0613.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::19) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|MN2PR10MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: 6621f576-f710-4adc-ffda-08db5c7fb0e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P59FF0ZHJO0ynTgr1E2O172QnUXMaUt0Ua3M7DfDmd4NbzCjOtg6KnrVZFsXp3vcKOWihM58dJLyU3XyI8kYk9Kgymp3F2pEPSCen+3qspf28MzveiHqnViaNsGRDcJbp2X7tpNHjtk7H+BHJbQzmJtlm0qiGbQRablbrOdAJYzdEiajtSZf/vHDbOHfNs28LHKA4Obmo1NtyJl1Lk9P2HG683I/u8jZNRLQXCC7P7P5ZsRByRdnCcrsmukbdeOQlmV8N+dbBxxBIvsKw4FyKzY2TJSVNgsVP3uCgbeVTBW50idGC+pE0ok1do1Bp02aXhMcGZlRlu9BJOJ5zSJg0YMhEu2M90XmVN1iZpkoWDRcsdAp6JVFNE4ae44c+Rc7hhn+c0XGkxL5LJODO78Od6OXPkB2urv/F+TbHURd9gi2vfBLdASAllnjPAGAIoijC7wRfsjP0me+Drqbg958i+55iG0b2oH/ecposHAC3JXBpv2oI+HvQKhq8uYp4bAdkr091zJsQcFk0E+5To5O6WOypg4MD3pi3rpU7L9ONhNg7wMiFnOk4y/XQHKb9A767PbGYMVaQni1Sri+CccQMQxBU8BIDvGYSe3GlIwm1ojO2sPeQ53z4dvQ55ZQYKhG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(41300700001)(66556008)(66476007)(66946007)(2906002)(26005)(186003)(478600001)(4326008)(6666004)(316002)(6486002)(31686004)(110136005)(5660300002)(54906003)(6512007)(8676002)(8936002)(53546011)(9686003)(36756003)(2616005)(6506007)(83380400001)(86362001)(31696002)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjJ6aVV3bU03aTRHVFU5WVQvUTZQckNnVUxXUFdXeFRaazZIRk8vSlpJamdG?=
 =?utf-8?B?cDB3by9nSWx1ZUkrNm5tT21mZ1JiUFl1cG5KcFAzc2JIeHBlTFN2ejRwTlNS?=
 =?utf-8?B?Q3RzcnNtSDdjcnd1bHJoMWszOXd3cDI3QUthVmsvU0FWdlVIQ3lCd0czRlFH?=
 =?utf-8?B?YmZieEhBeStwbVVBSHdnT1ZjZXhCTGZxZjErcjlCbDdKbmY3M1d4M29QQmJt?=
 =?utf-8?B?RXdScGxSeHlCeDQ1eUdLVkNieHE3eWlHZFlCRjludWV6VlNadjNmOFRzcUhW?=
 =?utf-8?B?UHU0NEoyb1pzRitPOEZvcHV3dmVUSlMzZ1h4ZWRXdzAxQmF2MUZTV0ZxenpP?=
 =?utf-8?B?TEtUbXFyNDJJbHpNZUlMajZhZWsyV2Z1R1lqRHQrZXlvZW5KWXlDdzNyWWV6?=
 =?utf-8?B?Sm5pcVZzMzlFZ1NWUHFvSEJhVUZZZC9Db0pIQXc5NE9hdHcxcHd5MFJNODdh?=
 =?utf-8?B?aFY3YzdOYXNEZVNYODB3QmdzbkxNL0Q2K2xlTWRaemhjSEppRzMvOGlUZ1Nn?=
 =?utf-8?B?ZXp1SXZ2eEkwdDRQOUtCN0pWL2lodTNhYXloWXErbERBMnJManBrcks2R09m?=
 =?utf-8?B?dm9YQjJrMkNtenZaMFczQVVVaGlHRVp1L2xhUVp3am1GMUp4VVNsekppUC9i?=
 =?utf-8?B?TXExYnJYeVRTeGhlN0gzTGJWNlhZMTRzRnR4dFdCZkUzYTYrL2JPNmhLSm5Z?=
 =?utf-8?B?SUVqb3RMSC92VkRZcjZHT282YjlTc3pqR3Qrc0t3Z1BzeEdzZEE3RHg4T211?=
 =?utf-8?B?akJSSncyQis2M1oyc0dSZ3pEc1NUUnEzRFh4emZld1U4R0pPRERiTDFBRlJ3?=
 =?utf-8?B?NzlRcCtxcU9TRS92Rm5KMDJrUXR0azF1ZnVpRDBHVTZhNDFkSDBTaEVjamF4?=
 =?utf-8?B?cVJ3WFJXYlBoeEFTSlg0d1MrS3VTUjhkb0haVHFBa1RZSytSNkd5UW1PTjFa?=
 =?utf-8?B?Zit1Tm1Ib2lmUjhNSU1lS05ONkRXUHJjYUxpQjdycDFkK0R5b1JSdmx0akd6?=
 =?utf-8?B?anFaSGxXMjhycnhia0VveTdmOFhFUmo1RUVBblV4MGppN1Z0QVorN2dHTUJx?=
 =?utf-8?B?OHIvdVRodnFLMk1HU1ZodU5GMVlTUDBWYzJ6MlNyRzVWbnUxdU1yMzk3VHFN?=
 =?utf-8?B?bEU1Yy83UlFGOHV5d0tPbVZIc295ZUtTcVFqN3V3emd0aUZrOFlhcUUyMFgy?=
 =?utf-8?B?eUpsRDZ2NnRJeldaalBUTzZsYnhjMmVoQUZkZHo5TzlNemlaZ0ZpeFZ4dWx2?=
 =?utf-8?B?cnAyMWlTOE9TMklPSjRqNVZkczhBdGZTWFVZL2xhV0g2SVBVck53RGg1UmlL?=
 =?utf-8?B?bVZmd2Ftc0dwckIwY05CdVZUZDNpN1RUN0VSMjVRTC85MVdWRzU2SGgxZGl5?=
 =?utf-8?B?dWJpYnExdnhVWXV1SlRqdTc5THRZcUZXL2Jtbis4UlNtQ2tya2NEOFN3QjZH?=
 =?utf-8?B?bXordmpxOGZUYk9aSkZnT0daVEp0TE92MVJEdzRCOFZTeU93aUtZYnpWYjJq?=
 =?utf-8?B?Rno0YkJzT2JvTXo0MVM2eTA3VlZxUzc2RzJ3djNXMS9tY05aOXpkSWlKRmdH?=
 =?utf-8?B?SE1RTVpPRzZvTUFzeHdWaWpSWXNsWVhEU0t5aE8rcVVuVGZxUHRvQzRpM2Fo?=
 =?utf-8?B?cWhzRm9hOEtENHVwRXNhTDltd2U2Q3ZPdURQZEl2VzNEN09OQ1U0aDRJOUd2?=
 =?utf-8?B?NHUvc0Z6a2FvTE1ScHFycStUVGdJVDJUWHovbG95ajBGY3NuS0kwYk1zSHJt?=
 =?utf-8?B?anc5NFNuRHUwSE5PRDVMeEJtcnRUQnFkbEIvWGFrelVoejF1UjNUT2h2OXlD?=
 =?utf-8?B?QjlyemUwVmFVbHJ1STBIenNwTFM1OXZVdWFYZ0pQS092cW9iZXcycUpobzNS?=
 =?utf-8?B?NDNSZnRkYmJTdmVSd01FYWp2WDBuNlFpYzAzMmpwLzJoTjF4Y2ovVno4UUZE?=
 =?utf-8?B?MWVjRFdUaVhxY3FGb1djeC9CQk10Y0IxcG50V2VDdTY2azB2ajNLdzdXTHl5?=
 =?utf-8?B?c2xBdlVKRjNOKzNzdkpWdzRSUytwMGJHazBwNGpLOUxxRXhoUEhuMnNSZ2g1?=
 =?utf-8?B?UVpqOG9YT2xrWER5QytxVEJsZU9kVmtsWDFiaEJaczNGY2lEeHM1cGI4aFZI?=
 =?utf-8?Q?2++Tr8AHwV+Cmbp+4pyDT06mV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g9GeGLXyLMFyFQ+8f6KXQjlJZH2DY2NmXMH8wWcnM9KUL9cpZ7qBH5XOpk5MSTvSFhy3kyB9TvNW988omATJA33KAqxeG/EoD3MqX2FZsgBfXWciuwTgGSFRQE8eg/X3TbRXsv3LBr5aiHMajGtQUfXOys41I1JAoBxpSNDWepHLe8QibtZ49ig8oVEHrCcHlaqOKb6VBD95RyYnhDfHJYNscFtXbjvFedbpbveNdlKTI3lkO242HAKv9kDZU2nKFdqEKzZHeHiY9LKorOQpajpZLB1ZwTDZxjgl9LgGa20tpJN7LDcKKm3hQaJIAMbJ7ZMZK1z7f7QmpfIonuskfz7e/bMZVJdRvpgY9X0XkWhQ6SGiQrHIn5aDbgPdStrkCLIlyZjUvQEpUv5oo9J/CSfKd/LGz6JRgExZvy6WWAUl7pzoH7CAoFJGdnUh6b0/vNbQsafZwbGlIrx7bUQAARCbtQqfIN2ZcsbBejLhhGE7bOznKCOznk8es52cX+hFzESs8L6d2y1mnt/9QGR4voDTqxBE2c69pKzgAZd+zu0SzfZ8kcK8SvPeueJO3M3HlUGlmz9AnNUzhxBvhcmw0or/sbRlfaJfLnM/WgDDtlqJ42pt2Q+428Fdca7SGB18oKWXh4MP/nAE7DS2BdC7y67F1CF0W/bTL5evH2pcRPtMOHVPXfs07CZJJg0WQh5Lr3PWY7LCGuawf8Py+H9u+IiMRREXCgW6x0Na0OE17z2lrZXuf3HJ5R8fOLjNMpYQHM3eo/8f8MMvfTzEhyK7z143JOYI67stBXWy+pQCxWo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6621f576-f710-4adc-ffda-08db5c7fb0e8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 17:52:50.4580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQX94tZwQYyOtk1S0jckP9LhWRZAWOR57epB+pD5DxcDtNCABeJjsOQWLDdLh7lk0rj6nkJuzlPUvwRr6fSqFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4270
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_13,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240147
X-Proofpoint-GUID: XnRyJuj-fHqvIWEJZI5h10C-DWE-GDOf
X-Proofpoint-ORIG-GUID: XnRyJuj-fHqvIWEJZI5h10C-DWE-GDOf
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/24/23 9:55 AM, Jeff Layton wrote:
> On Wed, 2023-05-24 at 15:09 +0000, Chuck Lever III wrote:
>>> On May 24, 2023, at 11:08 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>
>>> On Mon, 2023-05-22 at 16:52 -0700, Dai Ngo wrote:
>>>> Remove the check for F_WRLCK in generic_add_lease to allow file_lock
>>>> to be used for write delegation.
>>>>
>>>> First consumer is NFSD.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>> fs/locks.c | 7 -------
>>>> 1 file changed, 7 deletions(-)
>>>>
>>>> diff --git a/fs/locks.c b/fs/locks.c
>>>> index df8b26a42524..08fb0b4fd4f8 100644
>>>> --- a/fs/locks.c
>>>> +++ b/fs/locks.c
>>>> @@ -1729,13 +1729,6 @@ generic_add_lease(struct file *filp, long arg, struct file_lock **flp, void **pr
>>>> if (is_deleg && !inode_trylock(inode))
>>>> return -EAGAIN;
>>>>
>>>> - if (is_deleg && arg == F_WRLCK) {
>>>> - /* Write delegations are not currently supported: */
>>>> - inode_unlock(inode);
>>>> - WARN_ON_ONCE(1);
>>>> - return -EINVAL;
>>>> - }
>>>> -
>>>> percpu_down_read(&file_rwsem);
>>>> spin_lock(&ctx->flc_lock);
>>>> time_out_leases(inode, &dispose);
>>> I'd probably move this back to the first patch in the series.
>>>
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> I asked him to move it to the end. Is it safe to take out this
>> check before write delegation is actually implemented?
>>
> I think so, but it don't think it doesn't make much difference either
> way. The only real downside of putting it at the end is that you might
> have to contend with a WARN_ON_ONCE if you're bisecting.

I will make this patch to be the 1st patch, we don't want the user to
get WARN_ON_ONCE when bisecting.

-Dai

