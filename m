Return-Path: <linux-fsdevel+bounces-67733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E902C48672
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 18:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D610188F3AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 17:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505B32DF136;
	Mon, 10 Nov 2025 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VW3XmBKP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="czx50oOe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2113A2DC797;
	Mon, 10 Nov 2025 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796633; cv=fail; b=j+wo6ADQ22s8Sa8kaulmkSdVP63A/MZL4pWrAENERUhpxq8TSmsPCf/t0AchgDPtnRsJzYrMG31m7KUIlh/pEyJTbTMTUY2JrtmhlQjunaXSYUcwxv5lFZjZurx0heIhqlu0ZyqXC8oU5I7/+KT0AYAkgy8L0SRl4Vho4ao4Ggg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796633; c=relaxed/simple;
	bh=J83yKY82k9/auzeKnjX+RY+PEhfq43p4ShqYcF3O26g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nOGSGf3KJhovm7rXyq689HLpqqtU/y1cR5VqDPPjGk6Ab5n+21XUhcMv0GxzynNoOzt41Q6YRSliUYg3/u6aqFX9sl7+200GvgijkSxMVsbDTqsUTY4Mt0yOrgZO6/+gkkqVeIFqbn30Y+iKHNnJu/yDXNsSUwBFw2VTb5hOHms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VW3XmBKP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=czx50oOe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGUKMR030974;
	Mon, 10 Nov 2025 17:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HwOSsXnl+rmoKk4Usj
	B/mITaOjYVyXfJMBtIT7DSA+g=; b=VW3XmBKP7tjDz7m9rW5JfBWldqgRQmDV35
	96AbE7kx6TxOXkWxEGehbmgpklzFILpAWvVc76EI7WXRSIpJX153tqWip/gdxeEy
	p808Ez+xNAoDisi3uFicuNZ3zrwmYuVGyNSHfBmw1IkihWJC4dz72WDWJGxkQvYn
	uLwPglwLscLWN2bwlrlFhSH5NwQXNnyO0EmxJJsns0DOE3DsVbMyABCzmr7p0uPK
	sWuT176sZlNP9sVJFQ8/gKUR4PqxH85pEHrNdsoQgdoLylEjCtzErNN0pGMLr6Gz
	PxQP648RWvlSHRd9UGi47FUeqpm50vZhoF4iG1IpiM0LES4NcBZg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abkmjr6br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 17:43:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAHUGG2040013;
	Mon, 10 Nov 2025 17:43:25 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8f7n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 17:43:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXB7R8BlZO+cBel3YhQXDgz2XkuyTmvpsybNhv0wxqvGnlSnXMKgHA8pfbUK50iH4IydRk8lzwu9DxvwqADDiahbaZQIrVqMIK8EC6DJA0/1u2h9zoGvnBHepiKj+vHg5ULNWPqwYPLK5fTViuyWwcWAX2e4jv8ekLg0PIL7WJ4SaQdzAXonW4FPmuAoPUhZkJ6CRFsmbL+bR5wMj6+/l337VRmYEp7BcUOf/P6w19IWodz4bo+CuvZOFk7pA70eZcnLjEwR1XLhPppQE+dD23NSyDKz/h5WHX+5JfcncBzfZ3OK4ZXwDKZFQPQ44Df6112ruWCM8Pf2SJ5x4Ww5SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwOSsXnl+rmoKk4UsjB/mITaOjYVyXfJMBtIT7DSA+g=;
 b=PGclLlaDKbhgK2mVbQ2EZRAvcwbBEu/y0O3qUY0rDVb0Q7GzZQlf2/Sp8sPoxAm3ErY9jsIx1GOlo1AN6zsg8j76tpjNtDB+d0vP4T4n/TBWKLl7kc4pJ+9SAAkIRlgSeYIJZBXkH9sIiBNYLHKCgBKGP7US8DFMEPS3heiTq4l+tb6gxleG/NgqBLVAThez/dbwAsQaoq+88T3FI1HxMrU8jBP7sxkbAvZW8U+Z0FlX66jVMWeZ4rWK9J1ZOPg/4lzqkxzN4LLbcQAQJIwO4icEHEyk6umIHDrTxgmwVTdDUkKCQFX+BQQUWza9Bw23jWJD8qSAnSm9W1k3Blgevg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwOSsXnl+rmoKk4UsjB/mITaOjYVyXfJMBtIT7DSA+g=;
 b=czx50oOe61B635xKjtr/xNMb4rc1RKLVdK8N5WIbCT87jSwYWoPFlTIq0BnYvj6rD2IPF/h+0GW9CazjiOQ+hoav/r6lh9D2b59jacfq4/zMZiokh226x86iSnojnmMRpMCPkzvTT8kLcBfDtqN8hyqQ6mI5WkTj3wx5rDXmX3s=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB997688.namprd10.prod.outlook.com (2603:10b6:510:384::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:43:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 17:43:20 +0000
Date: Mon, 10 Nov 2025 17:43:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v3 5/8] mm: set the VM_MAYBE_GUARD flag on guard region
 install
Message-ID: <0de18722-d638-48b5-8649-7b621f6f7648@lucifer.local>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
 <99ce6131e27592c92b43ac866da48b4c2a568298.1762531708.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99ce6131e27592c92b43ac866da48b4c2a568298.1762531708.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0324.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB997688:EE_
X-MS-Office365-Filtering-Correlation-Id: 664d2bb5-ef8c-4137-5754-08de2080a393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K3osQvp368zf34ldHs64jnLHa2x0RGL/pQDThrO3nD+ldFOawd8OhRsLGeRE?=
 =?us-ascii?Q?A5gilLIxR3kmPd3NI9KL7CJKBQ67C0TAKsxSMqF213ClySWa8jPNHQ3/KBW9?=
 =?us-ascii?Q?4yVcTXJsjo2MrVejMYidWsqvAVLe6k+WAonUhdoQR7RXkWXPBBO8EFfVheYN?=
 =?us-ascii?Q?mWTtSCe0ljQ5UiEQjWCkFgT8hvv5crhzRtK32TAgCF56lQ30HB6CYhumUq5B?=
 =?us-ascii?Q?msUslcj4I5nbYKF5aCqaZsskraOActaBaOl7nteUwqk8aqOGLRUL8NJv8bzU?=
 =?us-ascii?Q?fbuxEC8cyIpRQdw76nLdTNyJLOJ4xidzARuJ8qVUym+fn4YO0A0ag++CkJHr?=
 =?us-ascii?Q?EXQfUfR9HUtEJVQ/ceVotH8KDbToPe50HGT9EqjRoN0pFBtixc/0uafV08Pv?=
 =?us-ascii?Q?I5Yg0mZFOE7CHzjcsLt1Khafjg6KNUy76mgYf8nFpc1wlp6O+4d8mtP/IgnJ?=
 =?us-ascii?Q?49XUSdIVpx63EXUztAp5iTvtlfSydhnfjmpPwcMhyelHjAVbdUMutbF40zQU?=
 =?us-ascii?Q?NKVZ07vIAKxOMY/hxToFIS1xsEPbTkGMrMWXaz+NhwZUw2lxSEwCTibQWNio?=
 =?us-ascii?Q?vQ21Pmtuyfw9Ixm+tr3jIkTsKiyggm01UFIfbZHv2hAyXUf8X3seFOfL6z+A?=
 =?us-ascii?Q?U/8Ly3oyVSRuLmpGiTXDfDuxbpDU67xapy3Hw66tCnnRgm9al+vDoKJzSZcu?=
 =?us-ascii?Q?y81lv2rDCoXlrGOZCO5n3Zxaz4gX+c7idMIWjez0P/uefyBvAyMjs4e3kchD?=
 =?us-ascii?Q?BEWg2LSlFaujl6ubDkEWM6RLrUAHt8J/WtAaJkF7P1QgMfwGcdY9Cl3tDmuN?=
 =?us-ascii?Q?67B3oFZu1YnBcnPb4pZGHJlIeVW7RL9ObqHJcVvL+SSNb/7h8zvjIXBZji7s?=
 =?us-ascii?Q?WiYl4f7OL4m+MBvpKsw6icbPHjgL2N7nm5/qUWtKRegxZBVz+xzUzTpKK3ut?=
 =?us-ascii?Q?X+XzuP0tXMHF/frmiiePBSN/D2YZV6xZHXFzC9+oYU4Ce2x4LNX8CCFiBISO?=
 =?us-ascii?Q?WD46Y/nu4ITvD6aFylvtaEHaKbh4vldurpbG2bUcRMPWtwecUQPkFqA6RESZ?=
 =?us-ascii?Q?25utO+0nqa0VeZoDGeIOQ6sXPTB4IOUVD+pzGOPl1bXa1PZKUYmyYb3JX9+t?=
 =?us-ascii?Q?rZJtdhx8/cnr02OJPMOPpBQYFqb2o4uOeScjJSPz3sqyIj62EXnBXFPgAm7A?=
 =?us-ascii?Q?feE0FD6VXSzi8qhJ27OycfiJpsQuU55YaZ3StB83dGpeC3G39mI3DNRgNmHl?=
 =?us-ascii?Q?C4J6MDlRGD6v4dNfOqiVx0od03PKx4iPSpw3oeK7bmK043whH93FlHL87XQL?=
 =?us-ascii?Q?Xe/0tAOmBW0aHNhHtzGPvRn/5sN3kcA3dQR8SNx9nRrR+rHo28Xw8pxqJ06i?=
 =?us-ascii?Q?ouoQE008n5O8bpS+CLXU3v4d4ctU1HDaqoMOOkL6C4djOvtmxNsECNlf3d3h?=
 =?us-ascii?Q?fcK1crgUvcp5339kgZwjpw19Cj1gxnM2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AsAc9boa1saudrNYA0RMyWK9A1nVikWAXvLOQpnr2TVEDASS2ErdC/dbzYdy?=
 =?us-ascii?Q?av1kE3YJoL3b3qdYF0u4qPFb8n3sIuAHrx3bx26YHbofJyGisgGWFS8RHm9v?=
 =?us-ascii?Q?MarmkJGEXxt3PgSGh9RsJ6bqQbQuqvM+z5iMj7eO/LGl7nJj2Z/WPI2EL6GA?=
 =?us-ascii?Q?L7AgMRez5Tcb9UJ7Kvh9/THfoyVdASVDwvuo43UXBSr7InTOD/jvycPauUuB?=
 =?us-ascii?Q?FSxmWdyxhQ/lf6lJNhHyDq9W/uKFbQZcimKPjVH0TobWFjEosOWODCkVmXSV?=
 =?us-ascii?Q?4U3P7QYvTy/6ohfU5uiVkmAYqVe0keQQqYixkvqwXdtb+flgaTpL5WjP9Czw?=
 =?us-ascii?Q?Ch0DYP+mIli/HyYBHTw5KOtvVtCemvfA/xYpQ1w0D8XwtA/7mT8jWw/vZUGl?=
 =?us-ascii?Q?o92N0I6n+BOMSxOZcloG3r1+uO67i/3Kh4XRP+s+to6PnBguVnDTtChJUGHK?=
 =?us-ascii?Q?f2Fi8yCbyMP/w8NnbGFAiv6PKK/9/y5wVlxtTRVtMgWmrY2s/M7tZhP4SudJ?=
 =?us-ascii?Q?Wo0zpFFWzJns/oGoWhcCuB07xbwAZfnSL6s2ArRhCol+qpgnHSlOCpH+uS6d?=
 =?us-ascii?Q?OnluQeBsP7ZheGnSD4xB0ZYWck5yhIGgRMfvewDKOdmobNxeGhnCWYbS0Q/M?=
 =?us-ascii?Q?MAMZVr9d/LFFa/bNd6gwQIKKDxg4VsO99RPZBRvfWdwGTWnrFY7PBszYOLgn?=
 =?us-ascii?Q?K0BrzugaUlJwdLaW1Inf+tkxauQdLzfDobWSAiQhQE1iXEMuYzsL2t02agyg?=
 =?us-ascii?Q?Hlj7BkgNZPkl4L5R/nWYlXOgg/OjsGsG2CLik138fokavyIqEGaSWRLmQvoL?=
 =?us-ascii?Q?wtcGXNc0FSJ94I75yJ4fm1KgJEh0Gq0uT5j8/NK4YPIOI+MZ0CyS048UxlLL?=
 =?us-ascii?Q?FHltoxd7zRItHVvyV6amVYLHpk+az1ylFJF8zBYW3MMtK4tMizMd61R97FCp?=
 =?us-ascii?Q?p+3uSTqQ30U7qqoyzn5x7Nay52HkFgb+Byoj3mziHEltQpgHlZ+tszCXthHZ?=
 =?us-ascii?Q?s2W5XcZDPcf27Gc6tLzEOazbQL7bKOWwuqV5EBxQYSQ9lDgQ2+HnSIELMgIN?=
 =?us-ascii?Q?euPm7QE9Pnu3WOiQ/BvtdGLDNYs45g/ERw2kFAJdXO23BQVxu3tLnWNU+y7D?=
 =?us-ascii?Q?ObeIDrjv1iiUaingKN0munzdpjM3Vz5eh4+hfMagbG+BxlqCP8tQfSo+hAoj?=
 =?us-ascii?Q?iNMCW6ablIN3UYkjKK6adQXG4q8CP8amfkNu/vm7IPs5zs5ylCgPKG5rH9EZ?=
 =?us-ascii?Q?/2z7akQ7wEyzlXEkRjV3LQFMLpiJ/j9bMJuWhbuhy6gdrhC2ssbDHtemH6v1?=
 =?us-ascii?Q?Y6A9ITofoO0uVUPTu7HgfOQRSxuo2OgRw0AZheYHYS3UA1swvSHnHJCjPjm+?=
 =?us-ascii?Q?963RXGdst1eHDKfN8TRA+d1Nv0VVoLv9l6Vq+xLg9UkoUQn1xU+C7T+rGye/?=
 =?us-ascii?Q?0wMGGB5musTALouOigB7+bioFOCg1go/glJzTsn+VE0eRRXBt4W3kQbAb0oQ?=
 =?us-ascii?Q?AgeCbIx/ZSkQliIvYl7tgx5ZqPUF21VQtAomanWg5+KJGbTYBd/IBt93NuDs?=
 =?us-ascii?Q?x6KgaNt7vh3etzhiIzOgpoYDlpK4A0VfvZep6a5iujMSjU5tcQ+xsClD9T1D?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r+K8FTvj7i/Mg6oC63NIBzJBWj2pjXCBLWmyeE6b3WsmQkjTYkxh2cgdvjbYiNR/lma6Zj5Hoj6EYTcQLIXFmNSNMOImVbm/uqMqMfEjqesxOnjwv124IekungnUGzHTL0rXDuGAuMoE8Ie1wLdiVsJJxV4Bt0dPes6F5gI/dBnspL2LJERsJhs2s6vT8tCFevcCVqkZ8xTkYm8tbWHN8uH9kcd9g+5OZpw9W7VO6FsdYsVrlqYS3ORr3Jqio+sCRC3hqaF+q0HpQF71Wk08JYfUw+sTzNz/73wus3+CCTtq9WQ9iPtwcLf5ueP86zv05RCYhETT4aRUfFvEsdy6sVSF4bjZW58LpBDqXx3z5KygbBaiURvdQOrrUqwaowmTPtolJmFWZzNoc+jbsy3VJFZi0GFf9rj4U61RVZ7Lc77CInuujwYEp+phFU3ESvk4iK2Sole/p/2D4bgIMFqJNtO+BbQmEhai+quAyt4LNcDgM11x7ClO+A9SZKnYIJnYf7rO9suLbrQN4QrRdlfGCjf1Ft48DfYvq2g4NP5aW4ETQWez7FZwhObeNgyIMjNl7kMF5zDAmeBuelr2VY5VySy9x/5AWsfBteJvyKO3w0I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664d2bb5-ef8c-4137-5754-08de2080a393
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:43:20.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZrLmwMOLLXYKpOYK6T8rYTygGuFKRJsSbyUZhFITmBijUlIeYCDjB+drBQ2ObG/rHIhQP3UKlb8SnD52q32i7z/GTXWNDvaIyPocAyJKSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100150
X-Proofpoint-GUID: QY1KhSBKjnSDfmapB0x2j7YYFBzq7JL_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEzOSBTYWx0ZWRfX6k+tItywCPiL
 fJ/kGFbZWTKSgzCRnpRovluIaJhhAZdeT5/PD0nP/GKkPQZ59gr2xiNOM+rS+MPGEuwrT/zwg2C
 uf2zksZAzsJvn7ygn1JQtKWC2YIJF0TKVQBBS9+3JkcX5LPPQQ3JR+vL9YdRBFt8qmsM+lhqkeV
 C2fPLMqqkBfp6xv2WFuvfJQvZSEfwQdLVFCbN7Haek7p97U8At75l9KIWJML1FOn8ASagD36K9O
 JsN3sNsntkkW/Ym45kSI2Bake9WnrmQuoEzmOPu/1Q2RWxY0GeSt81fha/a1hCCqb252WLHh5Ik
 Wh3xi63xV2ifyWP1AXJ66oadawd8AJXMv4xivUzgJ9/IABxnz9BCpz8LTk4MRMrZQDIBb8gEVl9
 hHM+nFJWs9uw/y5E8gVoJFohVr5Yig==
X-Authority-Analysis: v=2.4 cv=U4qfzOru c=1 sm=1 tr=0 ts=6912243d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=tgKchioqf1pKRLM6KR4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QY1KhSBKjnSDfmapB0x2j7YYFBzq7JL_

Hi Andrew,

Please apply this trivial comment fixup fix-patch.

Thanks, Lorenzo

----8<----
From ed78447f613dc9ef16ce9d7a7e43de993379d9f5 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 10 Nov 2025 17:41:15 +0000
Subject: [PATCH] fixup

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/khugepaged.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index c75afeac4bbb..742b47e0fb75 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1806,9 +1806,8 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		* userfaultfd_wp() vmas.  But since the mmap_lock is not held,
 		* it is still possible for a racing userfaultfd_ioctl() or
 		* madvise() to have inserted ptes or markers.  Now that we hold
-		* ptlock, repeating the anon_vma check protects from one
-		* category, and repeating the userfaultfd_wp() check from
-		* another.
+		* ptlock, repeating the retractable checks protects us from
+		* races against the prior checks.
 		*/
 		if (likely(file_backed_vma_is_retractable(vma))) {
 			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
--
2.51.0

