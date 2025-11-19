Return-Path: <linux-fsdevel+bounces-69099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CF0C6F0CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF2433569D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 13:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF1F35E551;
	Wed, 19 Nov 2025 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B9SsE4Lh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MYS69uXE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA4A35F8CA;
	Wed, 19 Nov 2025 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559910; cv=fail; b=d0H9yjOFLQoaEmWvSzGuvv8Db7HBZ15lHu0qoZyldtiZkI11xtzwBelD0cgQcTb3QR/fG+Fwvc/h524J45UFYB5ov0apiCZ6lWorwcR74CCUtt7PcuG+O8qHZD9G1pfPxbIcNQLjEfBSKlSO0fxraibtCfcdYrCUgCwIVC6t2p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559910; c=relaxed/simple;
	bh=YI2fVdT2iTTVwIpIfs+q2TAg7wJXNN3hgOl16qjAsc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DWki3JqQ/sZ+mvXwDfvKjwn4WdsdUum9khqrvMijEbmnoCTHrNfQIsVyyc4tTd1U/F+FdrC3HsyIWXqD0ddQarALco6umnYDweZ0ngHRVnQUxuUApvvmWsnbFpvZfmFY1abFlCUnHZNATcVvdgRNWsHO+CVTr4LRqYbYSufZtDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B9SsE4Lh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MYS69uXE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJDZnMM025315;
	Wed, 19 Nov 2025 13:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=A2Lo34jlk2N1wsoswr
	Mwrpg2tXlXD9XsD/dlloZsjdg=; b=B9SsE4LhHkOwTXJIm9Aq5B2DWwJjP84S8N
	d9yS5P+EUc3/ZNbt0gzbBDOTBQplP9xspfH0ZeMdzdFiyVn06o4F4OQUbX5V31Ak
	D1pFc2aZQHr3qVderc4Bum6r8TMA8BPWHLCrXKP98+D3JwW/3MO1e1Hpm2NpRp6I
	12ytwrdsi3IjFw3xPuXc25E5UihcKx5XyT9l5HhZHDsrpM3Dlrs9TGnw2E9k8DlX
	DD9mgQ/21pwEDU4D4ESrwKyZ21aR2UAYQc4O6WI42hRIy6TMHNKPVyCXMZg+ItHN
	qA11UhvUnLrwHYjhDJ2WOYjviuWXgV46Bz+ncPqaCCx5j3ylkDzQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej8j71pt-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 13:44:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJCat5I004280;
	Wed, 19 Nov 2025 13:40:38 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010029.outbound.protection.outlook.com [40.93.198.29])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyabg6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 13:40:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwMXWcJ0vbVnBvO5YOnfo9KJ1cme7Sa/nfWoAmM2/1absWxXRPTsPBuHQzwUaKA0/i0+n6MsJGecZQQPZZ+U813Kq8v5+yUiLEvxjd1xPuKAZ8PhK7RHlyervSIS1DtX30MCTZx6pKzrrnr9fP7U5CvL7DooX2eVGwyfURTME8gSSwLRIaFIw+iShR0SDRl8Vpbgo9NDj/zrf9BObygMZLJDT5xWerxr6ZekbclB4zrKScyoG3k3ABVD+hHZk4b2pARbpgGr5sqfF4U6mwwFpWQQqQumTqHOEIjc1bb+G/mtP2rRAAML4vV8AYq6GtdezOM+jkbbuynhYiaRJhTpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2Lo34jlk2N1wsoswrMwrpg2tXlXD9XsD/dlloZsjdg=;
 b=Cqi+Akeef4thpp5VRWEqTIPPgZGUY1weRcnvT3V0sTPZZcb4nDR/F+hsH+D5SWnjB5pmxSC/b0BNGC9sLHJAoUWXMHatnjc75V6rGAberRxPM2GXD4w7CQ9Jg8o966LBo3tHyv4Ua/fKa0wKnt6dKl9BJ5f54p+YRxXHN6PF0aWoIkLD5AWYhVJIJcwwPfh7VGC4QME6K6zukGd7Pdtv5ogIXiFdyTe66H0FQjXaDs/jRtOiv+JY5UJbyNBJqPj6RkTC301x2xAIArnUezOjIHe3WawmLpfyUH8dzIH8qPBApncNt4idG4OTXBIqdDAANySkZ6ppe20AAiejFyApXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2Lo34jlk2N1wsoswrMwrpg2tXlXD9XsD/dlloZsjdg=;
 b=MYS69uXEEuF55JDPibRZaA9vdm1+e3TyJHAP8m6FkGFA864feh9Ii1rzwSXB3xFzQixnZrGfy6OFyMtSM+qiF7YU7r3cTgcHRhBE03rK50H9fwSHJRM89nL5S186S47nz28siuaVb7mxTbs46yIO6ArsdE+DHfW0uviSewX5pOk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4472.namprd10.prod.outlook.com (2603:10b6:510:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 13:40:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 13:40:30 +0000
Date: Wed, 19 Nov 2025 13:40:28 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Mark Brown <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Aishwarya.TCV@arm.com
Subject: Re: [PATCH v3 3/8] mm: implement sticky VMA flags
Message-ID: <762f2824-6a3b-422a-a8b8-66b6d5d78fda@lucifer.local>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
 <1ee529ff912f71b3460d0d21bc5b32ca89d63513.1762531708.git.lorenzo.stoakes@oracle.com>
 <25cb4b6a-035b-4193-a8db-685fc4c58507@sirena.org.uk>
 <4dodae73i5ganur6llvbbxcojt4uailsxs6sr5w2jr4a7tzxkf@26rmrmcdjvlz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dodae73i5ganur6llvbbxcojt4uailsxs6sr5w2jr4a7tzxkf@26rmrmcdjvlz>
X-ClientProxiedBy: LO4P123CA0184.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 62df9bfc-f152-411c-17cc-08de277134b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5BbYBXo+xx9pa2pBodbzUWGSuW0FIMjm9P0FlY09trF0lWszG84z6zUFiU55?=
 =?us-ascii?Q?cOPW1CeejJLmUAdsgUnKaC6x0oinh+6FHs43GWvvYWwTp5VjA0czgtJWgNjo?=
 =?us-ascii?Q?LfyTfXUk9jAftxPY9AyEfJbdJatYYVSxt1zEf2HRX7GX9emu+QLJ2LI6iV50?=
 =?us-ascii?Q?Tr2WAXSe5gQFaUc92p8BSf/RLp15FMTpF2aUABsLhPOPBPwTKQccvYCj6A2w?=
 =?us-ascii?Q?c9/hyi5uAr1xSzn1R+6/0oFfRn6TpDjpG8lcdwtkurBGr/MILBlxUmvEsgQC?=
 =?us-ascii?Q?0lwNuPrubGLNWFyTSsUCY9OGExYvdRBsRyLBd7FotEY89mbAgm5TU9a2DWT8?=
 =?us-ascii?Q?fwEDaxTSroPp+Z3U515cpv0glh/LCCHPuO+eN++RaaovfOPzTmZuLMoi/ttc?=
 =?us-ascii?Q?EnvXFfLG7CnaIqJ1XIGOIQkAVsfdpDWkjEDNR+upVIJVAFQbXZ9j7UJhaxj8?=
 =?us-ascii?Q?cBmaHajkdRdVouimjo5D3elvT5bz3qK7ppnm6MgS/TvHPcXtjvQ8R8PDXIhk?=
 =?us-ascii?Q?MIVpLKq0HWZfRfiSF00yqx5bWNzi/wCvHQDwH2nKeN2KV/UnSD+98TSyz9ne?=
 =?us-ascii?Q?iKCRacmDZzFO/Nxn4BgvOB6TNkBgNu+4veQgLoYfyX09ZMZ+mFE/IGT2fyMT?=
 =?us-ascii?Q?Zcs3Fd1yTGhuDS9GlXI7e2Unxgav3vFUlituKZRIw5+lLhmkox0QJBiO78KS?=
 =?us-ascii?Q?KWfmrnac5jpbgytaMV93fP+FwkqxAHmiQTqtnBCJxBCadkE+ti/p1JjIyj6Z?=
 =?us-ascii?Q?aBbtWGGdt8OPTXWdUAHNL0euZeUqYnkwwALJrYdiKDYY86NV8BF6Vz4hza/p?=
 =?us-ascii?Q?pTxNiIQNMfN4N+res7efry9KHt22hYM+yZnTQU5biWVWjddtj4U5ZrSjkNR+?=
 =?us-ascii?Q?XGrllMGzkGSfg8i1/pHTDm4pl4OA9kExzjAZrp38nQbA7j2U/MOivdrsLwwG?=
 =?us-ascii?Q?Ph3PMPCOAd6p0C7+2oFsz45zsSaidQy/xmMNGFJA+TNCUzAh0ehBlGeBiqXG?=
 =?us-ascii?Q?4ll7Cw8zsa6H18cs1CE6nlIc+y4+Yo+fNx7LZpMU0simlt+uPl0Iq3oXBpsT?=
 =?us-ascii?Q?5k+V+NpfRsydKDLZRpKbYvhnEcrXiQEULWOgfo1xBCe83uNpfa5cNknubSpJ?=
 =?us-ascii?Q?K23lTXN2jM8owx5rVJmTYC+1nRM+ZyQZbseXhI8l1zWfjpjm3B28rxFHeA98?=
 =?us-ascii?Q?nfUSfSIErEIuVgeTnp0sPlEAVTxcnDVFEfLON6zW/CPV9/oj8XAasEIdzkN6?=
 =?us-ascii?Q?zMd/MNRFbB7aBYwKcUhdCplP9U6iPUud2KsxIt7dL2IuUlLjWU9WAkimORdg?=
 =?us-ascii?Q?D6RWdnZucVIhdv/p9OHRkcXNjoJhZz3D0YV5CastIGmCZvyvB6BY3hIK16HL?=
 =?us-ascii?Q?pRY9iXPzdQCKbh//63Sw15hwoU3z1QMoTF3cexMTqEZeBuX0qTDk3pru07/Y?=
 =?us-ascii?Q?X8BvYgOxs1ZgCvV+VvAB5zuaAD/AhJiw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8XRgGFpO1rBcRB5L0T0nd8kljl01HrBOiLf0Gaqmz2FP0WCYpdEbCE/d5U+f?=
 =?us-ascii?Q?vi+dpmU2+PfRD4+yhBoaBzTkjMdYNHbpd85HnBErVd5FZ2X6B3oeXyVFLIhD?=
 =?us-ascii?Q?RLtanVoun2eVxliyG+/HHZEgBPWR+TzhdQ9jNK0LqR09KNOD99ljM+aTx9bz?=
 =?us-ascii?Q?Kt++VgUiB3NUFn8GsgXiDIXb3jlUXUccJdU/Suw2Uxyu7G6MhNs4Wy1fmnRN?=
 =?us-ascii?Q?puPb6gvd2P5ejkV8wmlckgiFhZJZ9/gg4wnTSdI8jhqFmTmaHZhL+gA439aK?=
 =?us-ascii?Q?zmjbnF8YduOR7p1v7fIglxMthLlrSMsCc1efHFUYONdIc3kTRXudI77x+eNS?=
 =?us-ascii?Q?Zgv3/H0jAF7VQVzWlu1E+wNtQKXybMzsX2+IFZdF5heLiEwRVir4d/gBAgcX?=
 =?us-ascii?Q?Avnn6/okMzvf8xlYBwXQA0BygMKz+Its2TDrcumxPAj/UN91TjJ1tpLS6k7r?=
 =?us-ascii?Q?q8Rt6wGpNvGmW8SZNIVG20ZlDr8iujt4mMMYY3YyO09o0HGBgFCHQEGE8n6g?=
 =?us-ascii?Q?bxG2laSt12lLbuXkBEXtZ9/1CzjqA2q9AZ0zNsLgGlmswoC6SMScH3QXuBap?=
 =?us-ascii?Q?GQeJJ769GrY5xItgE+v/CGFpCFxQpuJ0sav5KA4xTfG5GpMLuKCadROPe3cU?=
 =?us-ascii?Q?7/Iw2MFeK5O2ptn5LcIsa+4es4iJvwF7iANpedyzYiS8IDULrfKCHwvCuzt1?=
 =?us-ascii?Q?TNHYtxJvpBLbQJNpbVeLrir1bpsdaFIIAKywiDeBTjkAcgjRLyixJhb29NTi?=
 =?us-ascii?Q?V5mpmeZi3jWYMYQUG7YWFHtd8pldaRxlMAw0u+JQg0PftvLm5SwbeRUhI40c?=
 =?us-ascii?Q?bxw3ujZ97Rsd1G8tiuxvcT/v7niY0fl+t9599c/m8GWBbQyjuFd/A1zO3T7T?=
 =?us-ascii?Q?iLUPW5KzjryMPyOOI52bjEfAqZW/VXDEzsvqynRa6iZ7nq0s4ZTPonaQGMUp?=
 =?us-ascii?Q?UNG/rTiogvOqnb8VQ+aMssHsaBUuns10UkP9b5rBnRwTsC3mXpfEIdDzWSZi?=
 =?us-ascii?Q?+74b8Ai2a9tBdwY9W1ixJfVO693fPx4o5G5Uq+HqdXxRHMuoHv9bJas40tcF?=
 =?us-ascii?Q?LNTSWxN9fyxz9SlW4HbiOLnxYZcDfcR722FEDjOsWpE95L1Cf0qpRUu+oJPx?=
 =?us-ascii?Q?oQ/byznVDPGhsZAEcgPBEKMIY7+dQarC3rfhUckLy+d8q2uIsWA3pUZ4ICRn?=
 =?us-ascii?Q?w/pgYYkU7qtWoImQm0/5I5SecG4q9w/TOy+6C9dfenl5hc4b4do5BN1MClXU?=
 =?us-ascii?Q?on/semwzij2TX2QCI6nicfNx8vAxW2k7wKAmWBQ5Jdv94OoTew2jxq2TiK0d?=
 =?us-ascii?Q?TNBfq6qQ+c0jSdczye+a92EPdm0btY7sZCAdI/vgI7r+V7BRo6+PQxF6nS1w?=
 =?us-ascii?Q?Q7/BpAxIXYzsbyalMVxLJ6/ekBP+MS2DaisLq8+LjWN/+z+XaMfM21vRglOH?=
 =?us-ascii?Q?3s3gGb/QJmBVLtAPy7RJxPKEbiVioxZXraxIYKqSz6sqNCFZiqxOM89gd+FR?=
 =?us-ascii?Q?Yn1/LanHCafk88HiEHwFPHoquQsjzvj4yYKuvcZIHJup5pOuyntQYITinP7z?=
 =?us-ascii?Q?oaofPh/bDrUWCARU1Du1J/m0PSmtFKgK59ONJ1nYLjmVvlg+6Z0ebjJJJard?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/eGf9d6q2Wrm6yqod43/Bk0FdMuaYm7HCGn8Nw0bY5QDvuS7iUmODCftcS74sGthDt5fjvGgWD3mp2QWvX6Ai89dXo9Hfrl9jZhEBI/kDyD/uvFqBy0qWYq1bcRwypNfpV7h+QkTEoqz0hz7vWfxIwzEpg3aZiUTRUAqVzmo9+PGK9ZQGCFcrRAcm1aqz+1ZMWZ5fzobTv8yZLnPgnmv2tGnqaQsqR7hH41x4HMAZftBQgeT5caSye9QItnW8303E/KuUc+qUg0JObkbX+BVlpOYp+xZmxw5PaWz1AdFNjTVwHx2c3II+tySskfJB3PNxxT8Gb2SaahPLjioGdISOFQxIKmpvxGCknuthqBPQtIQzy9HVqOvWiciPhBRcWzOOm/2/v06zP3PJtoOwXcMIOPh+CNH471mIvG2+p+dJTpYNi82aU/rJQrToX7IVos+BJmf2G/Qdp/OnyfdRjFSbcA8AdB/Tkq7S66sX4NuRHyFjlpjjx5a7NhpfBxv/n4PL+bY/xaxkf8/UQjqZ0oYYTtn6CahcjuKO8UNbR7JHXeGSaEdx3tQA51TK7k2N9WFphFGrNMi/vrlrRal+E5SKh9Ae0uvMbtcNFksYT0zYKs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62df9bfc-f152-411c-17cc-08de277134b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 13:40:30.2903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSbT8hsS4xvh08D7uy8AYwZcPD12TQiuN2yy36ySGVzIOiVeB4+i4mhosex5Ri4ZlOqWgfxr+IM/1bn+XWz8ZN5DsXHsInQGHrv8guXJiL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4472
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511190109
X-Proofpoint-ORIG-GUID: pV-cPLK3gPqUOaxr9SsdB_7vcT5w-EEM
X-Proofpoint-GUID: pV-cPLK3gPqUOaxr9SsdB_7vcT5w-EEM
X-Authority-Analysis: v=2.4 cv=I7xohdgg c=1 sm=1 tr=0 ts=691dc9b4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=UhNyURFBbM0M6YVT_0sA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX9T/osaEbIJyG
 ttriaE0u5kLGvQ0GEaOWRFlvhvGnZcGy/wQXg9kLscdmzyfh9aE+vBV53s6cVLpTrmaFF898Ku2
 e8em+PV+5Rje9dAxg7j50xwSwgXMf0ryjeAaG5yxeSfVlnJIov6aBylRV5G1dynFm+yvxSRU34q
 Q3JTJQc4pGp1tfjuplDG7zyATFZ+LL9YoQ/S+8O0dZBfjOsre+/SmvIEV9r/kFIJ5IDBCIovWE1
 AKfS5Y68N/Z4Zp3SCN7nBnBPpBMeZZjLe4CRGiSxqhlGRSWLhOCEXxaucxJ3aAY5iFGzJj+gfxc
 JsrwlDaxow9kRdLcI/CeWl2q9DLiZcrkUzBfktdlkBDAcsdfbyz1lA/U277NRuLq4h77KBYjLMR
 8/GL2skzW4h8LRWRLa7/rIq/82YRYw==

On Wed, Nov 19, 2025 at 01:27:08PM +0000, Pedro Falcato wrote:
> On Wed, Nov 19, 2025 at 01:16:36PM +0000, Mark Brown wrote:
> > On Fri, Nov 07, 2025 at 04:11:48PM +0000, Lorenzo Stoakes wrote:
> > > It is useful to be able to designate that certain flags are 'sticky', that
> > > is, if two VMAs are merged one with a flag of this nature and one without,
> > > the merged VMA sets this flag.
> >
> > I'm seeing regressions on multiple arm64 platforms in at least the LTP
> > clone302 and madvise10 selftests, both of which have bisected to one of
> > the fixups to this patch.  Especially given the other tests that also
> > bisected to the same place I've not investigated further.  There's a
> > number of other LTP tests that started failing today including relevant
> > seeming ones munlockall01, mprotect04, madvise10, mprotect03 and
> > futex_cmp_requeue01 but I don't have bisects to confirm they're the same
> > thing.
> >
>
> Thanks for the reports!
>
> > clone302:
> >
> > tst_buffers.c:57: TINFO: Test is using guarded buffers
> > tst_tmpdir.c:316: TINFO: Using /tmp/LTP_clorMwMMw as tmpdir (nfs filesystem)
> > tst_test.c:1953: TINFO: LTP version: 20250530
> > tst_test.c:1956: TINFO: Tested kernel: 6.18.0-rc6-next-20251119 #1 SMP PREEMPT @1763523415 aarch64
>
> next-20251119 still has the v3 version of the patchset, which is Known Bad(tm)
> after a couple of buggy fixups. v4 should hopefully work properly.
>
> --
> Pedro

Thanks for the reports Mark and also for following up Pedro, and yeah this
should now be fully resolved in v4, see [0].

The fixups were just broken but luckily Pedro noticed the mistake I'd made and
so was able to get a fix out quickly! :)

[0]:https://lore.kernel.org/all/cover.1763460113.git.lorenzo.stoakes@oracle.com/

Cheers, Lorenzo

