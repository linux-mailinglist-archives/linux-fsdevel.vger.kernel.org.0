Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D32438F150
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 18:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhEXQRQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 12:17:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51054 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhEXQRP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 12:17:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14OGFKZC075924;
        Mon, 24 May 2021 16:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=R1uAAyNGezwQn41DPuP+c9tgc+sGNcn2GK/xaQSDrNc=;
 b=exyTnNndLCI+NPB4xjjw9tZA+4BPNxfA5vnIEnq5yF7XscHrVZ8LQLZH0UtyfqkXrTCo
 W7sAq7qL4l8ZhIEo8sZAYOHo63T3bGUF5DBKawn4oSkreDtmhWIQvqqjRvQez+Lw4Uyw
 ViwR7msdiQhBie8eGwNWCmlPsB9J99holwjLllANsAG1DXs6CxBPifHsE9Zv9OLpzFY6
 r8aEhsX6qjRg1hWBmWTpaIUnoOadnpaQiMp14ACrNecTMuRxah56E6YI82CPuqY8pXbh
 iuEqolomQ6I3Q6c79W8CB57vClfj6wsR+D7a4RmHOovjdx7wfU7LMZBA2r+yxQ6lTOFK tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 38q3q8u1fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 16:15:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14OGEjs7111504;
        Mon, 24 May 2021 16:15:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3020.oracle.com with ESMTP id 38reh7e2pk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 16:15:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoqbBU0LS1hQGxricj+p0xvZni3uCwq923WMB4ZKPD0OaQAPqjHpGlJelZN6W1N9UdyUTyBWG6SAmQzxa/lqyejYQ36hKPHDaUxFe5Ckb+8cX6y8wUHZEJDmqAFbXAbz5/bLZbyQNOknNi05MyB8l/0c9KsLr04WiK2KZMPQ9LxNmWdgj/Eq4lGXyro3FAHBH7IVnVYigXGsIBYIuF3sn/GAJu7EowVMuw8GovndkRQP/7mjcwEG/l6umc7gp187+tWGpfI176B6670F5CX6D0I1GWRB0Mqo+yZ2xmkZ6/WGpYhJiiAkK96g90pDH2XT6vk/yXwwYlvOZyGZ/5Q8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1uAAyNGezwQn41DPuP+c9tgc+sGNcn2GK/xaQSDrNc=;
 b=Mjz+IWgr3Y77BOZBL5et9HaPk31eU6e6QCr6yWPdlaQTiJp9XPX4a9Nau168Zskofydo7e6yNhQGGhCB0eMp1MJbvUAhhBwXKc7kZ85q0AuxYrbuAjihMhHQW2YprAEf/SBBb16h66MoIY1LeXrJGqktm8IpRe5aWn0yyls9p7tVOTiPi1sKKC5rMcPKoPlOKH1NXyFp/8m1FoL1aRclX2KPWdxpIhoCVaWeTKTMGzJNUtc0cbLkuRFVv8hWvjl99HiDVC17nTJJM5jOPctntFl3uCJavqXb65umgyRu4ze8tf6EnX4XEL3Q+kiRie9rPYj51of+bgLs4+TM7HsL4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1uAAyNGezwQn41DPuP+c9tgc+sGNcn2GK/xaQSDrNc=;
 b=mlsxXTAhvhcmB8rfKSTmvANn6rPpjh5Qd0xD2/YFa6R7YxmVhImiLGnp52RGMXlCTR4HLfOiB0hWtIp55Lda4lPPgMDMBvUXo4Jq9eq29MhL/7SAN+qcBrUvokNVK/bTEs+0Tp4kufhGUVD9qDS6GohWgLB4atmuehKcnME99Ic=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Mon, 24 May
 2021 16:15:34 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4519:4046:5549:95d9]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4519:4046:5549:95d9%6]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 16:15:34 +0000
Subject: Re: [PATCH v2] ocfs2: fix data corruption by fallocate
To:     Jan Kara <jack@suse.cz>
Cc:     ocfs2-devel@oss.oracle.com, joseph.qi@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org
References: <20210521233612.75185-1-junxiao.bi@oracle.com>
 <20210524085508.GD32705@quack2.suse.cz>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <479301ea-042b-855d-fc52-0d7bbdc55bdc@oracle.com>
Date:   Mon, 24 May 2021 09:14:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <20210524085508.GD32705@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: SN7PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:806:f2::17) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-138-166.vpn.oracle.com (73.231.9.254) by SN7PR04CA0012.namprd04.prod.outlook.com (2603:10b6:806:f2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Mon, 24 May 2021 16:15:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 395998f4-2666-4981-14e4-08d91ecf28b7
X-MS-TrafficTypeDiagnostic: BYAPR10MB2629:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB26298ED54D003355EAC95C6FE8269@BYAPR10MB2629.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mER3ZYRvwQdV96PgmRGodc9lVxxovM60wN+xOOVweyfzszrM28xr7xYOrQibTi1oLeqRdDbvS2d964YVvjz1IkUPEW/0v4dOBBbfQlFnOgxHL+Je+iY85W/nhsaSgJH5Qs+bFEBhqK70olCImjJTTh1I9voF7d0j1EKQbGIw4JN9V0Ww9Oe/likPHzmdk98IErePkwYLGa0DOsn1Ll8td8tWoO4zbx0OMkglSygIgU1xi2xhPb+h9CQizLC4Cnjp0DnDcs+mqZ/zcT8+ix084QWchLenQfvXBPXOwGhMqM7Pz9u791HThKvbsxoOdsTaBGMTMt1ovaOePpLPYxPyfeX7eBfqI2GOkJcJJDt71anV4Mda1lRjEDAnqLgrGaSMnaoXbfTKns3es4KVpqpvR17NlLpT6wZci4xQLtPM/PwTZ021z+8teSHy4U2s2s9s9aYniAhwl655OG8drlozTXBb3r3+Wn5NUiZ702OS59RI2DaUG9i0SJWPd5F8Ikeo4eRyORwpGfGNbA9TrMaN6GSlQEawmk8TPsuPvUj8J7ABlkgi+6ixbLclJ9ogOIYIBqJM6ZKRdbUD9xIRhPv+b0Uy+/pceIvWHZKZtL0/4BEfHLJnteN8aqtcn2O/nibnAcZ26+3mfSUIEjTb+8Swdz3TSeFw5n+UQ/zE/8XzQ7hXSLDUD1esx2R0U1nQcko/RWqK/vnpKZ94RvODKuaI7rre3PY0C51B48ao1QOAh9vIdZgN1d+D+1bmvvAk3WMIFw6aycGjrriLuQ5GH2MPZBfSUMSIkycssnToWJPVC7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(396003)(376002)(346002)(2906002)(316002)(83380400001)(7696005)(31686004)(38100700002)(53546011)(36756003)(956004)(6916009)(2616005)(26005)(44832011)(66946007)(66556008)(66476007)(966005)(16526019)(186003)(4326008)(6666004)(5660300002)(478600001)(8676002)(31696002)(8936002)(6486002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eU5mZktDTTZnUVhhdktOdnp4bzdNWDFYcnN3VTdlUUdrZ3RwVTU2ekFuVm5K?=
 =?utf-8?B?NHBWeUV2ZC9xTytXaCs3QnFjdkU0dUtTRzdORm5vWVVyc0E5YWxHOGNSZTJO?=
 =?utf-8?B?eUVXUm92dkJJUDNmSEoxM3J2NHE3anprRmZaZDMvcU5lNEhnL2tQYldib2tB?=
 =?utf-8?B?YTNJdkhLbXBrVEcrVzJ0SXdmN3dVL2J1OXpmZVlTYW4xbjZPQkN2c3RmU2VC?=
 =?utf-8?B?TVhjRmdZWDk3bXU4Y0Z4L2g2YkxPTkg2NDNNRUtTUmFpcUU1MHBCS0pzVENT?=
 =?utf-8?B?ek5PcHZGbFVHWFZrZ01BN2p5NUEzTnlCdGZod2s0RlRjZGZ5OTdaM3RmdlZK?=
 =?utf-8?B?bWdEN1U1KzQvQ2lBZ3hBeC9JTG9ZeDQraWNFN2RVVDV6ZlIwSnBYeFJJb1Vk?=
 =?utf-8?B?V0R4NDRybk0wTHRza2hJRkg3THVUdmdnN053ZjRYUk8zREs0R1c1TlcxR2c5?=
 =?utf-8?B?aVI2VTlwM2NpZHM2YVoxZDhNbmRvOW5tTFBlOEVHZENOdHVVSFpCeTkwb0dW?=
 =?utf-8?B?OVE5bldSaEVCOVNQdzYzYklFZmhwYzY1UGVkOFB5Tk5TNUphc2lkSXFnOGJF?=
 =?utf-8?B?WXdXRm9zZXcwRmxraGJ0Vyt0L1dRTkM0WWFlUkRVNHRIcS85SVNSWjhOQzdO?=
 =?utf-8?B?T2JIQWsxNjFuN0JsMlpaMUxzNHdmRm85OGlRaUNrV0cwcnVkRGNIQkdTTnNF?=
 =?utf-8?B?TTl2UzBqbGw0U0NpZEFCUDJza2dPdDAyalFDdWxXNE8wMTBzcUh6SWtKT2Ur?=
 =?utf-8?B?UzRzRTNaam0yVlBxTVM4cDB2THdMMklLN01qRjFDTU5RQyttQ2UzMXZLSHRs?=
 =?utf-8?B?OFNkeSt6MmVVTXJaRTVBWnRVcHJMRzNGL0RvcFRDYytlaFBBQXhWdklKdTNw?=
 =?utf-8?B?WFNmV3N4WHVVZHlHSkI5SFhFVUgxUlVIdUc5cUtzNlorSEZkV1RvaDQ0SDFy?=
 =?utf-8?B?YVRxL1Fjd0xkeVdZcmJ2ejVBY1YyZTRTRWlJd09OR2dTa3VacExZZ051dU81?=
 =?utf-8?B?MTkxSEdTZ3RqV2FJVnB1TXdjbW5JMHNFTWhsTW9aQ3Uyd0VXZnk3cWhXZ2NT?=
 =?utf-8?B?VnJqbGFsK3p0TlQ2N3BaYUxsS2lrUmpGYTRreGFwUTlWd3V5eEI4N3huRG9D?=
 =?utf-8?B?VXVvdFdqNFduTS9yKzlzWXNDTVBBOFVBdmdkN3hyeHpLd1ZsSEZ5dThOdXl1?=
 =?utf-8?B?dnZ3SzkwRGEwTng3NHl6a1VRbFVjSjhnRXp2SlZwMVlhSEZaVW5INmZ6clhU?=
 =?utf-8?B?QWp3NDdORjZpQXUxQVlEelQvM2ZNM3VGVTNGYklaYlhVUDRQN25tZFBrTG1N?=
 =?utf-8?B?ZGo3VExCYm1NaUM1Ym9tVWRId24rWjlJMmYraEtqT2VHbjBudjVxTmxYd3Q3?=
 =?utf-8?B?cVNYOXBCU2xyQ1ZVSktGRG5UUUVIWGtIbHFrKzhJWW80TnNtTUVhMkFwb1FH?=
 =?utf-8?B?b0wvblNsN0d0WlhaVEd2NFhTN3B0bXhiemhyTEVGdHhwUndZakI3dXY3MktE?=
 =?utf-8?B?ZkVDSUpWOVJHYVlQVkhjVlI1M1BtNjVWRUVXckRuRHdkQ0hhMDVIRG9oVHJG?=
 =?utf-8?B?c1kybUc4YWo4eWR0SUhjMWl2eXgyc1Q1dUFCeXJCUVpqL1pLeFJLUnBIdm9O?=
 =?utf-8?B?REt4dHhzVkgzS1ZsR0dqelgxQmRIaGllWERUaXYyZlpoMFp0VWVyNUNqbTlP?=
 =?utf-8?B?MVZUcVR3UHhyZk4rTUNwZ2pyM2xNaG50UDFVSlFaYzVOM3hJakUrL3p5K3BW?=
 =?utf-8?Q?OFLOZje27/qpm4BB3xnIX6ljjgnwlT0BhINI+KJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395998f4-2666-4981-14e4-08d91ecf28b7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 16:15:34.1807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbSgQH0O/gPCxuvq4DPfIh0juaBkhqsDab2Qnh9oJ+TeKb4Ubgs0EGlns+2B0TOp5xL/q9kqxnRZ4cjAwI5gag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2629
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9993 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105240097
X-Proofpoint-GUID: IKv7tQzS9QA9wwjf-kKXgovmAGmUkjX_
X-Proofpoint-ORIG-GUID: IKv7tQzS9QA9wwjf-kKXgovmAGmUkjX_
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9993 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105240097
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/24/21 1:55 AM, Jan Kara wrote:

> On Fri 21-05-21 16:36:12, Junxiao Bi wrote:
>> When fallocate punches holes out of inode size, if original isize is in
>> the middle of last cluster, then the part from isize to the end of the
>> cluster will be zeroed with buffer write, at that time isize is not
>> yet updated to match the new size, if writeback is kicked in, it will
>> invoke ocfs2_writepage()->block_write_full_page() where the pages out
>> of inode size will be dropped. That will cause file corruption. Fix
>> this by zero out eof blocks when extending the inode size.
>>
>> Running the following command with qemu-image 4.2.1 can get a corrupted
>> coverted image file easily.
>>
>>      qemu-img convert -p -t none -T none -f qcow2 $qcow_image \
>>               -O qcow2 -o compat=1.1 $qcow_image.conv
>>
>> The usage of fallocate in qemu is like this, it first punches holes out of
>> inode size, then extend the inode size.
>>
>>      fallocate(11, FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE, 2276196352, 65536) = 0
>>      fallocate(11, 0, 2276196352, 65536) = 0
>>
>> v1: https://www.spinics.net/lists/linux-fsdevel/msg193999.html
>>
>> Cc: <stable@vger.kernel.org>
>> Cc: Jan Kara <jack@suse.cz>
>> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
>> ---
>>
>> Changes in v2:
>> - suggested by Jan Kara, using sb_issue_zeroout to zero eof blocks in disk directly.
>>
>>   fs/ocfs2/file.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 47 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
>> index f17c3d33fb18..17469fc7b20e 100644
>> --- a/fs/ocfs2/file.c
>> +++ b/fs/ocfs2/file.c
>> @@ -1855,6 +1855,45 @@ int ocfs2_remove_inode_range(struct inode *inode,
>>   	return ret;
>>   }
>>   
>> +/*
>> + * zero out partial blocks of one cluster.
>> + *
>> + * start: file offset where zero starts, will be made upper block aligned.
>> + * len: it will be trimmed to the end of current cluster if "start + len"
>> + *      is bigger than it.
> You write this here but ...
>
>> + */
>> +static int ocfs2_zeroout_partial_cluster(struct inode *inode,
>> +					u64 start, u64 len)
>> +{
>> +	int ret;
>> +	u64 start_block, end_block, nr_blocks;
>> +	u64 p_block, offset;
>> +	u32 cluster, p_cluster, nr_clusters;
>> +	struct super_block *sb = inode->i_sb;
>> +	u64 end = ocfs2_align_bytes_to_clusters(sb, start);
>> +
>> +	if (start + len < end)
>> +		end = start + len;
> ... here you check actually something else and I don't see where else would
> the trimming happen.

Before the "if", end = ocfs2_align_bytes_to_clusters(sb, start), that is
the end of the cluster where "start" located.

Thanks,
Junxiao.

>
> 								Honza
>
>> +
>> +	start_block = ocfs2_blocks_for_bytes(sb, start);
>> +	end_block = ocfs2_blocks_for_bytes(sb, end);
>> +	nr_blocks = end_block - start_block;
>> +	if (!nr_blocks)
>> +		return 0;
>> +
>> +	cluster = ocfs2_bytes_to_clusters(sb, start);
>> +	ret = ocfs2_get_clusters(inode, cluster, &p_cluster,
>> +				&nr_clusters, NULL);
>> +	if (ret)
>> +		return ret;
>> +	if (!p_cluster)
>> +		return 0;
>> +
>> +	offset = start_block - ocfs2_clusters_to_blocks(sb, cluster);
>> +	p_block = ocfs2_clusters_to_blocks(sb, p_cluster) + offset;
>> +	return sb_issue_zeroout(sb, p_block, nr_blocks, GFP_NOFS);
>> +}
>> +
>>   /*
>>    * Parts of this function taken from xfs_change_file_space()
>>    */
>> @@ -1865,7 +1904,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>   {
>>   	int ret;
>>   	s64 llen;
>> -	loff_t size;
>> +	loff_t size, orig_isize;
>>   	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
>>   	struct buffer_head *di_bh = NULL;
>>   	handle_t *handle;
>> @@ -1896,6 +1935,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>   		goto out_inode_unlock;
>>   	}
>>   
>> +	orig_isize = i_size_read(inode);
>>   	switch (sr->l_whence) {
>>   	case 0: /*SEEK_SET*/
>>   		break;
>> @@ -1903,7 +1943,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>   		sr->l_start += f_pos;
>>   		break;
>>   	case 2: /*SEEK_END*/
>> -		sr->l_start += i_size_read(inode);
>> +		sr->l_start += orig_isize;
>>   		break;
>>   	default:
>>   		ret = -EINVAL;
>> @@ -1957,6 +1997,11 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>   	default:
>>   		ret = -EINVAL;
>>   	}
>> +
>> +	/* zeroout eof blocks in the cluster. */
>> +	if (!ret && change_size && orig_isize < size)
>> +		ret = ocfs2_zeroout_partial_cluster(inode, orig_isize,
>> +					size - orig_isize);
>>   	up_write(&OCFS2_I(inode)->ip_alloc_sem);
>>   	if (ret) {
>>   		mlog_errno(ret);
>> -- 
>> 2.24.3 (Apple Git-128)
>>
