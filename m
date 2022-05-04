Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD1151B00F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 23:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357725AbiEDVJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 17:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbiEDVJ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 17:09:29 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFB34E3B1;
        Wed,  4 May 2022 14:05:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iup3fJUin72aYyzusXK4hW/kNgzYvSLOx0XqZwUxd/lWXG10ZSZI6Yu0xWQLANzKNzbfPiMmJbBijr5kD0u/fP5mjGXcVhxIuTC8vwTGhUWtjwsR9jFtJ7D64ks9MB0iGt3TVYA5sSHIf3JOOqAZsc7Fd0qBdoYnMKdYIJEdAZJ6EGIise74ermZmX3G9lIRDGyAldLyO4DsxL8oUQa0PGojbqzFmIdGsBEW6PCDk0va2ohWpnfhDI8Yy1ghsb4/wpI1cpJLU6szFXbC4L/mvVYW65Cl2+W9w8c2d2K5eL8jJNKjTswksMjs9lhWWw/MTjWBCr7j3qP+7gtMqMXGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCQKY+/95MzbQTPBgMZ9KzBLdqJzlOSy7i6jC9+qGsk=;
 b=WB+y0xCcwwPv2PVA8PYoqXBu+o8LHC+D1eP2NaWSrl5pVvBlioRyJW/RRlm59ZZ9nTnRBjQ1CPJsZcBOm4evUQTvjJtNX5HvLW2MSCVzqkMFQ5hKVH4yQN5KfpMukW5fK+QBWU+3fltNeFRolgZR4aTHA62w6Y27xzmuje0iMWVxNJTj9uuz7UVHRciufwPDQF58qbERdw+3Dk4+zgrOSgI3xVLvOPP3EfPkqxCmmA41cqD2LoTthI60Kqko2A9sQ0ZxlZPtCVUvWXFmkfSU4NkcU/ZWUR9+Fe71sCA+fdIfxLcQ3GwrqsM8vNK//sUXygGrOWVzxg9Rq73p3j/fSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCQKY+/95MzbQTPBgMZ9KzBLdqJzlOSy7i6jC9+qGsk=;
 b=mV5kbZ3AZGNTEUNS/HJRBiRbFzRLWCJAI6WNsIg6YGkAewYR7itOkNY7/Z+lOeY2y3woDIMIqeh/icbEnNODJ1UkC2G2o6kd+MeFmuTNPWt5qXdVWqVe/lci9j/9bc/ujetGn948HB2V3KSXSkLO2fJ8LgzHQyF0ae+s0Q3HSWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by BYAPR19MB2421.namprd19.prod.outlook.com (2603:10b6:a03:132::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 21:05:48 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8072:43ab:7fd0:26a]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8072:43ab:7fd0:26a%4]) with mapi id 15.20.5186.028; Wed, 4 May 2022
 21:05:48 +0000
Message-ID: <bc920c9a-516b-b102-0c78-079c5b51cf36@ddn.com>
Date:   Wed, 4 May 2022 23:05:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 3/3] FUSE: Avoid lookup in d_revalidate()
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>,
        Dharmendra Singh <dharamhans87@gmail.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Dharmendra Singh <dsingh@ddn.com>
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <20220502102521.22875-4-dharamhans87@gmail.com> <YnLkjDhcmEqTSpRr@redhat.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <YnLkjDhcmEqTSpRr@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR07CA0059.eurprd07.prod.outlook.com
 (2603:10a6:20b:46b::34) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd7f956c-e949-4bf1-5358-08da2e11dcad
X-MS-TrafficTypeDiagnostic: BYAPR19MB2421:EE_
X-Microsoft-Antispam-PRVS: <BYAPR19MB2421FD0DC7C104DE16558C8AB5C39@BYAPR19MB2421.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RzHfVOfbfglm5levEuCAJ7J+G6QY/665r0VK0L+ocv6+JMuSrlkm14qBeDRwM63yu3UKKzO7/mlNPPIQBOPJJCuY1axSZuMBeqm3AK2k+v7f2yBFWiiKTdKqNCsbd5M4kv7JVavJ3xrvp7gvAbRH/jTXyDhoqjE5ONvckX5yw8pOKAgpn8RkQ+C2RoADSw3/bk4gubi6kS0I0Mr9Rsiv+dmLnHqva6zsG4EC0Obygr/pgEKOkYJSXOjfPLACl30lK15pI9znL0lgVZvoi6u7FLDAKJOLT+Z/EPQxKyf1hClXoI/N6ZTLkq0ejYvISOglsDJ3Lay1rhTBgMRRenlCQwcWsXK7ptHYa+aaCHQ2kZZfEHMmSTQUuHLgTfMMexgr47uu9mIoXbwY4em5BGWelxla9VrVLqTfo9h1sIScQhxjeBGWrl5cR1I8mb7MzWUTsWtFygy3pWaea6cEWpWW0ipt2Rs0mC5RV+sfZZpvdlN1eg5YFsYnpkGET+NQdIIOkKSnfR2ohEtrCfg76ZUrDMPJ4bIpdVMFjayrT5TVV5McFjYc2f0RJZgGRRj5lQrYTul7Uh8h3He1SQ7Rofn6Ne0VrBAMKShM9Uo3m08etm7O2lkCT6wkIBkQS6bjS7V1nLmusd2+BqhYtq/6UDlxIcccqn2V3NdqiqtE5laP9a+DEJCrv7GYo8qEEbyZ9ZcPikUm2WP3wT+z2UY3MWT+k7evcMH2v9oUGrQMa2QC4Ok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(36756003)(2906002)(5660300002)(8936002)(53546011)(6506007)(186003)(2616005)(83380400001)(31686004)(6512007)(6486002)(31696002)(4326008)(8676002)(316002)(86362001)(508600001)(110136005)(66556008)(66476007)(66946007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3dGZ2xhSXNmWHFjNHg0b1Z2YmUyTEROa3h4WnhHMHFJYjc2RkFUOVQzT1VU?=
 =?utf-8?B?OWx2S0hYTnVOcXhMSS9mSlg3OEFGbnI5TU5landmNXNoaTdCaVFOREQxdmw4?=
 =?utf-8?B?dlVIZ01raVNidVd2TDVEYjBGMHZDVXUwTUZmN0tHZ2JLdjhKbTlhd3FsQzRm?=
 =?utf-8?B?bGVGZUgrcW4xaU5TT3FVdy9ybFhTK3FVT2txTWMxK2thNmlCYW8rTUszbGxK?=
 =?utf-8?B?bU1NY2cycTY0U2NYaitNNmd6K01zTFRSeU8yd056NnFkeHBDcksxNlM2L3g0?=
 =?utf-8?B?MkltNmZKU042eDNielJ1bmtXLzVmMlJlNlhFUXVvVEVleUFLTXkrb1BGZzh0?=
 =?utf-8?B?Mmw5TUJYV3hmUEtNTVJlSDVMbE1BNkJGR2xhK0Y4aUxXcXEzaGVaN09SNk1P?=
 =?utf-8?B?ell4QVNWUTl6aE15YVJhUG9NL0ppR0EzcERvZ2NsNFhpNUlLc3lJWkZobjlJ?=
 =?utf-8?B?RkU2Zm9QN3BGdzRZNXROV2FxVU9DTHdnR2E3UjIrVnl3UktLWXFWb29vNkhC?=
 =?utf-8?B?ME9xNTU3S2NTb05pK3RlSzdmSUVUWE9SOXhoa1IzVTNERVVUVVdCT0JQSmJB?=
 =?utf-8?B?SG1GY2lnNm9MSW96RWhxZkVHSEZoME1pbk41QlZ6cTNCR2pQaUZVVEFLcnBq?=
 =?utf-8?B?dUtHK255TllEZ3lWZVlmRGNOVllSRkd4dmZ1VUxTUVNGVTBmdFdNUVVwRTlv?=
 =?utf-8?B?VTBpeFpkNjlqRUgxS0ZVRk9MWVJtV3VSaFYveFlMTlc4dXhFV09MUjRzR2Fu?=
 =?utf-8?B?bmgyMG9XS09naDdKVkJyWGJuYXd6UHlYQU5YZUZWY1dPWVRqN0lMNHgvRzhR?=
 =?utf-8?B?NXNLUEdUV0owbldvcjgzUDVTVVdNUDlnV1NjSXg5WXhjVFNUV2JNc2xxN0JB?=
 =?utf-8?B?WHNCT01zQTRSRVVwRHR1a1J5ekNjekMvbG5GZFBNNjB0N0hZSHp3eU9YZUdY?=
 =?utf-8?B?SDdXbElUU0lSOWdtczAxRVRWbXcwc0ovMjJ1M2VrdE9Ga0FZL0NvQTNEZ0FN?=
 =?utf-8?B?M09JZmJOaVNBZ3pSR1RWM1RDOTAxUnFEV1NGcDl4c2ppbzlvS1REM2hadXRU?=
 =?utf-8?B?djQ2cVhkb2d6Mnl2N1RHSjVPTUZWNWdhVXk0aXJRMEFvWTFZM1MzRERIYnFE?=
 =?utf-8?B?VitlNGdKSnkvUG5IU0ZFNnpoZ0VVMlhCell4Y0grWTJETHhyYUJPYXMrYUU5?=
 =?utf-8?B?dVEvcVBmNkNHOGlWd3AyekdKUVdYK2lDZTNXY0lTczlJN1Y2dkE4RTcxTEpB?=
 =?utf-8?B?cUR2WE5OdG5SOFJ5TTFhUU52V3VZeGNrTTliNktXZXc2ZGdJZDhDSFpOYSth?=
 =?utf-8?B?Vk1aSytWNVVGVXc4WDB1YWJmOTNaZWhYcWRDVitVWSs3bjl2ZWY3WXMrdEZ1?=
 =?utf-8?B?WEk1cld3OFNPT2dLUis0ZklyWW1mdTc0aXUyRlVjUk9MZlM1enppcU9wZDBP?=
 =?utf-8?B?Tm5OUXpzNHAxd3puNlVzRzNPaUZLOHI3eEhxWmU5NThTZVYyck5UUTlBNUw1?=
 =?utf-8?B?ZlIxSE8vbVFnenorMWZBQUhPVTA5akg0WnZlbzQybHlFTTJqQnlMNDhqSXVI?=
 =?utf-8?B?NUZpTUdKUlI2aTFXa1dNdTlUM0RUVmxZTjBuRll0VlI2K0w1RmhVNnJ1OUVH?=
 =?utf-8?B?NnJOS3ZpMkJPbUw4eWdrUFZPcmxUQ05iN1dkakdNUno4aHdTSFBHUzNTWElL?=
 =?utf-8?B?VGpJMHlIdkF1aWNZRll2QUp2YVVIQWJPcUprZzI0cDY3ZWVUM0crM1hrVm5i?=
 =?utf-8?B?QlE4TEhNbS9BZnI1NkdJYVl2eDByZHprVytaWm5renF1SWJOMURuNXREMzdw?=
 =?utf-8?B?RWJqRnBtYTduL2c4SnhpL01MQ3QzZ3VTbzNnSUJCTSs0OWlhbU1UUk1qY0lU?=
 =?utf-8?B?UHp1YzhoWW5ZK1lnRE1aRm95NVU0WkRYNEd0NGZFdysraFo2cUJOYzJ1SExQ?=
 =?utf-8?B?SGNpM3pob2ttMG9wR2NXUzNFakVFUG1GaWRZT1p4dFhnMjVUa01VcDNDTnB2?=
 =?utf-8?B?cVVaY2tyMTZ6VEd4dzBXYjdXaVE4UElKR1FUd3BVL1kvWVVMektqMWtDNnE5?=
 =?utf-8?B?b0lWQWlwUE9zUG9xRUhVemlxYk1RSEhVSkY1RndYYkZKSEdqbmpEVlplR3NE?=
 =?utf-8?B?NzZ6VEZ3c2dHbUl3UG9tL3M1eTRmUW1ZZHJuZXJ3RFIvams0MFdCTTFFLzJn?=
 =?utf-8?B?RnA1cWdZaDFtRnNKdk9FNmZIZWtXK1dSNDBWMkUwL2M5T21nNWFwUXcvcGRU?=
 =?utf-8?B?QXJkUVlUWnRqdlBoa2lHQ3IyNk8yT0VuZUIzbDRaNys0MldCWWdGUnV6NzZP?=
 =?utf-8?B?NHU5L3d1MnNzZWZySDc5SG1NUVRPRFJsUGZETUcvcEJxOHVla1JSaFVDNXVW?=
 =?utf-8?Q?M5GXAzVY1C4osa449LS8PGr24sp5J7cBmVKai9hJYJJrp?=
X-MS-Exchange-AntiSpam-MessageData-1: uF/F6ycj3mnT9w==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7f956c-e949-4bf1-5358-08da2e11dcad
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 21:05:48.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qx6dviu+NWqGjbmqWOOPuQfUddUjIw18hPcrk4cNt0nPshXDrbtnDCCGQlxA8hCksVSnHfkF/BQh4ptzH8RGaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR19MB2421
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/4/22 22:39, Vivek Goyal wrote:
> On Mon, May 02, 2022 at 03:55:21PM +0530, Dharmendra Singh wrote:
>> From: Dharmendra Singh <dsingh@ddn.com>
>>
>> With atomic open + lookup implemented, it is possible
>> to avoid lookups in FUSE d_revalidate() for objects
>> other than directories.
>>
>> If FUSE is mounted with default permissions then this
>> optimization is not possible as we need to fetch fresh
>> inode attributes for permission check. This lookup
>> skipped in d_revalidate() can be performed  as part of
>> open call into libfuse which is made from fuse_file_open().
>> And when we return from USER SPACE with file opened and
>> fresh attributes, we can revalidate the inode.
>>
>> Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> ---
>>   fs/fuse/dir.c    | 89 ++++++++++++++++++++++++++++++++++++++++++------
>>   fs/fuse/file.c   | 30 ++++++++++++++--
>>   fs/fuse/fuse_i.h | 10 +++++-
>>   fs/fuse/ioctl.c  |  2 +-
>>   4 files changed, 115 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> index 6879d3a86796..1594fecc920f 100644
>> --- a/fs/fuse/dir.c
>> +++ b/fs/fuse/dir.c
>> @@ -196,6 +196,7 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
>>    * the lookup once more.  If the lookup results in the same inode,
>>    * then refresh the attributes, timeouts and mark the dentry valid.
>>    */
>> +
>>   static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
>>   {
>>   	struct inode *inode;
>> @@ -224,6 +225,17 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
>>   
>>   		fm = get_fuse_mount(inode);
>>   
>> +		/* If atomic open is supported by FUSE then use this opportunity
>> +		 * (only for non-dir) to avoid this lookup and combine
>> +		 * lookup + open into single call.
>> +		 */
>> +		if (!fm->fc->default_permissions && fm->fc->do_atomic_open &&
>> +		    !(flags & (LOOKUP_EXCL | LOOKUP_REVAL)) &&
>> +		    (flags & LOOKUP_OPEN) && !S_ISDIR(inode->i_mode)) {
>> +			ret = 1;
> 
> So basically we think that VFS is going to do OPEN and calling
> ->revalidate() before that. So we are returning "1" to vfs saying
> dentry is valid (despite the fact that we have no idea at this
> point of time).
> 
> And later when open comes we are opening and revalidating inode etc.
> 
> Seriously, IMHO, all this seems very fragile and hard to understand
> and maintain code. Things can go easily wrong if even little bit
> of assumptions change in VFS.
> 
> This sounds more like VFS should know about it and if VFS knows
> that filesystem supports facility where it can open + revalidate
> at the same time, it should probably call that. Something like
> ->open_revalidate() etc. That would be much more maintainable code but
> this feels like very fragile to me, IMHO.
> 

I'm not opposed to make things more clear, but AFAIK these lookup-intent 
flags are the way how it works for quite some time. Also see 
nfs_lookup_verify_inode(), which makes use of that the same way. I 
entirely agree, though, that using a dedicated method would make things 
much easier to understand. It is just a bit more complicated to get in 
patches that change the vfs...

Adding in a vfs ->open_revalidate might have the advantage that we could 
also support 'default_permissions' - ->open_revalidate  needs to 
additionally check the retrieved file permissions and and needs to call 
into generic_permissions for that. Right now that is not easily 
feasible, without adding some code dup to convert flags in MAY_* flags - 
a vfs change would be needed here to pass the right flags.

The other part that is missing in the current patches is something like 
->revalidate_getattr -  stat() of positive dentry first sends a 
revalidate and then another getattr and right now there is no good way 
to combine these.


Thanks,
Bernd
