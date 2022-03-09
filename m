Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508494D3B63
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 21:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbiCIUwS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 15:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiCIUwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:52:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6D0A9A7E;
        Wed,  9 Mar 2022 12:51:12 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229Kcm6Z009111;
        Wed, 9 Mar 2022 20:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=D4ontAiyLPq3b1Ob+voJEm9g1975GmlcfrWA9j0Sxaw=;
 b=xOdvio4jkmxKtHdUYuJHdt0XNMLf84JiBhx7gEZ3aaS7ksbQGA3V93k3cA+rKAQi73nP
 nXFVUegcmL4pnkg/2ciEUdyyo4haNZqBLwi/SlA2fmVfoAlPyx7JIxkvizj0DzlP8hyZ
 JdA80/gjWzhXXbOtogxtzEk2hZMMI4CGPbcRVc8p/zNbmkCRcgErw2sZ3VkidvsXVDIv
 8KZmOit2bDaOnCcEYOSLtaJS9ax92YeMsVybdG4NwLTNDtFxn5u2c8p6S2+p/0jO8QJ/
 qpYWm+gfvInJPaloeZDci8mQ1VQWM5UAtcNOFXRyt0Bmfum5fS6N9lQblF2t48tftWkd TA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2kghs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 20:51:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229KfimP181875;
        Wed, 9 Mar 2022 20:51:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3030.oracle.com with ESMTP id 3ekwwd1ah0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 20:51:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/NDhj4IR8k31kF6zgKY+4Jo+muR1Ov2p+HZBbWjM9mGAEbnHyOALz2BPhQDZvvac9Smgxg8i91bPdk/LIE3jEFQX947SiT13pfM4d3l+eSvWHHypnPntGEhlIfmwPBxYIiEfrrzVCQL5hSVMCVA6iakMA/C41nYJfmRzesPazh8dUmIRFDF7K/xbCGZEljtPhMttIS3lSUwRSjh5CzxSkhPvxF+t7fjb+7zi/pR40FZEACg+HGpqwBxDz7b38ujV6PQmI/6ErpgU8f9Y80LzhlndSjD2gkZxe+iPJNAWYru3b+AkBAMcsTGtvRIa37tkzb68SlyO9tnphkjGY7AOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4ontAiyLPq3b1Ob+voJEm9g1975GmlcfrWA9j0Sxaw=;
 b=CbaJ4g3tznsfWRwSKzNx/V+Vb4KtnxQMVD5wvEGZIQ2InIt0qIcMq5P+J4eqLIr9oTY70mVJaFqTBs1Q/aT2k5ZjTuR4dIYbqc955CMfbtM7G0f8iK3E+0+uNsQSqvsz+xOaZ5BrrkhhwddZC+hS3Zc8m3DnHvRSsNbwweKbGLd1S40OFCZALLrPSQ0EhC1r36kjKUPonU754tYdLupLCmGf9liF9+1B3iBR3lecR8tJ5KRY1QBxDoTrghe5repJvoy48dN+VgNP7fAassHyDfT5TvfHp6CkvxAb0hRwy8RrWyezT2c/C+1fo2V4MieadIwi7raKuzTrLHx0u50VeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4ontAiyLPq3b1Ob+voJEm9g1975GmlcfrWA9j0Sxaw=;
 b=jIZsG33mzTK+3lau98Wz3shjzeWmAwcjFSrE0jHKfN7cp7SMFlS/wXS4KmX9fblLU1ONPNsPG/vPSef29Ra8DSNRoXbO/FG3PWBJFexGtdZB3wlbv7faK3+im0nWXmFGxv75wf+gE4DJ0cs3CYt3tOVn6L5dfJvBrOqrhHlqz1I=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by CO1PR10MB4787.namprd10.prod.outlook.com (2603:10b6:303:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Wed, 9 Mar
 2022 20:51:06 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::ec41:df7c:ccb0:22b4]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::ec41:df7c:ccb0:22b4%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 20:51:06 +0000
Message-ID: <c5a82f64-d1a5-3ec5-2bbf-4bd596840cf2@oracle.com>
Date:   Wed, 9 Mar 2022 12:51:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v15 11/11] NFSD: Show state of courtesy clients in
 client info
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-12-git-send-email-dai.ngo@oracle.com>
 <E1AF0991-A682-4B98-A62F-3FE55349E30F@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <E1AF0991-A682-4B98-A62F-3FE55349E30F@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:806:24::19) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52ddb1ea-5c6e-4017-f4e5-08da020e8859
X-MS-TrafficTypeDiagnostic: CO1PR10MB4787:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB47873CD34233500B5FEFADB3870A9@CO1PR10MB4787.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LM/39L214ealUEhU+dER8Fi2ZVAKgKAZUcN+1lLfaVLJdlD3X523omz3sua4IyL5VIU5JvYx++9wNVDsm5KER6xMcUwUfqicYMt4ao2BDB7ZUEPF65MrshQD3sfSjMA0FaGb24QlY+KRiJAPZ+omuTJQa6gHyuPyDBVaWzbC5+TriBdq+Dj+05vd7uWfdDrEj5cw0RJYTfU9+TFN20R0eTsMfw50edP8WgGymQ3Ms5sXcyu4d3p8MR5kDG/cLHpHG5dGrr939rnYWjbYMWkRn8w6Qn127c2ZFLBCyQbKbfM9X8xcCWUyTFSSBYyK25ICcsdy6Yut1jACGkeEE742//NGQJWLTnlX7QRgedzp6sTGDZpNctZOzffxIejUPUwp7tXCYjOG+QPs7BOzgeATSi7ASQUXHrJ3Ls7kEX7LPU+AmgvX3iIfbciv/STRLayVnPAjZw0eGSb+wiXZFpWw/yibucV9BsL+jpWIEKfGeoKDMSjAJOG1/Hk0ZnHnBgLCTNLe73Jh4gKk2OYr0l775ZBKhEJQoJy5au/4SwfsfUFfCyBg12bWoNa+HyV/UjmlmzDJkoY5BMOTk/LushcEJOxqZFL6qac1wg3E0FQ9nc6nAPGeu0yil9hZujL5Ik+TFJHHyJHXbwYH8+qrHrKjiW5ARukFhkXT1VDnU6IFd8weQKrtlxqamUmZfc37NsiAZ0oEDLhDha4giph2vb+KWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(4326008)(6862004)(6512007)(31686004)(2906002)(31696002)(6506007)(37006003)(86362001)(53546011)(54906003)(26005)(6486002)(508600001)(36756003)(316002)(186003)(6666004)(8936002)(2616005)(38100700002)(66476007)(5660300002)(8676002)(66946007)(66556008)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MENUL1dqaWRhaUNyYTJUZmFYM2lxU3pVTkkyUjNjR3JoR3hpYnYrQ3VVTGtz?=
 =?utf-8?B?akl6TkU0WXJwUjNiUmt6dHJBaGExY2IybUVBVCsxNE8zSGFMSHJCWVdZRDly?=
 =?utf-8?B?djkrbHhOUm9RV2kwemlOWjN1WmJoTWtmR2dxRzNnZnllYXE2OStGdVBKOC9h?=
 =?utf-8?B?Q2lrRUdZSlJxemdIZHRxRkhzam13S0k5OElMcmVROExGRnd6R3lNaG1FWEpO?=
 =?utf-8?B?MnIyTkdVQ1o4SHB2Vm1rSXY3NVlocGJ0K2lteUF1Y005NG9SZ3VSbVN2TC9Y?=
 =?utf-8?B?TTJUYUtMKzJXK3N6L1BNbzMyRmZBcFozUG9RRHB0MU9iVXp1LzZOQmpZN2tW?=
 =?utf-8?B?RXE5QTVzY1dSZFFENExleWxnUmlaS3ozb1dVclBwdHQ2cTBWamFRbWxQNWZX?=
 =?utf-8?B?c2Jpb0xMT1NieHpaaWMzVXhXZmM3eVp3bXFrNDNQbDQvLzVJaG1PdmQ3YlU4?=
 =?utf-8?B?RHFIQUJXSTBEQjh4UVFmZWQ3QWhDUExjOWh5RlFGWk1nR1pMQXh4dDh3TUN5?=
 =?utf-8?B?VjBPWFpGRnNMMFZxTTJNZ2QxUWtUUFRNdnpiQWFUellJL1ZtN1RYVmxWTDRQ?=
 =?utf-8?B?eGtZcjFrVDI2YTJSUWY0Y0dvUC9wczBIL3FUeVJRa1llYjBBZE1kZFN3cnlF?=
 =?utf-8?B?aTlpZ1liS205cUdrWnJyNy9RdlpLZVdhQU14S3pzckdYWDFxMzJOREtFTGNM?=
 =?utf-8?B?K2JsclY4NDBIWk1BMi8zVUpmaTcyYk1WNUNIRUFTaGlTajd5MTdLWUVtVDlI?=
 =?utf-8?B?L2pqaS9HaXBuMjI4UTFVaVZ6Skpsd1ZGY2pGeGZJK1VvRys0b0NyVWRES2ZC?=
 =?utf-8?B?VzlqelNOVEcwSHZUTFNmakdlVzJZUEwvVFp3c3VzTVh0NXFaaWxrSGRpQWlW?=
 =?utf-8?B?VytPMDc2UFc0bnBZUUxycHk1NG84ajdONS9ZWjdDLzZQeUgvRUFnZUVyUmRi?=
 =?utf-8?B?aWlEbWd0dVpobk1YSWpoN2gwOFJMVjh6eG50dVU4UUJFOHNzdENrV1ptL0ta?=
 =?utf-8?B?K01QWE8rTUp3NEZPZnoxUWpqSk5Cd2lvc3ZzM0krVXpnazA5eFhINytiNGdn?=
 =?utf-8?B?NkFTakxYcnJoVWdHcGZYOXQraFIyVm9DSU4xVG5aR3N5WTdpR0RjS1BtUW5n?=
 =?utf-8?B?aGJZWmNhbDRYZENsZ3YxMmNQRTZQMkU0ZHlDcTRVVksxL1lnVTJPWU9WS3dk?=
 =?utf-8?B?SGhaRnhZbWU0Zk1uMkEzbVBpejZmMFQvV3FaVzdqd21tMms4M2VUWGdVV2xp?=
 =?utf-8?B?Wld5QlFvb1hPeTlYNzhpUHJVYWNGY3Vxa21xb2pZK1FpaWJGSDlmOGVseWF3?=
 =?utf-8?B?RmtSQjc5bDNvUmVoTFI4VzdBTzhqbFVCV2FxQUJwMkZrSDgwQSs1RDVZTzZq?=
 =?utf-8?B?bmtIa254TUt6SDZLR21Mak9Zb3hsb01KZkVpSzBNMUhxbWN1Vkp4RXZOSUN3?=
 =?utf-8?B?MWpMNGw0c3ZoSTR6STJlZ20waFRlRkNNdXAxN0lLckpzdXJ5WDMvUmJXcFZa?=
 =?utf-8?B?ektMUlRNSEpZaVlTV2F6ZTYrSXAvMWtOWE5CbGpWMjVjTEtlVWNXSThZdW5M?=
 =?utf-8?B?QklOSnhZNm1CWmxPTEhOY2hPdXVrZzZjb0w5dmdTdnUzY0xYTWlYaVhreEI1?=
 =?utf-8?B?YlNQYjZRR0FBUGRsbkxNbWdUdmVINTV1TGlIR001K2VxMFZjWUFYemVWOHJh?=
 =?utf-8?B?QTRML2lxVERaTkM1NHlKdWJyUzNxZGtQbkJGOUNseHNVVHI5SUdHVEZXOXZB?=
 =?utf-8?B?VWFreW5GRHE1dXdud3dNN1RTa1N6alVDUHkzbG5rNkNkQUlmYloyaW5EVWtD?=
 =?utf-8?B?SXhzNEJFeUJ5VG9qYm9EKzBrWXhNSUF2OSs3dC9YOEdFU3RHVzdNY0tTM2Vi?=
 =?utf-8?B?Vzd4OHNtay9obzJtc3FJZERaa21xVUkwcVVGQ3hRU2poQzJNbGtmejZHT3Zi?=
 =?utf-8?B?dURPeGp2RlRCc2NRaDFhU0JhOFpDYjAzazZOKzNuMlBoZ2NoNHo1UlA2YTFN?=
 =?utf-8?B?UnBhV2V6cTBjUFpXVjdCMVFhUDRuNHNIRVdnT2p4Mk00dDFsN1o5QU5MYXE4?=
 =?utf-8?B?SkJaREdOK2NBU2k0NEcxN1c5UzJnRi9JZHpwQmU3VlN3YlV4dnVJM1UweURW?=
 =?utf-8?B?SzdpUUE4QkJqUEloU0EyVjJtUmxXV0s0dXNJRFdxWjJDdGtFS3ZTNDVvTkYy?=
 =?utf-8?Q?J5+xg2F/hZN7cZLtBpkckns=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ddb1ea-5c6e-4017-f4e5-08da020e8859
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 20:51:06.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsBaqNbZ4/qSsd7Z8kzig6qgEWHPPE6XfvQJWa6L5nYvH5E+Pg66xbVmYaZjGVK3tzZtrKuy2msOseZ7tRcKtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4787
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090107
X-Proofpoint-ORIG-GUID: vVCEZjFiXi0nxjRBpDEdEVD2u1uJErsO
X-Proofpoint-GUID: vVCEZjFiXi0nxjRBpDEdEVD2u1uJErsO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/9/22 12:14 PM, Chuck Lever III wrote:
>
>> On Mar 4, 2022, at 7:37 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Update client_info_show to show state of courtesy client
>> and time since last renew.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c | 9 ++++++++-
>> 1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index bced09014e6b..ed14e0b54537 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2439,7 +2439,8 @@ static int client_info_show(struct seq_file *m, void *v)
>> {
>> 	struct inode *inode = m->private;
>> 	struct nfs4_client *clp;
>> -	u64 clid;
>> +	u64 clid, hrs;
>> +	u32 mins, secs;
>>
>> 	clp = get_nfsdfs_clp(inode);
>> 	if (!clp)
>> @@ -2451,6 +2452,12 @@ static int client_info_show(struct seq_file *m, void *v)
>> 		seq_puts(m, "status: confirmed\n");
>> 	else
>> 		seq_puts(m, "status: unconfirmed\n");
>> +	seq_printf(m, "courtesy client: %s\n",
>> +		test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ? "yes" : "no");
> I'm wondering if it would be more economical to combine this
> output with the status output just before it so we have only
> one of:
>
> 	seq_puts(m, "status: unconfirmed\n");
>
> 	seq_puts(m, "status: confirmed\n");
>
> or
>
> 	seq_puts(m, "status: courtesy\n");

make sense, will fix.

>
>
>> +	hrs = div_u64_rem(ktime_get_boottime_seconds() - clp->cl_time,
>> +				3600, &secs);
>> +	mins = div_u64_rem((u64)secs, 60, &secs);
>> +	seq_printf(m, "time since last renew: %02ld:%02d:%02d\n", hrs, mins, secs);
> Thanks, this seems more friendly than what was here before.
>
> However if we replace the fixed courtesy timeout with a
> shrinker, I bet some courtesy clients might lie about for
> many more that 99 hours. Perhaps the left-most format
> specifier could be just "%lu" and the rest could be "%02u".
>
> (ie, also turn the "d" into "u" to prevent ever displaying
> a negative number of time units).

will fix.

I will wait for your review of the rest of the patches before
I submit v16.

Thanks,
-Dai

>
>
>> 	seq_printf(m, "name: ");
>> 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
>> 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
