Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F27F4ACB71
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 22:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241470AbiBGVlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 16:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbiBGVlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:41:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA8CC043180;
        Mon,  7 Feb 2022 13:41:18 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217I7JIg020213;
        Mon, 7 Feb 2022 21:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=U6doz8I9dItKjJd6WH4FEk+YTAHELMyDnyKKMGBZwmE=;
 b=QATQgZx1hdcN/+Mqz6xYuZhvOPD7iIhmCca95Ot483CPAXSXD7iGYUKr1nfgunLb3l1S
 n+MWL1goK0rJEgPcvzGMEs1J1xoCeB4hTI/+KMlsYzm0bEtyoUDi65gFQrxc3T7BM1cc
 4iJEhuDXNqODvv3Vrlnvkhjz4bpyX46m5W4FijFSjf/Ww84xYE8LQqxhqg7HCQdmlMbe
 yCybY6kt2yOnRE8AypU+2NYdeReseSZjx0KLyuH592dnDHWK+8bbn76L4eTpUWmHwSPq
 s4Gz7hKTXWYfCJo41oDTuOQIzcxWpgODTAa0XmBcN+YlOkwomHxCwY1PBPFbgCPg66cp TQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wrwr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 21:41:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 217LZSXM065748;
        Mon, 7 Feb 2022 21:41:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3020.oracle.com with ESMTP id 3e1jpp7df0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 21:41:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RE70bKpyMpuGnzYPDZIUrtQ4vexMVrC2Xs0f/puG1pye3JxHu4HyKFoDj3c58ZJ/ce+DGpNF/HxQLPMlkh4a47/nA8yKZqyMpnWylcs7PX7G0XHVMWkrfPMx96WoNq+AhE8aII7aveGQtZvKuUxCObAKhC1ziF52DFTkiAj5KwE57XfSn/LEED87686BONRaS9y19B5zIKqjm8+frkXr1pOVfW5mCfhq5DWtCIEXa8ZsBU7jha8qJvvg1A05SLKZeei0FHuaTtmVE+ArFNIB4wRcBWZrKd5Yw7LupF+9Pe2668Px8aj6SetQ1n5gc6frH727NY6MaOsGPfFgUlkR3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6doz8I9dItKjJd6WH4FEk+YTAHELMyDnyKKMGBZwmE=;
 b=H3sFxnq2qIw5JwkZ9WVr9raHma8hTLIXjURrKKHJ3wTcrU6zG45LI+R4BrG9a9fZ3MM3GbjUfdFXAOnPs7BBSMkfaFgEg1khzmzmeVW5pdh0JOVX+EnxeFgDkFzt/sns020YgRipJ4BVgBSzaER+qwmhZqBIsbRa78n3mncoGLLMsZUU50k9gikkUkcd7hf1wAzvh9RS8jgsuJ77ovPfvTmG+rozFtnUJXVmuyaEmE63Z2g5U10xHZ4HgjxF6bh8iK0o54BQR2Yv/Ym5M8APcLTsx/GbTutB4Ar3OTbHFP4Y42pkrYWg6aJflNIBMRZ9j0FG7iOEme36XbRJ6MQTiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6doz8I9dItKjJd6WH4FEk+YTAHELMyDnyKKMGBZwmE=;
 b=T+Eydy2AAqnUNkArAO+e0V/R1/DnyPyV9DkmL3UBoZb55CSE0cBxv1yVO1a0UENlnT99vzqmJaUsxL75nYMf1vaZXxE1nFseWpOSuL/bWQZExlqVTt4f3M5OzTjFI3C2n2lVGL0qa27oyVyzkPZw1aQyG26uKFrGUm1GRHi/6Jw=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MN2PR10MB4063.namprd10.prod.outlook.com (2603:10b6:208:185::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Mon, 7 Feb
 2022 21:41:06 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192%6]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 21:41:06 +0000
Message-ID: <f7154cc9-ffc3-eaf4-df9b-1604b89b7a77@oracle.com>
Date:   Mon, 7 Feb 2022 13:41:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH RFC v11 3/3] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com,
        bfields@fieldses.org
Cc:     viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1644183077-2663-1-git-send-email-dai.ngo@oracle.com>
 <1644183077-2663-4-git-send-email-dai.ngo@oracle.com>
 <2321052ae1347a263ae03bbdb2c3cf04ba652338.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <2321052ae1347a263ae03bbdb2c3cf04ba652338.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:180::25) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 785305b3-2c69-4a75-6f22-08d9ea828b8e
X-MS-TrafficTypeDiagnostic: MN2PR10MB4063:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB40638411A0C3D3BBD1BAFE51872C9@MN2PR10MB4063.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IklmTkjmjGFGanGbyJDoKEKey3xFX8JrjO2mF0q6JWsuuY7zjc7EGbrJXHMAOb3iWGkDnt1VHQh1I8WqdtbhIQpg/ORwyDoZQUOV8EejpFmGs4JKGIYDqADVyJ46djLsxHXgfSVpR7AuDVjvLOqBfUY+qcVDRLyk0OdwqBj9OkarsCUSOpJB/S2CZDMyLjjKUNM2an19KmMB/VziPP1Bykz1zSE6P+5VuvbRTJIXOIcFFaesIqWfUst+DLITJw0hmlrxqvViwpSOGpi+tJinLN2rblJqsxh6vlVnJO4AMknUHxF6F8gULnF9R8Qp0G163BO3QsgX/DMG3GAU3q8xDSj4aFir3fAdUMSkCDhQXissxvsc65PnosbmCoROvgASzMx0xbh/2Jnao0s3lIVIJQuCXfbrpOn5p0wLU1beGzsOR6sOMego6Rz6b4qtJkSUdlqqfhDiXWj+EP6ZKs4Yk8Q4vxxD28cc9VOb8zrUuG11ON25nzwz8dOMsrM9ed2Rz1qqOys5ZaCKqs7zVwHBbEIGFASiL3WdLqLUsQDJJCLKY5Z0JVNYnfCVz8twUpfjHKl2LgK6P6EQo4/6gr1iXFPIupUFPSzM23eCwX+QL7eHAjRDpkxfRWCFJFbIhYTW/NM7C11IvowJh/jaKBlfgj35LYPb7lehJDLDgABiN/1+6hsWS7IfYoBbXWakzTtl5h7L/nuECI03WyR90+DY+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(30864003)(5660300002)(6486002)(8676002)(4326008)(6666004)(36756003)(6512007)(31686004)(6506007)(53546011)(2906002)(9686003)(86362001)(508600001)(38100700002)(2616005)(66476007)(66556008)(66946007)(8936002)(316002)(31696002)(26005)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWJUTHFQdTZaYnNtVHUzQW1Ea2gyQ09xYm1LQ2lRcTUyTStZQ3I5L1k2TGRI?=
 =?utf-8?B?dDloQTNFeUhkYmRsWmVGc1I1eG1KQ2I3dExqc0xUeEt5d2pER3RnY2hFTGE3?=
 =?utf-8?B?NXVweFU2Tk1qNTd3RW5ZdUdTUmJYTVg5b1VQKzh1TW50N0haN2tCU3Vsc0Jz?=
 =?utf-8?B?Y1R0Sm4wRHkvRHBWeHBxdnJ6Nm9zdjhtYXlPS3V5UTZpakhBVUh0cGF1MWZR?=
 =?utf-8?B?L2lkUndPdFdaR2trbGtlMEIvZ245SjBUbGRVU3M0ZXJQRmhnS2o1S2txVmVy?=
 =?utf-8?B?dWdaanNFS0dBM2wxRmczNXlGbW5YVHNiVDNXc2J4eEM2U21abUdTKzFKc1dr?=
 =?utf-8?B?N0lDWXkyK1d1TCtTSG5EeHlsRmgrQjZNWkl1T2xRbVRGZkxGTmZPNVNJZUp4?=
 =?utf-8?B?R05iTU42Sk8wOGxYR0hEYldMTXhSQy9sRUFzaHV1SEpJRkhWMjgxMGpnaHNo?=
 =?utf-8?B?QURadmw1RFFWV293Z1FaQ3RHczJEcU9qY3BlYllvSm5tL0l4dHo2MjJXaVVC?=
 =?utf-8?B?WTh4ZlRpSmc2dFVsK0tZTTYxV3g1MmR1YkhRV3lvb25Ld1R0R3B2VGxxVk9B?=
 =?utf-8?B?TmQ4WmljOWZEMGw2eVNkUFlBQUdRNERMQS95RG1veGxLeXV4M1Q4UXJGOUNv?=
 =?utf-8?B?akFIbldkT21kTzlUMnRGTzY1T0t0elBKc1R4YVU3dTJWeGk4Y0pFWjd5OVJD?=
 =?utf-8?B?UVZON1JkQnNkT1k3MjN1MThOby96ZnNhSS83R1FQcjczcndNSHVucHhlZDNh?=
 =?utf-8?B?UzFOSFQyTGZzTi96QkcrNlA5dndhNVRDLzdGajV6S1VLSWpDaFpYdm00L3Js?=
 =?utf-8?B?Rk1uaW1nS3RvNFc2N056ak0rdkVPVGdsdXllTXl2NXQ4NDBhUHJERTJQanUw?=
 =?utf-8?B?SXlydzBsWDlYaUpXRXFWeTFWQ3dZQ2drWnJ3dGsxTm4wWmNhMVpCajAzNndm?=
 =?utf-8?B?eC9SMXJuQlBydzAzMm1RSytTQTlabkMrVjEwNElsbXNPVkt0RzBxcVdZNFRh?=
 =?utf-8?B?NmVOYXNaYXQzMnVqd3I5WUVPZU9aOHl3S3hnUndSUGZQeml0Y1V5NlB2ajF4?=
 =?utf-8?B?NGtUVlFoTi8zaFN5aTJ6UjhQU0pjNjlGS1ZsQmE1MktoN2FsamlrU21mZTZx?=
 =?utf-8?B?dUhxWGpsUkp2eUdqbnUvWVpWbEZqalU3ZU91UU54VUo0SzU2UThxU0M3WWJ6?=
 =?utf-8?B?OTlLZUFIUzEyZ3ArS3pRckZCdlV2YkJEemgvaE5YZ0ZBQlhNVVVCdmxMbGhZ?=
 =?utf-8?B?a0pTbDkwSUZUS1FTS0ExcE93TG1rUmJISWpISUVvWndadDloaE9ZTE5Sa0VC?=
 =?utf-8?B?cHpNTnNYK2tjVkRzYUZ1K0NnbzIyT0g2T2lmTXVja2dqWWJ6RHRyQ2NySXR2?=
 =?utf-8?B?dWY5MVo4enVlVndvc0ZudmZVbHo4cW1aTllMZlQ1TXcrUWwrL2lIZnNaK2ZE?=
 =?utf-8?B?MmFzZDhwb0g4T2lBbW5NZ1ZLY0QvUTJTUUhGTHV4YklBMHFUYkF2NGdtN2ZH?=
 =?utf-8?B?VC9DYjJobWd3bkRGUlNXaEtUcWxCUStXUlJzL25nRGRpYVZrbmR4ODBraWJh?=
 =?utf-8?B?Y0hZRlBHaGdnZ3hlQnFYWTlaTGcwYjBpTDdOQm4vTWZvekJxVEdwUFI0cjB5?=
 =?utf-8?B?QWl1ZG5HMTd3MGF6QUw5NDV2eTlLdVFzU1FhVlVkekVpY3Z4Z3UwM25WQWE5?=
 =?utf-8?B?MVVOOVF4TDJzREZLSGNycDR3UjJUUmt6SVdGNERDQm1CcXdaN0RZR3lRRGFF?=
 =?utf-8?B?WHZZNThyY0ZPY2NteWZMZTVVSjVvcDFrNFI4dXVvMThEekFrMU1DcFlWNTBC?=
 =?utf-8?B?cXNsQ3RpZlEyMFFaU3JiMk9pUjRCRzE4V2FCZ2Z4eWZnMm9veWNiK0p0QW40?=
 =?utf-8?B?czJQYTdGMXhvbzFhOWd2RGJKUnlmWnZteGNpdHd4ZHkySzVTV3padVdFK3hN?=
 =?utf-8?B?RnlWNG95Z1RuY0xLSDVWY3MxUE54VlVpSlZhYzVyeHhxd3B4YUdtSDIyaEdC?=
 =?utf-8?B?bWhEZGlBZnNGQk4wOGhxY0p6ZlR2MXhjR3VSRHZPQlo5bGxkRk56clR4d1Ni?=
 =?utf-8?B?MHFKeWYvYWJtRU5BakoyUGhpUE1pUkVDRzBhQWprbzBWdENEUkhLRW12V0xG?=
 =?utf-8?B?V2ljSzM4SGxvREpiOTE0Zk1NTTRpREJqSlVhSUFyeUFPaGtmZjJ2Y2h1UmdN?=
 =?utf-8?Q?LzvmKaSVxrJvezra5dkcOkg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785305b3-2c69-4a75-6f22-08d9ea828b8e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 21:41:06.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJSmEaRD4nbz+p0fVcJycFHd5RjRC0ETkmnVwCCabRqWiCQ+mMH1sq6xUEXqxmQCAnNLM4HW07egDXglUZhVCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4063
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10251 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070122
X-Proofpoint-GUID: vIQ1x5FIsQdGqJbz6GSNx6nzSJipf0Q_
X-Proofpoint-ORIG-GUID: vIQ1x5FIsQdGqJbz6GSNx6nzSJipf0Q_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2/7/22 11:48 AM, Jeff Layton wrote:
> On Sun, 2022-02-06 at 13:31 -0800, Dai Ngo wrote:
>> Currently an NFSv4 client must maintain its lease by using the at least
>> one of the state tokens or if nothing else, by issuing a RENEW (4.0), or
>> a singleton SEQUENCE (4.1) at least once during each lease period. If the
>> client fails to renew the lease, for any reason, the Linux server expunges
>> the state tokens immediately upon detection of the "failure to renew the
>> lease" condition and begins returning NFS4ERR_EXPIRED if the client should
>> reconnect and attempt to use the (now) expired state.
>>
>> The default lease period for the Linux server is 90 seconds.  The typical
>> client cuts that in half and will issue a lease renewing operation every
>> 45 seconds. The 90 second lease period is very short considering the
>> potential for moderately long term network partitions.  A network partition
>> refers to any loss of network connectivity between the NFS client and the
>> NFS server, regardless of its root cause.  This includes NIC failures, NIC
>> driver bugs, network misconfigurations & administrative errors, routers &
>> switches crashing and/or having software updates applied, even down to
>> cables being physically pulled.  In most cases, these network failures are
>> transient, although the duration is unknown.
>>
>> A server which does not immediately expunge the state on lease expiration
>> is known as a Courteous Server.  A Courteous Server continues to recognize
>> previously generated state tokens as valid until conflict arises between
>> the expired state and the requests from another client, or the server
>> reboots.
>>
>> The initial implementation of the Courteous Server will do the following:
>>
>> . When the laundromat thread detects an expired client and if that client
>> still has established state on the Linux server and there is no waiters
>> for the client's locks then deletes the client persistent record and marks
>> the client as NFSD4_CLIENT_COURTESY and skips destroying the client and
>> all of its state, otherwise destroys the client as usual.
>>
>> . Client persistent record is added to the client database when the
>> courtesy client reconnects and transits to normal client.
>>
>> . Lock/delegation/share reversation conflict with courtesy client is
>> resolved by marking the courtesy client as NFSD4_CLIENT_DESTROY_COURTESY,
>> effectively disable it, then allow the current request to proceed
>> immediately.
>>
>> . Courtesy client marked as NFSD4_CLIENT_DESTROY_COURTESY is not allowed to
>> reconnect to reuse itsstate. It is expired by the laundromat asynchronously
>> in the background.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 459 +++++++++++++++++++++++++++++++++++++++++++++++-----
>>   fs/nfsd/nfsd.h      |   1 +
>>   fs/nfsd/state.h     |   6 +
>>   3 files changed, 425 insertions(+), 41 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 1956d377d1a6..5a025c905d35 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1917,10 +1917,27 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
>>   {
>>   	struct nfsd4_session *session;
>>   	__be32 status = nfserr_badsession;
>> +	struct nfs4_client *clp;
>>   
>>   	session = __find_in_sessionid_hashtbl(sessionid, net);
>>   	if (!session)
>>   		goto out;
>> +	clp = session->se_client;
>> +	if (clp) {
>> +		clp->cl_cs_client = false;
>> +		/* need to sync with thread resolving lock/deleg conflict */
>> +		spin_lock(&clp->cl_cs_lock);
>> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags)) {
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			session = NULL;
>> +			goto out;
>> +		}
>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +			clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>> +			clp->cl_cs_client = true;
>> +		}
>> +		spin_unlock(&clp->cl_cs_lock);
>> +	}
>>   	status = nfsd4_get_session_locked(session);
>>   	if (status)
>>   		session = NULL;
>> @@ -1990,6 +2007,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
>>   	INIT_LIST_HEAD(&clp->cl_openowners);
>>   	INIT_LIST_HEAD(&clp->cl_delegations);
>>   	INIT_LIST_HEAD(&clp->cl_lru);
>> +	INIT_LIST_HEAD(&clp->cl_cs_list);
>>   	INIT_LIST_HEAD(&clp->cl_revoked);
>>   #ifdef CONFIG_NFSD_PNFS
>>   	INIT_LIST_HEAD(&clp->cl_lo_states);
>> @@ -1997,6 +2015,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
>>   	INIT_LIST_HEAD(&clp->async_copies);
>>   	spin_lock_init(&clp->async_lock);
>>   	spin_lock_init(&clp->cl_lock);
>> +	spin_lock_init(&clp->cl_cs_lock);
>>   	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
>>   	return clp;
>>   err_no_hashtbl:
>> @@ -2394,6 +2413,10 @@ static int client_info_show(struct seq_file *m, void *v)
>>   		seq_puts(m, "status: confirmed\n");
>>   	else
>>   		seq_puts(m, "status: unconfirmed\n");
>> +	seq_printf(m, "courtesy client: %s\n",
>> +		test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ? "yes" : "no");
>> +	seq_printf(m, "seconds from last renew: %lld\n",
>> +		ktime_get_boottime_seconds() - clp->cl_time);
>>   	seq_printf(m, "name: ");
>>   	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
>>   	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
>> @@ -2801,12 +2824,15 @@ add_clp_to_name_tree(struct nfs4_client *new_clp, struct rb_root *root)
>>   }
>>   
>>   static struct nfs4_client *
>> -find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
>> +find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root,
>> +				bool *courtesy_client)
>>   {
>>   	int cmp;
>>   	struct rb_node *node = root->rb_node;
>>   	struct nfs4_client *clp;
>>   
>> +	if (courtesy_client)
>> +		*courtesy_client = false;
>>   	while (node) {
>>   		clp = rb_entry(node, struct nfs4_client, cl_namenode);
>>   		cmp = compare_blob(&clp->cl_name, name);
>> @@ -2814,8 +2840,29 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
>>   			node = node->rb_left;
>>   		else if (cmp < 0)
>>   			node = node->rb_right;
>> -		else
>> +		else {
>> +			/* sync with thread resolving lock/deleg conflict */
>> +			spin_lock(&clp->cl_cs_lock);
>> +			if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY,
>> +					&clp->cl_flags)) {
>> +				spin_unlock(&clp->cl_cs_lock);
>> +				return NULL;
>> +			}
>> +			if (test_bit(NFSD4_CLIENT_COURTESY,
>> +					&clp->cl_flags)) {
>> +				if (!courtesy_client) {
>> +					set_bit(NFSD4_CLIENT_DESTROY_COURTESY,
>> +							&clp->cl_flags);
>> +					spin_unlock(&clp->cl_cs_lock);
>> +					return NULL;
>> +				}
>> +				clear_bit(NFSD4_CLIENT_COURTESY,
>> +					&clp->cl_flags);
>> +				*courtesy_client = true;
>> +			}
>> +			spin_unlock(&clp->cl_cs_lock);
>>   			return clp;
>> +		}
>>   	}
>>   	return NULL;
>>   }
>> @@ -2852,15 +2899,38 @@ move_to_confirmed(struct nfs4_client *clp)
>>   }
>>   
>>   static struct nfs4_client *
>> -find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions)
>> +find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions,
>> +			bool *courtesy_clnt)
>>   {
>>   	struct nfs4_client *clp;
>>   	unsigned int idhashval = clientid_hashval(clid->cl_id);
>>   
>> +	if (courtesy_clnt)
>> +		*courtesy_clnt = false;
>>   	list_for_each_entry(clp, &tbl[idhashval], cl_idhash) {
>>   		if (same_clid(&clp->cl_clientid, clid)) {
>>   			if ((bool)clp->cl_minorversion != sessions)
>>   				return NULL;
>> +
>> +			/* need to sync with thread resolving lock/deleg conflict */
>> +			spin_lock(&clp->cl_cs_lock);
>> +			if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY,
>> +					&clp->cl_flags)) {
>> +				spin_unlock(&clp->cl_cs_lock);
>> +				continue;
>> +			}
>> +			if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +				if (!courtesy_clnt) {
>> +					set_bit(NFSD4_CLIENT_DESTROY_COURTESY,
>> +							&clp->cl_flags);
>> +					spin_unlock(&clp->cl_cs_lock);
>> +					continue;
>> +				}
>> +				clear_bit(NFSD4_CLIENT_COURTESY,
>> +							&clp->cl_flags);
>> +				*courtesy_clnt = true;
>> +			}
>> +			spin_unlock(&clp->cl_cs_lock);
>>   			renew_client_locked(clp);
>>   			return clp;
>>   		}
>> @@ -2869,12 +2939,13 @@ find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions)
>>   }
>>   
>>   static struct nfs4_client *
>> -find_confirmed_client(clientid_t *clid, bool sessions, struct nfsd_net *nn)
>> +find_confirmed_client(clientid_t *clid, bool sessions, struct nfsd_net *nn,
>> +		bool *courtesy_clnt)
>>   {
>>   	struct list_head *tbl = nn->conf_id_hashtbl;
>>   
>>   	lockdep_assert_held(&nn->client_lock);
>> -	return find_client_in_id_table(tbl, clid, sessions);
>> +	return find_client_in_id_table(tbl, clid, sessions, courtesy_clnt);
>>   }
>>   
>>   static struct nfs4_client *
>> @@ -2883,7 +2954,7 @@ find_unconfirmed_client(clientid_t *clid, bool sessions, struct nfsd_net *nn)
>>   	struct list_head *tbl = nn->unconf_id_hashtbl;
>>   
>>   	lockdep_assert_held(&nn->client_lock);
>> -	return find_client_in_id_table(tbl, clid, sessions);
>> +	return find_client_in_id_table(tbl, clid, sessions, NULL);
>>   }
>>   
>>   static bool clp_used_exchangeid(struct nfs4_client *clp)
>> @@ -2892,17 +2963,18 @@ static bool clp_used_exchangeid(struct nfs4_client *clp)
>>   }
>>   
>>   static struct nfs4_client *
>> -find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *nn)
>> +find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *nn,
>> +			bool *courtesy_clnt)
>>   {
>>   	lockdep_assert_held(&nn->client_lock);
>> -	return find_clp_in_name_tree(name, &nn->conf_name_tree);
>> +	return find_clp_in_name_tree(name, &nn->conf_name_tree, courtesy_clnt);
>>   }
>>   
>>   static struct nfs4_client *
>>   find_unconfirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *nn)
>>   {
>>   	lockdep_assert_held(&nn->client_lock);
>> -	return find_clp_in_name_tree(name, &nn->unconf_name_tree);
>> +	return find_clp_in_name_tree(name, &nn->unconf_name_tree, NULL);
>>   }
>>   
>>   static void
>> @@ -3176,7 +3248,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   
>>   	/* Cases below refer to rfc 5661 section 18.35.4: */
>>   	spin_lock(&nn->client_lock);
>> -	conf = find_confirmed_client_by_name(&exid->clname, nn);
>> +	conf = find_confirmed_client_by_name(&exid->clname, nn, NULL);
>>   	if (conf) {
>>   		bool creds_match = same_creds(&conf->cl_cred, &rqstp->rq_cred);
>>   		bool verfs_match = same_verf(&verf, &conf->cl_verifier);
>> @@ -3443,7 +3515,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>>   
>>   	spin_lock(&nn->client_lock);
>>   	unconf = find_unconfirmed_client(&cr_ses->clientid, true, nn);
>> -	conf = find_confirmed_client(&cr_ses->clientid, true, nn);
>> +	conf = find_confirmed_client(&cr_ses->clientid, true, nn, NULL);
>>   	WARN_ON_ONCE(conf && unconf);
>>   
>>   	if (conf) {
>> @@ -3474,7 +3546,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>>   			status = nfserr_seq_misordered;
>>   			goto out_free_conn;
>>   		}
>> -		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
>> +		old = find_confirmed_client_by_name(&unconf->cl_name, nn, NULL);
>>   		if (old) {
>>   			status = mark_client_expired_locked(old);
>>   			if (status) {
>> @@ -3613,6 +3685,7 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
>>   	struct nfsd4_session *session;
>>   	struct net *net = SVC_NET(rqstp);
>>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>> +	struct nfs4_client *clp;
>>   
>>   	if (!nfsd4_last_compound_op(rqstp))
>>   		return nfserr_not_only_op;
>> @@ -3645,6 +3718,16 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
>>   	nfsd4_init_conn(rqstp, conn, session);
>>   	status = nfs_ok;
>>   out:
>> +	clp = session->se_client;
>> +	if (clp->cl_cs_client) {
>> +		if (status == nfs_ok)
>> +			nfsd4_client_record_create(clp);
>> +		else {
>> +			spin_lock(&clp->cl_cs_lock);
>> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>> +			spin_unlock(&clp->cl_cs_lock);
>> +		}
>> +	}
>>   	nfsd4_put_session(session);
>>   out_no_session:
>>   	return status;
>> @@ -3667,6 +3750,7 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
>>   	int ref_held_by_me = 0;
>>   	struct net *net = SVC_NET(r);
>>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>> +	struct nfs4_client *clp;
>>   
>>   	status = nfserr_not_only_op;
>>   	if (nfsd4_compound_in_session(cstate, sessionid)) {
>> @@ -3679,6 +3763,12 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
>>   	ses = find_in_sessionid_hashtbl(sessionid, net, &status);
>>   	if (!ses)
>>   		goto out_client_lock;
>> +	clp = ses->se_client;
>> +	if (clp->cl_cs_client) {
>> +		status = nfserr_badsession;
>> +		goto out_put_session;
>> +	}
>> +
>>   	status = nfserr_wrong_cred;
>>   	if (!nfsd4_mach_creds_match(ses->se_client, r))
>>   		goto out_put_session;
>> @@ -3783,7 +3873,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	struct nfsd4_compoundres *resp = rqstp->rq_resp;
>>   	struct xdr_stream *xdr = resp->xdr;
>>   	struct nfsd4_session *session;
>> -	struct nfs4_client *clp;
>> +	struct nfs4_client *clp = NULL;
>>   	struct nfsd4_slot *slot;
>>   	struct nfsd4_conn *conn;
>>   	__be32 status;
>> @@ -3893,6 +3983,15 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	if (conn)
>>   		free_conn(conn);
>>   	spin_unlock(&nn->client_lock);
>> +	if (clp && clp->cl_cs_client) {
>> +		if (status == nfs_ok)
>> +			nfsd4_client_record_create(clp);
>> +		else {
>> +			spin_lock(&clp->cl_cs_lock);
>> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>> +			spin_unlock(&clp->cl_cs_lock);
>> +		}
>> +	}
>>   	return status;
>>   out_put_session:
>>   	nfsd4_put_session_locked(session);
>> @@ -3928,7 +4027,7 @@ nfsd4_destroy_clientid(struct svc_rqst *rqstp,
>>   
>>   	spin_lock(&nn->client_lock);
>>   	unconf = find_unconfirmed_client(&dc->clientid, true, nn);
>> -	conf = find_confirmed_client(&dc->clientid, true, nn);
>> +	conf = find_confirmed_client(&dc->clientid, true, nn, NULL);
>>   	WARN_ON_ONCE(conf && unconf);
>>   
>>   	if (conf) {
>> @@ -4012,12 +4111,18 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	struct nfs4_client	*unconf = NULL;
>>   	__be32 			status;
>>   	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>> +	bool courtesy_clnt = false;
>> +	struct nfs4_client *cclient = NULL;
>>   
>>   	new = create_client(clname, rqstp, &clverifier);
>>   	if (new == NULL)
>>   		return nfserr_jukebox;
>>   	spin_lock(&nn->client_lock);
>> -	conf = find_confirmed_client_by_name(&clname, nn);
>> +	conf = find_confirmed_client_by_name(&clname, nn, &courtesy_clnt);
>> +	if (conf && courtesy_clnt) {
>> +		cclient = conf;
>> +		conf = NULL;
>> +	}
>>   	if (conf && client_has_state(conf)) {
>>   		status = nfserr_clid_inuse;
>>   		if (clp_used_exchangeid(conf))
>> @@ -4048,7 +4153,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	new = NULL;
>>   	status = nfs_ok;
>>   out:
>> +	if (cclient)
>> +		unhash_client_locked(cclient);
>>   	spin_unlock(&nn->client_lock);
>> +	if (cclient)
>> +		expire_client(cclient);
>>   	if (new)
>>   		free_client(new);
>>   	if (unconf) {
>> @@ -4076,8 +4185,9 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
>>   		return nfserr_stale_clientid;
>>   
>>   	spin_lock(&nn->client_lock);
>> -	conf = find_confirmed_client(clid, false, nn);
>> +	conf = find_confirmed_client(clid, false, nn, NULL);
>>   	unconf = find_unconfirmed_client(clid, false, nn);
>> +
>>   	/*
>>   	 * We try hard to give out unique clientid's, so if we get an
>>   	 * attempt to confirm the same clientid with a different cred,
>> @@ -4107,7 +4217,7 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
>>   		unhash_client_locked(old);
>>   		nfsd4_change_callback(conf, &unconf->cl_cb_conn);
>>   	} else {
>> -		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
>> +		old = find_confirmed_client_by_name(&unconf->cl_name, nn, NULL);
>>   		if (old) {
>>   			status = nfserr_clid_inuse;
>>   			if (client_has_state(old)
>> @@ -4691,18 +4801,41 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>>   	return ret;
>>   }
>>   
>> +/*
>> + * Function returns true if lease conflict was resolved
>> + * else returns false.
>> + */
>>   static bool nfsd_breaker_owns_lease(struct file_lock *fl)
>>   {
>>   	struct nfs4_delegation *dl = fl->fl_owner;
>>   	struct svc_rqst *rqst;
>>   	struct nfs4_client *clp;
>>   
>> +	clp = dl->dl_stid.sc_client;
>> +
>> +	/*
>> +	 * need to sync with courtesy client trying to reconnect using
>> +	 * the cl_cs_lock, nn->client_lock can not be used since this
>> +	 * function is called with the fl_lck held.
>> +	 */
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags)) {
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		return true;
>> +	}
>> +	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		return true;
>> +	}
>> +	spin_unlock(&clp->cl_cs_lock);
>> +
>>   	if (!i_am_nfsd())
>> -		return NULL;
>> +		return false;
>>   	rqst = kthread_data(current);
>>   	/* Note rq_prog == NFS_ACL_PROGRAM is also possible: */
>>   	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
>> -		return NULL;
>> +		return false;
>>   	clp = *(rqst->rq_lease_breaker);
>>   	return dl->dl_stid.sc_client == clp;
>>   }
>> @@ -4735,12 +4868,12 @@ static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, struct nfs4
>>   }
>>   
>>   static struct nfs4_client *lookup_clientid(clientid_t *clid, bool sessions,
>> -						struct nfsd_net *nn)
>> +			struct nfsd_net *nn, bool *courtesy_clnt)
>>   {
>>   	struct nfs4_client *found;
>>   
>>   	spin_lock(&nn->client_lock);
>> -	found = find_confirmed_client(clid, sessions, nn);
>> +	found = find_confirmed_client(clid, sessions, nn, courtesy_clnt);
>>   	if (found)
>>   		atomic_inc(&found->cl_rpc_users);
>>   	spin_unlock(&nn->client_lock);
>> @@ -4751,6 +4884,8 @@ static __be32 set_client(clientid_t *clid,
>>   		struct nfsd4_compound_state *cstate,
>>   		struct nfsd_net *nn)
>>   {
>> +	bool courtesy_clnt;
>> +
>>   	if (cstate->clp) {
>>   		if (!same_clid(&cstate->clp->cl_clientid, clid))
>>   			return nfserr_stale_clientid;
>> @@ -4762,9 +4897,12 @@ static __be32 set_client(clientid_t *clid,
>>   	 * We're in the 4.0 case (otherwise the SEQUENCE op would have
>>   	 * set cstate->clp), so session = false:
>>   	 */
>> -	cstate->clp = lookup_clientid(clid, false, nn);
>> +	cstate->clp = lookup_clientid(clid, false, nn, &courtesy_clnt);
>>   	if (!cstate->clp)
>>   		return nfserr_expired;
>> +
>> +	if (courtesy_clnt)
>> +		nfsd4_client_record_create(cstate->clp);
>>   	return nfs_ok;
>>   }
>>   
>> @@ -4917,9 +5055,89 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
>>   	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
>>   }
>>   
>> -static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> +static bool
>> +nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
>> +			bool share_access)
>> +{
>> +	if (share_access) {
>> +		if (!stp->st_deny_bmap)
>> +			return false;
>> +
>> +		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
>> +			(access & NFS4_SHARE_ACCESS_READ &&
>> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_READ)) ||
>> +			(access & NFS4_SHARE_ACCESS_WRITE &&
>> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_WRITE))) {
>> +			return true;
>> +		}
>> +		return false;
>> +	}
>> +	if ((access & NFS4_SHARE_DENY_BOTH) ||
>> +		(access & NFS4_SHARE_DENY_READ &&
>> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
>> +		(access & NFS4_SHARE_DENY_WRITE &&
>> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +/*
>> + * This function is called to check whether nfserr_share_denied should
>> + * be returning to client.
>> + *
>> + * access:  is op_share_access if share_access is true.
>> + *	    Check if access mode, op_share_access, would conflict with
>> + *	    the current deny mode of the file 'fp'.
>> + * access:  is op_share_deny if share_access is false.
>> + *	    Check if the deny mode, op_share_deny, would conflict with
>> + *	    current access of the file 'fp'.
>> + * stp:     skip checking this entry.
>> + * new_stp: normal open, not open upgrade.
>> + *
>> + * Function returns:
>> + *	true   - access/deny mode conflict with normal client.
>> + *	false  - no conflict or conflict with courtesy client(s) is resolved.
>> + */
>> +static bool
>> +nfs4_conflict_clients(struct nfs4_file *fp, bool new_stp,
>> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
>> +{
>> +	struct nfs4_ol_stateid *st;
>> +	struct nfs4_client *cl;
>> +	bool conflict = false;
>> +
>> +	lockdep_assert_held(&fp->fi_lock);
>> +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
>> +		if (st->st_openstp || (st == stp && new_stp) ||
>> +			(!nfs4_check_access_deny_bmap(st,
>> +					access, share_access)))
>> +			continue;
>> +
>> +		/* need to sync with courtesy client trying to reconnect */
>> +		cl = st->st_stid.sc_client;
>> +		spin_lock(&cl->cl_cs_lock);
>> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &cl->cl_flags)) {
>> +			spin_unlock(&cl->cl_cs_lock);
>> +			continue;
>> +		}
>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &cl->cl_flags)) {
>> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &cl->cl_flags);
>> +			spin_unlock(&cl->cl_cs_lock);
>> +			continue;
>> +		}
>> +		/* conflict not caused by courtesy client */
>> +		spin_unlock(&cl->cl_cs_lock);
>> +		conflict = true;
>> +		break;
>> +	}
>> +	return conflict;
>> +}
>> +
>> +static __be32
>> +nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>>   		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
>> -		struct nfsd4_open *open)
>> +		struct nfsd4_open *open, bool new_stp)
>>   {
>>   	struct nfsd_file *nf = NULL;
>>   	__be32 status;
>> @@ -4935,15 +5153,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>>   	 */
>>   	status = nfs4_file_check_deny(fp, open->op_share_deny);
>>   	if (status != nfs_ok) {
>> -		spin_unlock(&fp->fi_lock);
>> -		goto out;
>> +		if (status != nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		if (nfs4_conflict_clients(fp, new_stp, stp,
>> +				open->op_share_deny, false)) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>>   	}
>>   
>>   	/* set access to the file */
>>   	status = nfs4_file_get_access(fp, open->op_share_access);
>>   	if (status != nfs_ok) {
>> -		spin_unlock(&fp->fi_lock);
>> -		goto out;
>> +		if (status != nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		if (nfs4_conflict_clients(fp, new_stp, stp,
>> +				open->op_share_access, true)) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>>   	}
>>   
>>   	/* Set access bits in stateid */
>> @@ -4994,7 +5226,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
>>   	unsigned char old_deny_bmap = stp->st_deny_bmap;
>>   
>>   	if (!test_access(open->op_share_access, stp))
>> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
>> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>>   
>>   	/* test and set deny mode */
>>   	spin_lock(&fp->fi_lock);
>> @@ -5343,7 +5575,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>   			goto out;
>>   		}
>>   	} else {
>> -		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
>> +		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
>>   		if (status) {
>>   			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>>   			release_open_stateid(stp);
>> @@ -5577,6 +5809,122 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>>   }
>>   #endif
>>   
>> +static bool
>> +nfs4_anylock_blocker(struct nfs4_client *clp)
>> +{
>> +	int i;
>> +	struct nfs4_stateowner *so, *tmp;
>> +	struct nfs4_lockowner *lo;
>> +	struct nfs4_ol_stateid *stp;
>> +	struct nfs4_file *nf;
>> +	struct inode *ino;
>> +	struct file_lock_context *ctx;
>> +	struct file_lock *fl;
>> +
>> +	spin_lock(&clp->cl_lock);
>> +	for (i = 0; i < OWNER_HASH_SIZE; i++) {
>> +		/* scan each lock owner */
>> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
>> +				so_strhash) {
>> +			if (so->so_is_open_owner)
>> +				continue;
>> +
>> +			/* scan lock states of this lock owner */
>> +			lo = lockowner(so);
>> +			list_for_each_entry(stp, &lo->lo_owner.so_stateids,
>> +					st_perstateowner) {
>> +				nf = stp->st_stid.sc_file;
>> +				ino = nf->fi_inode;
>> +				ctx = ino->i_flctx;
>> +				if (!ctx)
>> +					continue;
>> +				/* check each lock belongs to this lock state */
>> +				list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>> +					if (fl->fl_owner != lo)
>> +						continue;
>> +					if (!list_empty(&fl->fl_blocked_requests)) {
>> +						spin_unlock(&clp->cl_lock);
>> +						return true;
>> +					}
>> +				}
>> +			}
>> +		}
>> +	}
>> +	spin_unlock(&clp->cl_lock);
>> +	return false;
>> +}
>> +
>> +static void
>> +nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>> +				struct laundry_time *lt)
>> +{
>> +	struct list_head *pos, *next;
>> +	struct nfs4_client *clp;
>> +	bool cour;
>> +	struct list_head cslist;
>> +
>> +	INIT_LIST_HEAD(reaplist);
>> +	INIT_LIST_HEAD(&cslist);
>> +	spin_lock(&nn->client_lock);
>> +	list_for_each_safe(pos, next, &nn->client_lru) {
>> +		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> +		if (!state_expired(lt, clp->cl_time))
>> +			break;
>> +
>> +		/* client expired */
>> +		if (!client_has_state(clp)) {
>> +			if (mark_client_expired_locked(clp))
>> +				continue;
>> +			list_add(&clp->cl_lru, reaplist);
>> +			continue;
>> +		}
>> +
>> +		/* expired client has state */
>> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags))
>> +			goto exp_client;
>> +
>> +		cour = test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>> +		if (cour &&
>> +			ktime_get_boottime_seconds() >= clp->courtesy_client_expiry)
>> +			goto exp_client;
>> +
>> +		if (nfs4_anylock_blocker(clp)) {
>> +			/* expired client has state and has blocker. */
>> +exp_client:
>> +			if (mark_client_expired_locked(clp))
>> +				continue;
>> +			list_add(&clp->cl_lru, reaplist);
>> +			continue;
>> +		}
>> +		/*
>> +		 * Client expired and has state and has no blockers.
>> +		 * If there is race condition with blockers, next time
>> +		 * the laundromat runs it will catch it and expires
>> +		 * the client. Client is expected to retry on lock or
>> +		 * lease conflict.
>
> I'm not sure what's meant by this last sentence. If the client is
> reclaiming and there is a lock conflict then you usually don't want to
> blindly retry to get the lock.

The last sentence only means if there is race condition such as:

A LOCK request comes in and is conflicted with a client which
about to transits to courtesy state, that LOCK request will get
nfserr_jukebox reply. When the laundromat runs, it will detect
there is blocker and expire the client. When the LOCK request
is retried again it will succeed.

It seems confusing or unnecessary, I will remove the last sentence
if there is no objection.

>> +		 */
>> +		if (!cour) {
>> +			set_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>> +			clp->courtesy_client_expiry = ktime_get_boottime_seconds() +
>> +					NFSD_COURTESY_CLIENT_EXPIRY;
>> +			list_add(&clp->cl_cs_list, &cslist);
>> +		}
>> +	}
>> +	spin_unlock(&nn->client_lock);
>> +
>> +	list_for_each_entry(clp, &cslist, cl_cs_list) {
>> +		spin_lock(&clp->cl_cs_lock);
>> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags) ||
>> +			!test_bit(NFSD4_CLIENT_COURTESY,
>> +					&clp->cl_flags)) {
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			continue;
>> +		}
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		nfsd4_client_record_remove(clp);
>> +	}
>> +}
>> +
>>   static time64_t
>>   nfs4_laundromat(struct nfsd_net *nn)
>>   {
>> @@ -5610,16 +5958,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   	}
>>   	spin_unlock(&nn->s2s_cp_lock);
>>   
>> -	spin_lock(&nn->client_lock);
>> -	list_for_each_safe(pos, next, &nn->client_lru) {
>> -		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> -		if (!state_expired(&lt, clp->cl_time))
>> -			break;
>> -		if (mark_client_expired_locked(clp))
>> -			continue;
>> -		list_add(&clp->cl_lru, &reaplist);
>> -	}
>> -	spin_unlock(&nn->client_lock);
>> +	nfs4_get_client_reaplist(nn, &reaplist, &lt);
>>   	list_for_each_safe(pos, next, &reaplist) {
>>   		clp = list_entry(pos, struct nfs4_client, cl_lru);
>>   		trace_nfsd_clid_purged(&clp->cl_clientid);
>> @@ -5998,7 +6337,7 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
>>   	cps->cpntf_time = ktime_get_boottime_seconds();
>>   
>>   	status = nfserr_expired;
>> -	found = lookup_clientid(&cps->cp_p_clid, true, nn);
>> +	found = lookup_clientid(&cps->cp_p_clid, true, nn, NULL);
>>   	if (!found)
>>   		goto out;
>>   
>> @@ -6501,6 +6840,43 @@ nfs4_transform_lock_offset(struct file_lock *lock)
>>   		lock->fl_end = OFFSET_MAX;
>>   }
>>   
>> +/**
>> + * nfsd4_fl_lock_conflict - check if lock conflict can be resolved.
>> + *
>> + * @fl: pointer to file_lock with a potential conflict
>> + * Return values:
>> + *   %true: real conflict, lock conflict can not be resolved.
>> + *   %false: no conflict, lock conflict was resolved.
>> + *
>> + * Note that this function is called while the flc_lock is held.
>> + */
>> +static bool
>> +nfsd4_fl_lock_conflict(struct file_lock *fl)
>> +{
>> +	struct nfs4_lockowner *lo;
>> +	struct nfs4_client *clp;
>> +	bool rc = true;
>> +
>> +	if (!fl)
>> +		return true;
>> +	lo = (struct nfs4_lockowner *)fl->fl_owner;
>> +	clp = lo->lo_owner.so_client;
>> +
>> +	/* need to sync with courtesy client trying to reconnect */
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags))
>> +		rc = false;
>> +	else {
>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>> +			rc =  false;
>> +		} else
>> +			rc =  true;
>> +	}
>> +	spin_unlock(&clp->cl_cs_lock);
>> +	return rc;
>> +}
>> +
>>   static fl_owner_t
>>   nfsd4_fl_get_owner(fl_owner_t owner)
>>   {
>> @@ -6548,6 +6924,7 @@ static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>>   	.lm_notify = nfsd4_lm_notify,
>>   	.lm_get_owner = nfsd4_fl_get_owner,
>>   	.lm_put_owner = nfsd4_fl_put_owner,
>> +	.lm_lock_conflict = nfsd4_fl_lock_conflict,
>>   };
>>   
>>   static inline void
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 498e5a489826..bffc83938eac 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
>>   #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
>>   
>>   #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
>> +#define	NFSD_COURTESY_CLIENT_EXPIRY	(24 * 60 * 60)	/* seconds */
> I wonder if we ought to consider making this tunable?
>
> One day seems fine for most current use cases, but this work makes it
> more feasible to use NFSv4 on something like a laptop. Currently when
> you lose state then you hit all sorts of problems if you have things
> like locks, so I usually don't bother trying to use long-term NFS mounts
> on a laptop, as I might suspend it for days at a time.
>
> Now though, assuming that the host is working in its own area with no
> conflicts, you could suspend a laptop for a long time and not worry
> about hitting those sorts of issues.

I have the same need for testing, that was why I used a memory variable
so I can patch it to a much smaller value. I'm fine with either way.
I think tuning in general is not preferable so maybe we just leave it
as a macro for now.

>
>>   
>>   /*
>>    * The following attributes are currently not supported by the NFSv4 server:
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index e73bdbb1634a..a0baa6581f57 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -345,6 +345,8 @@ struct nfs4_client {
>>   #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
>>   #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
>>   					 1 << NFSD4_CLIENT_CB_KILL)
>> +#define NFSD4_CLIENT_COURTESY		(6)	/* be nice to expired client */
>> +#define NFSD4_CLIENT_DESTROY_COURTESY	(7)
>>   	unsigned long		cl_flags;
>>   	const struct cred	*cl_cb_cred;
>>   	struct rpc_clnt		*cl_cb_client;
>> @@ -385,6 +387,10 @@ struct nfs4_client {
>>   	struct list_head	async_copies;	/* list of async copies */
>>   	spinlock_t		async_lock;	/* lock for async copies */
>>   	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
>> +	int			courtesy_client_expiry;
>> +	bool			cl_cs_client;
>> +	spinlock_t		cl_cs_lock;
>> +	struct list_head	cl_cs_list;
>>   };
>>   
>>   /* struct nfs4_client_reset
> Nice work!

Thank you for your review.

-Dai

>
> Acked-by: Jeff Layton <jlayton@kernel.org>
