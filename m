Return-Path: <linux-fsdevel+bounces-56671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E59B1A83E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 18:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5273B3D37
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 16:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD4728AB1E;
	Mon,  4 Aug 2025 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lgWVR37k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zt5JF5F3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F0428852C;
	Mon,  4 Aug 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326479; cv=fail; b=Itj8tRc0M4t9BP3EQwIF+/q18zKyuLodfWdrZwuVp9Ve+tQpJxSa0Ke6My+DynLhB8q0xIQ643IPNh2/vnVy5I7XTrB+P0ai5ECpu3l9Qsl1PG9Dg8W0wa9BbOIW+IZypZNFarsuIQeZHnLBKBTBSp+qYb7XfJPacOZtlY/RTJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326479; c=relaxed/simple;
	bh=Zg6V//d1LRRrV2/dOD4zShwsCuwEihN9Ms/ekHFPYis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q37d5ytwnHnSiJiEIy6jiXddfjOPpuaW4y2u234zK+ipZsZ4SNaDNiNZQgTkK5X7yuRtw+uUFsj0a1zK9wiCLXza0J6yEAQ4kQC56ZPYu1tkrl5LpTRODFiaJsmHAwfA8xaPVzUkKRjN8oB7Ld8MCgU4Ua8N0VKGcHNsJYrNMsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lgWVR37k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zt5JF5F3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D7Re6015868;
	Mon, 4 Aug 2025 16:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Huy3yolEoBdSv6hXwj
	4uZVvdxfcCGaZgSAOB0bSkbDA=; b=lgWVR37kwKDh1G9/gTFj3ObtGNpeH246dw
	JD8D9WQTT+F4vaoZkdic/kKfEajoFmgCMa+ky7pIN2q6fv1DXbkytNjQukCagzsU
	jmHIoGCirf/9WN7j0GApJMQDCCy4VC5kEV3iEDS4rRy+fYAmc4wkSs2VbXD13dEb
	PY1+uphcci6pBeKQEHF+9Aq7xiM2uFdR6/uDD0Zhl6O9m6tSgxNxHHxPNTKqCxMs
	SRD8Jm58mu7pDBJhHVUnUTwfvsK5eZAQa14CcLAjreCaLnn+XgO6dpASOAurKjaN
	K6MK7GdhK9+lr4TwNP6GUiTdcBjgeScFQ3HHvWuuFq0n0+NYCiTA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489994k3du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 16:53:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 574FhTIW028725;
	Mon, 4 Aug 2025 16:53:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48a7qcvsk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 16:53:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oe4Bb6M1v7ATwYFYJNupoFIrmjQDJU2gnisa2Ffma+hbtzt7herx2C0u0VEZyfUABrUn+lSYo4B8AkBTmdTtT1BHIbzQ4rEXsiJ6hfGXiWwrRUzn9h0gfOj/7D5J9FQnHZql89m145u3Kii+pnW+NwHLoCwa25QKduz4TLYQG9WJzEv60gf7O3sF8AuxWpA0xcpoONysmhoKFHyvbJFZYBcfWLkhU3h654bpC6JoLqsQIYXfv+FOfhe+EZhMgCc/RnoY3VUdv9UNcxvjHP45F2DADUgNmPPBMjUrXsw5bErm+X+SHF1BCD41h4TeKlmXIyByr51vx6tNtZtwGMY01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Huy3yolEoBdSv6hXwj4uZVvdxfcCGaZgSAOB0bSkbDA=;
 b=rpdz8yREfASJOaAsdBjfgA5H0nLDW3rnUEr+6TPGKxECVb520nsPTJracdTkUTegIgRlKNOsrmFnFSxmofDCkXg8Hj+7+5HfGvmM3UOlJDBG5t+6ErdOzEH6ymeCux7jb4/hxFHzMlNsWb+TuiZOgwiTB87/NrJ2C96vCPIoXzaIXoxV5Dh38sf2qr1cunPnOV53xaFqKO4J9Qk0or5zgx8tbqFVLG40b8C1wRiVn22OT/wk7lGlMkdd62Ri/5ted4PTgCK9zzzzFsx0J43Vc4QshEAf2pwT6FoSa6SRL0hv+DQ8rtYLv7IQ4TSwcA3QVw4JidtdTrZoJm76wIhcrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Huy3yolEoBdSv6hXwj4uZVvdxfcCGaZgSAOB0bSkbDA=;
 b=zt5JF5F3dXsqKo+xVY/z21kNpJ+ulj/scXvRC4NWyV1gYvjK9LrgbSvkNj+eX4Gm6s8sUUxv8Ytthg2pXKvJEay8sPR5KPrp6xovHzdtqCoC8kZ97zc03Jyf6MDuLyOR+a9gS9LHNJ2VurlVuSLV9L1e9fl2VcDRr5jDcH6nOTY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB8007.namprd10.prod.outlook.com (2603:10b6:8:203::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 16:53:34 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 16:53:34 +0000
Date: Mon, 4 Aug 2025 17:53:31 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
        Dev Jain <dev.jain@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, x86@kernel.org,
        linux-block@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] block: use largest_zero_folio in
 __blkdev_issue_zero_pages()
Message-ID: <372fc2b2-50eb-44d3-a2d5-54e453a50123@lucifer.local>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <20250804121356.572917-6-kernel@pankajraghav.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804121356.572917-6-kernel@pankajraghav.com>
X-ClientProxiedBy: AM0PR10CA0128.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::45) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f661777-f361-4080-bb1a-08ddd3777336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zdyRJjvcMoSTjg/L0esjd4SKndSGJQKX9iQx6pE9HSJ444ZzUBEWmt7VtEEj?=
 =?us-ascii?Q?pH66b8hTc71M8UehdR9VSRgpiee5NdDLaahA5+COrktIA/AggTkYjLntLs4l?=
 =?us-ascii?Q?RvKs9Z2uI1vUoBEaV6uCXM3q6ft65uQydwMJCy5dfTkAeq10E/quFzWxwEIO?=
 =?us-ascii?Q?xuDJ9zRyZvV9WWOpH1XY7Shl4ulA5+vU8nuqQNvrokXq0o+05gckCw6IB+lA?=
 =?us-ascii?Q?hBLuLemJPFgp2LsKJsnR8r8ZTN7l8Py1cDoDsoQT+JfVopZ8EsCtA+SA/bRQ?=
 =?us-ascii?Q?Bck8V6U3kjzCHqjcsneTk5cGQ53LB1NAlNA9vrWp1YhnIzh4FXRrIjpsrK2K?=
 =?us-ascii?Q?ha8TBD4fDP0KdfBGhAr35laR3SvgSISCsx5dYbY3kXAfbnDgwXHk0OL5L2EN?=
 =?us-ascii?Q?/hk9hJaMwjuuVFgvS5tiRgbUus0kB1Patjuf5PjLzi9zPpUSN7MERxr+xmV8?=
 =?us-ascii?Q?kzV9c4bLM8ZHuTkCzb7VmbnufTs+EW4AjG/wcIqnD0TEBL++yXvuiMD5GTY3?=
 =?us-ascii?Q?sSgMC0ZJ7ZIvzqZLt0yZyLCgJV46kN+etU2eMyxYbE7SohDlPYYTfC4tNkVX?=
 =?us-ascii?Q?GVAunnYKtzwIOUnnf87iVjSoEzKnASNETwLB5zFLGO5g04uH3y06nA20faJS?=
 =?us-ascii?Q?lNo+HFbn+EH3LK3wnt6WPXTLcxKBYoF2OzzpId28GVS3+Es85nLQ1gsItj7x?=
 =?us-ascii?Q?2D7LMb5n9/EBfTVL7cpD8YCd4pNBWvOqgjeeQ82qNqqE85V1IbMUsUN34szp?=
 =?us-ascii?Q?51Ll3kFBFhw8E2MmNuJTJLmPUNNDC0VXxmGiaeFYfrH0qKVW8d5SCYsoQqWB?=
 =?us-ascii?Q?Nole1yOFczepTgDBT47Lk82PM4/zaul92hLS8vca9KMs+sDhOwzgHn10cGV+?=
 =?us-ascii?Q?LRuwXwKT0P6D69N5SocNb0jh2B9l9GtaMbqPye2Y5J86cbRmBfrbUU+KXOvV?=
 =?us-ascii?Q?vC+755GL0OtxbpVCKpBEf2IQLTdCBTtIax0bObZMUQFYTXodW9heqweWRJmO?=
 =?us-ascii?Q?cnqBFlPfBzmb0TpniJHaxsJg4BRYVkHb5iXy0RVPl08ZEDcPWpAea3o0X+Rg?=
 =?us-ascii?Q?h8lXOpFTqaShC7pK3hXad1MXGWgbapkBtbtS3SERGPXJFhpcvh5HTmqjcXlV?=
 =?us-ascii?Q?22pt3H51m1LmTGmkvHNcZvHSC8ptuRdYiobTSKGv37MuIrOW+D8sQPC6r6C6?=
 =?us-ascii?Q?Pb24w/8LZYlLBnv2inx7DSldfvgtGLYarqfAI8ep/3LgxOznUgJNnY+Uv5RA?=
 =?us-ascii?Q?tydcorcP+SFREnx2d41LOPY0Pdew52I3wjmiUe3QQfOK6wEpnXPF59c5QEg5?=
 =?us-ascii?Q?PydR9zfIkAKfrMbEiLHSqk0HtTN8ydDrA/GsOJS/UnJ/biYPzECdZpaWSdTm?=
 =?us-ascii?Q?JDijrNPKtuO5dYbxgxxlbRtKdwug18FxvCtfP+5HcnBw/0bbMtX9rgCrcysM?=
 =?us-ascii?Q?TVmcSkVg59w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3tHIMf/pxwIceC6n0ExZjB/lP+NcI5RbVDoVYPbKhOp1eW9gOaQESr+EDuWA?=
 =?us-ascii?Q?ttP0lrzyQdNAwINbc5wYfPSV8Pvrnmjx25EJNnRxAxSVaLl3Brx/do+UAI7Q?=
 =?us-ascii?Q?/vNTTfKY1MctGBmcnUs2ZNSyQwjKx7jTqa820HW+9N4AqNgSusGGlpD/KKeN?=
 =?us-ascii?Q?BZAGIAFyjvRNXD+aqu0kdimHoEBpdZJpMOQeg76e5nFXiDylr3ts4KbAlVKh?=
 =?us-ascii?Q?PI2rsAcTeXxq+p0aYyOSiJmH9aiMlPLbck9ZN20a7/Pt2BD9/CJgwW1YEolm?=
 =?us-ascii?Q?VfUKbwEUvkHomEw4eK/q0js/Kly57Gx8mXUrURnuIoEGwHUSoRZWxQk37VnZ?=
 =?us-ascii?Q?yeOdFG2TUcTUdMBGs12GZCb8dz9vuK5nRLZ4wIT82W6YpuDUhn8jMCPlNVdu?=
 =?us-ascii?Q?6kbQtfc5/EkLqSGFbS4c5JHixOlK2zvD5KFDGJzaJtbV7wzbI+Xxkoqxb/yW?=
 =?us-ascii?Q?xVJgTzwVcEul2ViWleE9lVJf+JDcPJ9k1NdiyVzg4ygY8X1TUYZgbRo+FsSI?=
 =?us-ascii?Q?/WF7y1lt1cnbysvlFkd+4qVAiclCgeTNmmAXpJukS1yj+0w0o0ZJp1Yk+yaD?=
 =?us-ascii?Q?xgS0Sg5VAMK8KQ2i/F0p4N9SUlTLrEgJgi1ITixPKrlYrDKro5CRdoqr0SiN?=
 =?us-ascii?Q?ItLZFjWSZVUky7FfTxeG/DzDx/M69+988qGMGBeSJvBL4Tvlps007xRQYSoU?=
 =?us-ascii?Q?vr8s8gft15MJiQbxQXOH3IdMc0n/8IuGxcrm/xiQzNKWXAV1zXPHlWBisOAU?=
 =?us-ascii?Q?g40ZWvAzE8jAXGQpd0TRgGeOcxnhgXa7bCGmYgX/vvNBYiQjtbyZ2EZSLJA+?=
 =?us-ascii?Q?gi2t+6joxnnXq9nGjhC7Yl2gUoYB/+mCcft8Pfub1V6ZHmo3uJAAFvxOhG9j?=
 =?us-ascii?Q?i2C8V2YlS1RQHP6wTIqsLmz/kf9WwU5hnc5+sLKcvmT4Vw+gGIEa3t8uyLQH?=
 =?us-ascii?Q?E/rzO69H+hR6EjHVjb2KhLKY75nBZ7J02qRND/oNC/2HmFy76QS5r/IYANRh?=
 =?us-ascii?Q?bZKrjE4UkAhltiHSFQPUMdTyWgdeIYH5lU1rgQ5jkiwm3qUDTuKI1nSykwBU?=
 =?us-ascii?Q?5HZehrDW5JyngjCCROjitKYD2NX1iMiHJhe0OTjE1fr4oFrqb1xn56q8iSMP?=
 =?us-ascii?Q?h7zYngpspBevsDQuSrLSVaNtFh51h0xGwmKP2Qlf2yazpXmFNXBGf4AmOT0L?=
 =?us-ascii?Q?VMfqvnflqvku37AoYZQCRfKgZFNIDouI8O3DDLe8WioAQayxPZ79S9YRjoWM?=
 =?us-ascii?Q?vTAjGzyHX8c67QY7NiBlcNlvBnVsfBLER4FCgQKIgUSjH6x/0gqennpBN+nv?=
 =?us-ascii?Q?CRSf3cIMfOhHv2TrPFaiJau+UQ8R7f6B0f1Lx2hcOJ/lsdcic0tSuXe83Vpc?=
 =?us-ascii?Q?Crw0DhAlq9yt74yO85kUM7Gbr4QhoYVh0b6BUHarg2FdMWxVhtJww5LEu2xm?=
 =?us-ascii?Q?CbHmSKhVkRyl9anVmrpQYU/Gu2jQcSELcCCDiLzRPBJElqTGKlnkRYAfgaXZ?=
 =?us-ascii?Q?GnQuISHqEPeEi5ehlfWkEA7l8kr21fPVZmO4PTNb2YXLbAn2b0qNUnFXwRUV?=
 =?us-ascii?Q?WSzMVyUzDxZxtPvggYPQf18y7A/WHUL0bsAdcQ57l4z3InYq0njg8fzdXDIn?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jNumOAEPavQ479iCTwWIYbwknOKfI2b3mecAJV5QhjpVtq1ALPnvxuv0rmhsvxmLSMrRHHpD+YY1GSA9z6CK4qV5bXNOXGqJuTExilI1SDqw6SliO6Bdl/Hkgu2J44G5TN+n3zSTksdllJZNnwgjmytyBogtsjAIdMVESPSDGnmF9tKfS2sZlvsrXWb1zlg3Uzx2+EoDhl5tUKMJ7v+DhtpTMv2xOe1sJYDNupMP/TKyLODthXrebMqaYRX9kMKmSsjSenPAZhu/Q7bA1nTEH56itGvea5DyMaiaj7KkfwFkaptSR4a0MqHf6Ara4+tg4mtQU2YVzSgh6DXvHDthG6TejX1/mOBATB5E84BEkHo+yL1hL8YUXTTDSTs5symz3gOrgRdKjNwW6/t3BgqrkO1V4Tu7TIp8FDZAK9khpJsSU9Qd2BQD9QszYqSafHiIHoG57WwCnPq9uMxNrBVRYSW2KCxa59dXLNbJOZHVdGsOz9vSGF/X04GO9xY6LVicbekJjv9UngLNvNo9sXFBVLCwUuPaJ7CIvn4moW8ARqwXFJoS8viCfmyfLDzccTKHNsPqYjBYatoH5br9Jo0Tav52k/bXkhkWZ01aR/F4I9w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f661777-f361-4080-bb1a-08ddd3777336
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 16:53:34.5700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqDHcJzBlkiTkdtWMgqYTr6fljGmCHFguCsV1MsBjdlQlJYXKFs1IBEodTPJUTIRB4OTPQZVH4Rx2pDY/cLl7opZEPmd47TtUoG2+XDWusg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8007
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_07,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508040094
X-Proofpoint-ORIG-GUID: ffhRtkpekgGAXBQymFbwA3CEdkgyKrOI
X-Authority-Analysis: v=2.4 cv=HY4UTjE8 c=1 sm=1 tr=0 ts=6890e592 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=hD80L64hAAAA:8 a=yPCof4ZbAAAA:8
 a=IwNOw5vzvpDpkoW4MiwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA5NCBTYWx0ZWRfX+kQKIadwYav9
 NpiiNaA16sfiK0RZ+hl3pKSLJHbT+bpomPKunCMCzJ7fgnvKP9ZRca3tprjmQUFvl4MEvyUrugA
 vTAycb1/Heslq8zE89Np9XF4vTkew9oqNMF0yNGqXIEV03p427VOhUIxnl/2Z1pc5s2s7LNg6qW
 DXUfgILgh48sOEVs+efzv+aU9TkU6C123luIULpCObpAusj5LldwP0WsVocCDFNI1zerMvFZZQC
 wztF3YJVWLPDtCCXTxOAkWbnCREVFv+T7vrQLRIFVfF6ONawZ1HlAJ16YbNIjaWiW4dMxdfDpeF
 AzxOyoJ5SKs7vErS5LZYxPZ7kJ+w/ILfhm0cJYtZyftk1+hQ8EadGfNU4dPVcz8qJmFRiNYa3UI
 G6SBTbIvWtVsyrq39w8m/5n/2p3jUyNGbgYBBfQcyeSVqwAuqbdm7ks5TOp0Gl8Sb9fvwEzC
X-Proofpoint-GUID: ffhRtkpekgGAXBQymFbwA3CEdkgyKrOI

On Mon, Aug 04, 2025 at 02:13:56PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
>
> Use largest_zero_folio() in __blkdev_issue_zero_pages().
> On systems with CONFIG_STATIC_HUGE_ZERO_FOLIO enabled, we will end up
> sending larger bvecs instead of multiple small ones.
>
> Noticed a 4% increase in performance on a commercial NVMe SSD which does
> not support OP_WRITE_ZEROES. The device's MDTS was 128K. The performance
> gains might be bigger if the device supports bigger MDTS.

Nice :)

>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

This is not my area, but LGTM from mm function invocation point of view so:

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

We will probably want some input from block people on this too.

> ---
>  block/blk-lib.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 4c9f20a689f7..3030a772d3aa 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -196,6 +196,8 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
>  		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
>  		struct bio **biop, unsigned int flags)
>  {
> +	struct folio *zero_folio = largest_zero_folio();
> +
>  	while (nr_sects) {
>  		unsigned int nr_vecs = __blkdev_sectors_to_bio_pages(nr_sects);
>  		struct bio *bio;
> @@ -208,15 +210,14 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
>  			break;
>
>  		do {
> -			unsigned int len, added;
> +			unsigned int len;
>
> -			len = min_t(sector_t,
> -				PAGE_SIZE, nr_sects << SECTOR_SHIFT);
> -			added = bio_add_page(bio, ZERO_PAGE(0), len, 0);
> -			if (added < len)
> +			len = min_t(sector_t, folio_size(zero_folio),
> +				    nr_sects << SECTOR_SHIFT);
> +			if (!bio_add_folio(bio, zero_folio, len, 0))
>  				break;
> -			nr_sects -= added >> SECTOR_SHIFT;
> -			sector += added >> SECTOR_SHIFT;
> +			nr_sects -= len >> SECTOR_SHIFT;
> +			sector += len >> SECTOR_SHIFT;
>  		} while (nr_sects);
>
>  		*biop = bio_chain_and_submit(*biop, bio);
> --
> 2.49.0
>

