Return-Path: <linux-fsdevel+bounces-8133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB1282FFCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 06:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019A72884FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 05:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F83D7498;
	Wed, 17 Jan 2024 05:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="mOuof8l3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B741463A1;
	Wed, 17 Jan 2024 05:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705469095; cv=fail; b=g2cDCU/6c4XyEMRlPHEAhrYSFxAQZdkIOM/V4RiPN1EVqNXula+7vvXviyEUtN4ePmb1vG7nmw73QjuySaYsmCVrzxvynR283yeHf23C93G7RP5fKjozvh3G4M4NoaAPiDVHcYRaZHlvyVxxhea4OqkMTOYIJRLHW42tQC4+YE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705469095; c=relaxed/simple;
	bh=KJwCEMZWna0IR1BeDvQoiGS1SoCm6YKzcTIZ5dUoTfg=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=dLQzxE6V6ndSRr/JLv9DWiUu53JIkflYPSDItofytez1gV1LEXo+EhMgjHRQqupJFWLrdUB0l2ptccBux1j99F0hSoD8drOuDK/Tq2CFSs08WxoyFsXm6Ed5AgHnG1Awss9Bm5oUmLZnARYTpfQWF/GaA3UYkVN08DFENSHZRO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=mOuof8l3; arc=fail smtp.client-ip=40.107.101.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDnP1Uv/W36cD9O8Zx4jkKi57P7j+/dZ5KTVorkOWAR2SDwVrYH5jIppxLvecZHqXoi+/h9x4n9PF5yUKdt7cDApNEIwLF6ufnOX/cbgbwn56oK3IFd5riRn4uNA1JQecm7F61hMx47buQI59a9Jqrwk2FpksgBVyZpJYisg9LswM2AzulBSnmZ1Utk16nn4jcRSDNBAkOOV+tMsikTVAZbWT4puyAWlqr7BL2zDhscLTUsAUir7WCVuMMsbr9vJ9X0QSVuEkearrA8PW17lzRyx08JR2bNIH3pTartvLPvh8OnxWI8MdwgfTmktEgZOa29UoP2faeYVvNEvYFj5Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZ2nYC+1HNKPI4LD2c1bHGCWFXE7sBgGLFsG+sRvMio=;
 b=YD45LX3fm+eMzfSvmJc7MJCaWOr7VLzAjw5CMeRJ/vGDUAAJ8QISoYYFmjwzj7P3gLblznoScl8BteoM0aAmvneLDSJi87HsoYahijiN3gMvrET68yEFgyqU1Y7s425aYm2Uaodrbf0ZH3xAGuNdYwJp7PW6iRewn5/aStn294axAiMUIUQVQWUbkDDPOPSWeq3FhCfDC36HEWwLEfLM+ORyiOvmjRzp+2USIoTPnX4urx829u8KmksvXkIjCYsfIJqm/4MB+oktoydRTrXDE4itDEJU1t4a/YdIml8rNgmaw+VytyfGoSlT4dFSfIOmtVvxENojuqjeROjwo+WGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZ2nYC+1HNKPI4LD2c1bHGCWFXE7sBgGLFsG+sRvMio=;
 b=mOuof8l36nSo2aE4bXgBshhZp6KUr7Tnk8daTvyLNkRdlicT6JcLEzX/ylAaY6mOyjIUXVxeFZh7T6QBU9yU2CyavC3Sb3cr8+wl16KXve6UmJV+y18gI8HitoNvPDJcavJoqm7DrwyeXnnWd0gUygTGD1iyeO8W0uF4cspxAR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SN7PR17MB6514.namprd17.prod.outlook.com (2603:10b6:806:323::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Wed, 17 Jan
 2024 05:24:50 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7181.027; Wed, 17 Jan 2024
 05:24:50 +0000
Date: Wed, 17 Jan 2024 00:24:41 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	corbet@lwn.net, akpm@linux-foundation.org, honggyu.kim@sk.com,
	rakie.kim@sk.com, hyeongtak.ji@sk.com, mhocko@kernel.org,
	vtavarespetr@micron.com, jgroves@micron.com,
	ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com, seungjun.ha@samsung.com,
	hannes@cmpxchg.org, dan.j.williams@intel.com
Subject: Re: [PATCH 1/3] mm/mempolicy: implement the sysfs-based
 weighted_interleave interface
Message-ID: <ZadkmWj3Rd483f68@memverge.com>
References: <20240112210834.8035-1-gregory.price@memverge.com>
 <20240112210834.8035-2-gregory.price@memverge.com>
 <87le8r1dzr.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le8r1dzr.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: PH7PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:510:23d::8) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SN7PR17MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: fad66eec-3654-4b87-bbb9-08dc171ca09e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oiUv5/8lkI9Z8OoTTWTCVcKJ9D1fe7nW55GlsuCfZbPEB32kj3i/L/cGZFF/Aod7UWT1IN2qZzRcjDVbLhOqbUXfkXPaPysVjpo3atspNxHV9BZwQzWPrrVkkceSNuB854A3Ke6FF5BEl8mHXzvHNcvSFxvgtbNuMKlj32IyD+bQtxG/XzRm8H46SP8/9/twNcvAxTXHJR8xMBPlUlj5SUa7KH9vlpJODgMX5kOYVvDttBoQHyvQbyEN0HxOwVanozPkj1uPpWwt4VAb9Nekce+w+7tscZmEQF99e8WJeXY6c/935xmlI84xZ5Zi4/Adg64g1BVlCs6BuK382xHP2sILojkv66vqTqHvCYLFBD/Glccd9n5RrY6BUM7/4O4uADybPDOuufumBPZeA//LvIPF4W3UFBtybv10SFxx5y/dM0xF7w9H2TzNGpLFcwNX7rczAgmHO58tOdrSlSEGqisRmnir+VTgi9Y7c0/zE+7wLDLLvqxLvmsj0hi/qqkJwBJEgZurVF+x/Wo+Y428rA9aJGqYzvpA2ZSloH1QT/BKCVJ/pJS/WPLZU5IiDfghGZzXNf1snPMZVfktGdwymExgM+iNqZfdWvCltsrZ3cc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39840400004)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(8936002)(8676002)(7416002)(66476007)(5660300002)(66556008)(2906002)(6486002)(26005)(2616005)(36756003)(86362001)(6916009)(66946007)(316002)(44832011)(478600001)(6666004)(6506007)(6512007)(41300700001)(38100700002)(83380400001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BQDbqw2BvFnX90OuMt0wZhakFUnNeQ2+OqAgtwkM3lCsU2VlKaIG/0QSUV3E?=
 =?us-ascii?Q?nqBku8CeV/dasfTzugXrIdtLT2UpDJ4iIVALx7SjjJ6hHdzD6eVqjAOMYbXI?=
 =?us-ascii?Q?athLR0tk1HO4wogA/LRoIcbHhGuyZQSMuINCr/n1aJlMVMnpW5ks1P6FxG1A?=
 =?us-ascii?Q?6dXaDRHuZCnEIl7E6PBpgNlSdIwiXe4rVYFq0vWXuMIsJeAU6GQfXBzdv26G?=
 =?us-ascii?Q?WCHPJLStNLB9x6OhRh82CDpu2mI48c6bC/hg16Oic9xkhgrsY+pQN6tQjvP5?=
 =?us-ascii?Q?hUEWRQ4iCktubhPdjDQskjCnCmkKeAdBXckPUhfyi3o2w8+eoHIt/kfnGIGR?=
 =?us-ascii?Q?cWJYawSQScO0Jl1R5z21NixNrMnqC26iSmObq9R1Y4ykKqrJ1SnuhRXgDnnb?=
 =?us-ascii?Q?ETT4cYWctHk3seg3kqZO7c7GbttqTq+kfBHaXeBxRUAjkwHzcz9ZqKn1PCHE?=
 =?us-ascii?Q?5bz0QuMv6mzUh22v6oDxgz+cKt77JZTw8XrcsqgCKfmuS53/H3dV1VqYB9Fn?=
 =?us-ascii?Q?Yc6OhlT3v7DxtmwqFcsAxFa4QTKc0W45Bumw4tQJ8VXvnJ3hkdb+Fl3qNN2e?=
 =?us-ascii?Q?p0IHqfoGE1lFfdDz5Hl35R/8d19owfVi9jp0zSkDMo6yPKH/dAuLWZ565w5m?=
 =?us-ascii?Q?TbhBzLEZB34jJJh+y7bl9pnIBxk54MjGwbSE5QqoL96JmJTUz0J4qQ30m7wV?=
 =?us-ascii?Q?rtMTYNWbWkHfI0BUlq79i073pWcbrYD0ElnMJEHB7brZJ/1n5bKyaFk0JH8b?=
 =?us-ascii?Q?lVv+adTiqF4jz5RXDXIlbGr4QORhbufzD906Wj038YfesM8bR5Dlxge1PZ/c?=
 =?us-ascii?Q?SlBfchJveFXKLOM44MYvnSYZq6hcyfkw0xoLrbPzyPWMpI+lYhS4imQ0EX9y?=
 =?us-ascii?Q?eOt/8bZmlVQ+u3rG+/DG5bgZt0l3ZGQZ/xHgSj0Wpiuqn2bxa/ZUImjHTBJt?=
 =?us-ascii?Q?bDoD2cYTCUcinMju+/Kgs5Ohq6EFBJNnOBfVMjN6NIqrBWYM0RITsPStH4tT?=
 =?us-ascii?Q?KsgZGfyjcHEQ7O97O3oEOz5OCCoZ3ZHNKdclC3Ky9fuFQfyvVjP6irQUWaEg?=
 =?us-ascii?Q?nc0pm2dPC3gx0+faGlWP1gdNU4tl2KsXX+LsYUPlvSms/SQH/3q1ABbQSSG1?=
 =?us-ascii?Q?7L0M8GheDUFFWXiplWY5gc5nFglyHd/79GU8HZwYBjqrdp7RwBThLMxgzva5?=
 =?us-ascii?Q?c2HqTlMEVjromU5lmDQeifo7MUGaEOWtu5/Km9sZSoAyR1INbz8PUi7/WxT6?=
 =?us-ascii?Q?1DXmmWrufonMAXRthnqOHj1KGeqZ5uZ8XoVoNsYwVn6Pp9WsQjIDBpXy2aaE?=
 =?us-ascii?Q?dY4Z1TUZN8R8583rjYhytsHgu3W1V2iTQLFKi6y3cEdCmAP23lG/O3tCMlxv?=
 =?us-ascii?Q?o8QMQ+g9gBQ1g8cTHT5djTnUwytkjArSc1wwEqxtMtrzFLHsBP1tyeB77O30?=
 =?us-ascii?Q?EhnCMh9c+/PSAGmuM+FWfAuXNsqoF5d05iREWBJDN/Kfz9WnTtHhm+WIl0Qn?=
 =?us-ascii?Q?2Qm0Pgw/PfWb2LckrNOSupye+nTnUOdDXwECYv4BzXVoCUaAexnZsS/EVbPF?=
 =?us-ascii?Q?pV0YVM1KEGoZfIwI84+Jm6fz1Sj467y5WvKKO32tMh1FlHlIB8+jC54Nkn2q?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad66eec-3654-4b87-bbb9-08dc171ca09e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 05:24:50.2015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxtQDhuYmxARNWVJvKcwNpakCZRS6axH2jq0VIauLj7omHVoiz4lQ7xZSjvo4z2gOC01Wioz8wsiSAFStDi7IwsxiLBi0sSCNc591sL/+ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR17MB6514

On Mon, Jan 15, 2024 at 11:18:00AM +0800, Huang, Ying wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> 
> > +static struct iw_table default_iw_table;
> > +/*
> > + * iw_table is the sysfs-set interleave weight table, a value of 0
> > + * denotes that the default_iw_table value should be used.
> > + *
> > + * iw_table is RCU protected
> > + */
> > +static struct iw_table __rcu *iw_table;
> > +static DEFINE_MUTEX(iw_table_mtx);
> 
> I greped "mtx" in kernel/*.c and mm/*.c and found nothing.  To following
> the existing coding convention, better to name this as iw_table_mutex or
> iw_table_lock?
> 

ack.

> And, I think this is used to protect both iw_table and default_iw_table?
> If so, it deserves some comments.
> 

Right now default_iw_table cannot be updated, and so it is neither
protected nor requires protection.

I planned to add the protection comment in the next patch series, which
would implement the kernel-side interface for updating the default
weights during boot/hotplug.

We haven't had the discussion on how/when this should happen yet,
though, and there's some research to be done.  (i.e. when should DRAM
weights be set? should the entire table be reweighted on hotplug? etc)

> > +static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
> > +			  const char *buf, size_t count)
> > +{
> > +	struct iw_node_attr *node_attr;
> > +	struct iw_table __rcu *new;
> > +	struct iw_table __rcu *old;
> > +	u8 weight = 0;
> > +
> > +	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
> > +	if (count == 0 || sysfs_streq(buf, ""))
> > +		weight = 0;
> > +	else if (kstrtou8(buf, 0, &weight))
> > +		return -EINVAL;
> > +
> > +	new = kmalloc(sizeof(*new), GFP_KERNEL);
> > +	if (!new)
> > +		return -ENOMEM;
> > +
> > +	mutex_lock(&iw_table_mtx);
> > +	old = rcu_dereference_protected(iw_table,
> > +					lockdep_is_held(&iw_table_mtx));
> > +	/* If value is 0, revert to default weight */
> > +	weight = weight ? weight : default_iw_table.weights[node_attr->nid];
> 
> If we change the default weight in default_iw_table.weights[], how do we
> identify whether the weight has been customized by users via sysfs?  So,
> I suggest to use 0 in iw_table for not-customized weight.
> 
> And if so, we need to use RCU to access default_iw_table too.
>

Dumb simplification on my part, I'll walk this back and add the 

if (!weight) weight = default_iw_table[node]

logic back into the allocator paths accordinly.

> > +	memcpy(&new->weights, &old->weights, sizeof(new->weights));
> > +	new->weights[node_attr->nid] = weight;
> > +	rcu_assign_pointer(iw_table, new);
> > +	mutex_unlock(&iw_table_mtx);
> > +	kfree_rcu(old, rcu);
> 
> synchronize_rcu() should be OK here.  It's fast enough in this cold
> path.  This make it good to define iw_table as
> 
I'll take a look.

> u8 __rcu *iw_table;
> 
> Then, we only need to allocate nr_node_ids elements now.
> 

We need nr_possible_nodes to handle hotplug correctly.

I decided to simplify this down to MAX_NUMNODES *juuuuuust in case*
"true node hotplug" ever becomes a reality.  If that happens, then
only allocating space for possible nodes creates a much bigger
headache on hotplug.

For the sake of that simplification, it seemed better to just eat the
1KB.  If you really want me to do that, I will, but the MAX_NUMNODES
choice was an explicitly defensive choice.

> > +static int __init mempolicy_sysfs_init(void)
> > +{
> > +	/*
> > +	 * if sysfs is not enabled MPOL_WEIGHTED_INTERLEAVE defaults to
> > +	 * MPOL_INTERLEAVE behavior, but is still defined separately to
> > +	 * allow task-local weighted interleave and system-defaults to
> > +	 * operate as intended.
> > +	 *
> > +	 * In this scenario iw_table cannot (presently) change, so
> > +	 * there's no need to set up RCU / cleanup code.
> > +	 */
> > +	memset(&default_iw_table.weights, 1, sizeof(default_iw_table));
> 
> This depends on sizeof(default_iw_table.weights[0]) == 1, I think it's
> better to use explicit loop here to make the code more robust a little.
> 

oh hm, you're right.  rookie mistake on my part.

Thanks,
Gregory

