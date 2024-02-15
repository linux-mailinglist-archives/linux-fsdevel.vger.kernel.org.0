Return-Path: <linux-fsdevel+bounces-11630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 610808559A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 05:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2116A28FAD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 04:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69438C1E;
	Thu, 15 Feb 2024 04:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T1mUc4c7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DIzThlLr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E73FC7;
	Thu, 15 Feb 2024 04:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707969971; cv=fail; b=Np/M8ZA6dH/OY5SUhT7yARtQShKBOJ5mGiLC0ScFmOQsKd0fjGRwuJIyOtGseABMpKqAsHZ4qGwfwY19Ls6Ph1Z7s6RLASX0lfLHlxyHSjOIYa7w1c1yUM5Iyz0w83QFaYT95sc7aB0rzwFkUjZ3faHbwkUJPe7xqzmcTETGPjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707969971; c=relaxed/simple;
	bh=JsLELhWEkG2dG5hw9240HrR8Bf7ea7W4Ay5YnJTiBV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uX89YDDu5GEgOXsWuy+9vcQ0ZKyoSYkrKAuCVKmhxaXXyDu8M1TgS8oGHeTjPhAqD0JOxrZeqij2eZVqVdzYBJ0ZXNpFOfcE1AZ5Byff80x34GduyvGhMfxzzIXnfsOpNFZMIMqIrDwvMOMRZ6ckc9lKussmBwjZUAPRSCHnD1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T1mUc4c7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DIzThlLr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMhtG3007312;
	Thu, 15 Feb 2024 04:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=kaDunI3VrU2cmdOrW2tuKgCd/NNFeW2a92BirTflQTY=;
 b=T1mUc4c7LSw3W2S4uKmTOv71Sj+0RD4F/1cpdz8h0+HJClhZYtPh/ZCZhj7OoqRrMeB1
 wZp5bEv5HKkKYObNUPCa9wUb6jPQ6Oj5X0StC1YYIiBpwdWP1kiNqUIgq/TFfuZeFTFh
 Z+fxECdZFSQIuuhQXG8ql9pqqWnfBWGB/UHrPb54JkFbc7vP2aMMKKMEkKWS7fhfmLxd
 BuVp+yS5C03//ct6evA1blyUVSliaT1HQLh5meqhj2Y70unC/bAXLNzpqXUoZ6J5pfmm
 mg9Jrb0cJvhPtB8nEZztjPcY+vqOChEHcZXbd9CJ83QDXhPEYbzoosEJbB9JuqXdLnnh CQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92j0gxfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 04:04:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41F20oUk031337;
	Thu, 15 Feb 2024 04:04:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9w84h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 04:04:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU1/nOQ1EPFaWHEfGPII9WS4/krXvPiqPPdYmsZ6pbHZjx+ww7/jh+S3p+x8dIQBy+H+YQMHBCtRNuChbH/MgvqPTVm1ocGIyADDXGkljw5D/c6M6iYPeBBvrpc1lPGLhhM5CS3Vo93PVEFbkQyyWMps3YiOjGX32q3HwtVvDcPW4MM8nk5yYwiHPhCu2hriaJpZ7DUcWSD2P5hwY8mHECuVsCzb7sPQBGpshvZoY9LN22BWNxNC5eVXsP+j4cyDUU8qNyCe1Ig8BcNbNYAQNsmTSyhWqrHAe7YKNP4Wexe8S6/RiGElMs35SAL2C+F2n0Rz7CGmMji0rzYjcNXkZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaDunI3VrU2cmdOrW2tuKgCd/NNFeW2a92BirTflQTY=;
 b=ERursZ2b7kwlkoV0sAHZor5MlBdtWuo14ueUgkcVQB1CJEcyGt50SYc76e0Uc7P67TzNEUt1tWvE4kZiIBys25xkVZKR7UeA3QZ7OcCocrLxPo37w6pp3YlF3BI1SYXy+8Ed3KtqQhKTjY3a7Ie5zZCKr8jANLLL52fGVp7hNDgQgq89f4bSJTlesU/UgycYkOYPV1RBZISixzBl93dSoEjYECfFTbwwfvly36MqAV6CmHdUTWec3DD5zASKZRdx/CEovjs37PnQGDVnsfFJzSVWvYwI8jL0qOZpfFE5JgJ3/sS4egNy6/bO7m++3ZUDLj1OB4Jz/iKxYQfNDW80pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaDunI3VrU2cmdOrW2tuKgCd/NNFeW2a92BirTflQTY=;
 b=DIzThlLrNUTRUhzIoOj+PMTZqQPMcfJGKTHcHpmfIIfPO0sro2Jo3ucYV3fajbB2aoTmXT4rh3UlBK4Ep73jnf0vOD87UAfwgDY1Hzd8Mb2rShy5URuHAaysMQnAIC1WIWvcNoyBfxDaVnF86shTSxzlQbttQ1UEpSatVmqvbSk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BLAPR10MB5300.namprd10.prod.outlook.com (2603:10b6:208:334::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 04:04:53 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7270.033; Thu, 15 Feb 2024
 04:04:53 +0000
Date: Wed, 14 Feb 2024 23:04:48 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
        Kees Cook <keescook@chromium.org>,
        Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev,
        mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
        david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
        tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
        paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, ndesaulniers@google.com, vvvvvv@google.com,
        gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
        elver@google.com, dvyukov@google.com, shakeelb@google.com,
        songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
        minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v3 23/35] mm/slub: Mark slab_free_freelist_hook()
 __always_inline
Message-ID: <20240215040448.ycfrrqbv6chjeysy@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Kees Cook <keescook@chromium.org>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	corbet@lwn.net, void@manifault.com, peterz@infradead.org,
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
	tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
	paulmck@kernel.org, pasha.tatashin@soleen.com,
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com,
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com,
	ytcoode@gmail.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
	glider@google.com, elver@google.com, dvyukov@google.com,
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
	kernel-team@android.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-24-surenb@google.com>
 <202402121631.5954CFB@keescook>
 <3xhfgmrlktq55aggiy2beupy6hby33voxl65hqqxz55tivdbbi@j66oaehpauhz>
 <6370b20f-96fb-4918-bef0-7555563c9ce2@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6370b20f-96fb-4918-bef0-7555563c9ce2@suse.cz>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BLAPR10MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: 800219b6-fba5-47d2-f819-08dc2ddb432c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NfptJ+x0bObDNfmoPwJFZpbn/Y1uejx2NbqeelCsw07/d0O69rkk59da8Z3xj5qZCw63JhpW5XLxdXIwnkv9vB+z9wmdtzAP0LcVO0+gOg1cSDV88c6v9/EyDWzsL6Kbc8E399yPw1J1oK2IkOmDmTjFekCMAKAwtO7M21oDOlq7oEVtKMvsRjkYnYeDMKFhToetMxA9ROfQTnsk5eNpHwRhN8LUoRttTNDv25lkJJwP8p+1OOoh9tpFIL7GLC8eYnn+VTG0PwPWi3EqowvKdOigcEqWYIrTJB3bzTrqOtuOADmDhiyu7xPciGuqvuYI4npcqQ4mqs7z9yiLrKqzIrseXuuN4CgvSRKLXuB/Z+gR2BkFBdg8kr/sys86IrkhGu81xnw5tFVzuhsEGbj6dctHbhbv44i/cGE+hVGWmrTT4PNbzwrMk3nTjI0JOjiJDWPxyFn+mHKb8q/76TS8BtT/DXdE5/6PAR+C7j9rAB+2dBxlKgSAbRuaOUMG6WgTiraViPBpAp5mJAZfprpj/2X31chF/DzgFpgIKMmg0KKCiL7Rk2Tzeu0IN+5tD+tf
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(366004)(136003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(86362001)(33716001)(8936002)(8676002)(5660300002)(66556008)(66946007)(66476007)(4326008)(7416002)(7366002)(7406005)(6916009)(6512007)(9686003)(6506007)(6486002)(478600001)(2906002)(1076003)(38100700002)(41300700001)(26005)(316002)(6666004)(53546011)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gYLFJ8fk4kEAKbBsM7PU3Fx9HcRMAOf2K2KfqiRVu5H2EXh656UVyGQD3AKX?=
 =?us-ascii?Q?QKZT+LYbYApmFNAaz5gqF1qw3zb5xHls+H/NgQz1JrpT6NomDnN+ZyESFMST?=
 =?us-ascii?Q?ULkjbEQcf8iaUmbxSTrCTo4QkQL18mG82T31tS5V4BndQCVVXHyPq5fM0tUq?=
 =?us-ascii?Q?jQELAio5VgSoGrPj1Wo1vg9uKup+LHeMXFjAJ2g+AcatwsLk9aHzaCdLIN21?=
 =?us-ascii?Q?fGK1KGKQCeFUL7lcGCPp8J7kFBCwdGr1OFymdoticBg7Pd6OGd1jQtEvtEhO?=
 =?us-ascii?Q?bj0/x/FNSBCe+FLAow0Ce7Cugh/Z9FMvxaO16nhxh9PGk7WevJiGFx1awQ7t?=
 =?us-ascii?Q?7U+Q76iR6f/e7uxTBB8iTGbccq6bWYzyGWJTYExoXfTHHQTjtBimCou5IoWx?=
 =?us-ascii?Q?ZhH7IzUXJhYy9jG29lgKQyKTrbPaCoXiMiqkXvKzCKA0O6SI5TBNYt0AQNbK?=
 =?us-ascii?Q?4vDX+ClVTZKIcbgefAoe6B54ja1lmFQN+Ys0QzS2fR+RNv2YmzVai1RvS1SP?=
 =?us-ascii?Q?/D+bH1gkvqJWojNwZSebG76nPNYlze1f/qqPOBhKX2aeDTzUjSP3SJ4lc/7y?=
 =?us-ascii?Q?xuGwL8HaNE9lPHwxjd2uHRC7Fhc2nL5Lmxh3I+JR9yEbOizgECoZ9g3Hl2DJ?=
 =?us-ascii?Q?xCr9FyrbegDB7WBHkQ8JNbBkMlYN4aLHO5aAfWEo2vq5GezDadI5peoULyO1?=
 =?us-ascii?Q?KJNUTNGA1ILG4tOvONpuoXNIisoEQKPrEZybVQ295s8KmEVexUpT5AaVKpm1?=
 =?us-ascii?Q?CMYYbv/5x5eazKxv7Seadg1kZ0FyBjkEFko/17Hr81/NMcHoH1SfM8cvr4uO?=
 =?us-ascii?Q?ftCSdkZpRXnNaA6vi8UuCfNyWOsGhrJC8sbwPm6OqZhwBm4Glalb1tT/UB7/?=
 =?us-ascii?Q?XJ97kPw24tm3BaVd6hXPzIZFkGrfCNywcmjU6u9j0qecXKPoMmiRlHgvt1XY?=
 =?us-ascii?Q?cP4fetV3C/t++XqhAwbeZ2q+zJ2sBb1xtuF//dPQlzC+vXjpMnc55TXTah0r?=
 =?us-ascii?Q?8+ZL4MZs+b/vpp6a94j/h6bMtJnW+CUuL1roJ3scaY/UQdsDVnCSoYdWa+zf?=
 =?us-ascii?Q?aIwWSU2niqj6NPyMv4I3IOffivp4IExwKwQ8dkRa78Tidy6bGv40oXctG5FK?=
 =?us-ascii?Q?OtYqxu91PgTt+KMbPUNQPa6N0RIwqfeOxICkcP/5JA12ypgxl3xG4ScUvvMy?=
 =?us-ascii?Q?ZLXbmGXZ9E6ttr0xTLZ59K3Hg1uX7fo7IKNFAs09CQ3OXVmeSa0/U71rb8RI?=
 =?us-ascii?Q?XEIqeQeX9nj/udZl9T/weML9NRmeMTIS5N7qL18V9LTb/Xz+cg6jYB/vrbW8?=
 =?us-ascii?Q?TLDDt4PVSJUU1dM2skZ2fSVUDxAxIjhkk8HUnBpIZhzvdxTAXfRBNIOzcu51?=
 =?us-ascii?Q?1b+M9fULp1Sq50A8pZzrT+c3sk7HzPI9gGzvYPDKTsqnu8OftkaFSB1bzIvK?=
 =?us-ascii?Q?YJjFBfopP6QeW5C4kH3xoJoX6IArf4aemMSg+qUaNH1Jd/yngZpvEV/LDXyB?=
 =?us-ascii?Q?rhPYPRS0X28DHb0F9oxhB7ThKBa1h5l7N4t2c15L3Yno81OPMhXQn5/x+s5O?=
 =?us-ascii?Q?HyEx3zvyUbz0KvV2lgYY9nRe1jydQIvVZZpd10GF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aCh0UgjHDkw1eoodF+Q5GMZmH3K79/rYuhMSZww3lHo2b3Ix91YkBnH+0hLAXJ1v4D+CIxcNTTZIICO4e9nvcZ+hkmJUgLwSyHrhf1uATUHMA3tSHkCNr5NJyKT0bqTmBp2jpUNmaqHcZc54Vm9IQJhCraktNv9oHOFO8xa8xSgf6TdgxOrsLkEjLgTs6wDuN6DpImW/TfIkvK7XnyKaY14cM2aj2TzmsdzlYEOW2t7YlsE/yBl83/3Td2Z/F4yIpuwqMQ76tQlW8c/92jYSFs6/q+C9GSZKCwHpYUmRyfxQIOIIdI1C8058EydK/YZkC2C0vZOSfIHqTJ+Hv67olj9r4dUYm31gwoR0r+zunm2xB/KlNKXJwKhLWFj2S3bxg3kS2TSuBs6DTI4xCykzdjqjfbNZNf5y8hm+IP6jDelVbbhvmCRslRDgCZKkxN+goNEcQHSAKyyKI7cQE+4z5xOPlePPRbYYmhPdJqIVHBy6dLO+XFLBKKMKTTIXnXGWPRX/ghbZdVUnx0GyC54K/iE5FDGJyfJEa9WXyAlwOF+EqK76uE3a+JfcEBaFoEQpFJdntmfhb+RVwMh5hd9AvYbOJ42evjTGZdedaHZw3VM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800219b6-fba5-47d2-f819-08dc2ddb432c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 04:04:52.9241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skO/ZvETsKv2WqmI4QSeg5xxW3ssM2Zyx3oYI3xOHW//mGziaWvxRh+mvAC7JyK56HtVHu09Dz0JXkdEGWmx9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_04,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=729 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150029
X-Proofpoint-GUID: G9oKB4bg4kvAxjy2khAzR0ABob2OYZ42
X-Proofpoint-ORIG-GUID: G9oKB4bg4kvAxjy2khAzR0ABob2OYZ42

* Vlastimil Babka <vbabka@suse.cz> [240214 10:14]:
> On 2/13/24 03:08, Kent Overstreet wrote:
> > On Mon, Feb 12, 2024 at 04:31:14PM -0800, Kees Cook wrote:
> >> On Mon, Feb 12, 2024 at 01:39:09PM -0800, Suren Baghdasaryan wrote:
> >> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >> > 
> >> > It seems we need to be more forceful with the compiler on this one.
> >> 
> >> Sure, but why?
> > 
> > Wasn't getting inlined without it, and that's one we do want inlined -
> > it's only called in one place.
> 
> It would be better to mention this in the changelog so it's clear this is
> for performance and not e.g. needed for the code tagging to work as expected.

Since it's not needed specifically for this set, can we take this patch
out of the set (and any others) and get them upstream first?

My hope is to reduce the count of 35 patches.  Less patches might get
more reviews and small things like this (should be, are?) easy enough to
get out of the way.  But also, it sounds worth doing on its own.


