Return-Path: <linux-fsdevel+bounces-57872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A0CB26357
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 12:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99539E07C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 10:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D972F83C0;
	Thu, 14 Aug 2025 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sAmKejFY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lQCRL+iX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2B81A23A4;
	Thu, 14 Aug 2025 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168617; cv=fail; b=Ms7zG3oymFLnXgKWu6IaUE7oA+zmunXR9M4cKxAx+1XTta2ES+ZbgzmtCUkbGOa1HRcpx8dG6PPwMWmonB8TwAwd2x7FfuIJkASIxni1jlgKcYNr5KP1OqbQiqdIgSbE6iowKtQ/dvFO32TISfaFR88R5ajaWYWzIrglIfGn90s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168617; c=relaxed/simple;
	bh=uNvNCfnrxNmCYRrhGgZF8ZRPy1kVjO8HRRlsYHeAmNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qkhrSo1Ehz874SPRbeGL40lyJErjcPaXvXorUfBPuqBi/htfs0wYe41APXCCFqySvaHbrtYHxPvlrfp5h+s7GrH140VRDYBiDhcHD7t0nHJfywtQhGqW/EJGBL8+SJmYUgIhTX+hkWmVesdcU3pKRL9h+5ITV+oEwuuTB1C3WEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sAmKejFY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lQCRL+iX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E7uAX9031555;
	Thu, 14 Aug 2025 10:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=AsCXOu1H1gpgHAJNhw
	5EyeGSmttLipCRYAvULV08cPw=; b=sAmKejFY7mxlBT19VjuuEOP3eFLKF1rDp9
	zGsSm/6mCQ2nPZS2UgR95ZpbObmBoC5riYBG7Sx8n+m3Vvz+fnVagWemgrN4eXw7
	ILzQc2m38lYA1SsLdK1Rr4bVdFRZK+Nuft/biQnLMxtNlWMDKbjXX3166CRQJ6Er
	cq99jRIaHKyXswFkDDVv7aXGQKe8b89t+hkRLIIqudsg1NZxVaziigtXWg5TKzc7
	ZLZdpziK9shkDxn9rUyrOBTvKwcCoFqOeFl7q1nFtYEkBkowHjKhGG7K/auCOAIu
	CoMbm0om8IJTIomlGHGJwdCXrtNlQcH2xiuCtg6B6YU672rJMnxQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4hnfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 10:49:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57EAIuSi029998;
	Thu, 14 Aug 2025 10:49:22 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvscknse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 10:49:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2hoSSv/iALz2TWItG2nz6qhWk9KdR8d0ZzxwAjSArNc2HvUL9aXCC6xU5pkTk5fcky8kRgjaXuXlyCeWfk2H/ldMs4BKz5j4Y451b6Cdih5Ys+CkTdd78LhOOJncTWccBAQFpsBgBTU9iqV92msoiIM9pmkYyYTLtaJX3iKN3ZVZ9tR6iCdbksgW6Q+4fBpRaqH0g5l1z09ecXtqipYOPQDXtGY/imJOaA1+FyIhkxKUhJ4F/HPMg2MbSEoW1o9+ZoETVVP9xgqws3RGkN1ysgFcQjii2+PRPTvHEmBxKjqWm+KttiCmNad1nn/er5BmztUKxX33+21ThtqtCHWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsCXOu1H1gpgHAJNhw5EyeGSmttLipCRYAvULV08cPw=;
 b=aXH9srQeRfgm2M5DPNVDPvD9ML2PyPhtPLloJnU5O/Soh7PzrmHx8+F7J7isfZ2UM6tQDX8J4/jc8z68ztF7IZBntxK8LHvi2jb/DgUtdMmnaQs7H45HG6spOZ94C6esNacg8lpbC4LnjJrhQDfaS7fb2ngvrCRAVPXeaeKuIHAOYnUEhzAza4jNX6EMt0iUAS8OuWqaQrGOtGyRjfp3n7poSUY1K3dMFEJpoZYCk0E7EqcnCvo7GS8KVWnuDjyR3pPjR6mvqunF7UWK3LEY5F+owE2vInmk2JudKqPMqmLIDlvpHmqcw/NKQD72OeXU29s7Edk5OGVVCPm2CpWpyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsCXOu1H1gpgHAJNhw5EyeGSmttLipCRYAvULV08cPw=;
 b=lQCRL+iXO4XGmyPfh8xCJQu8GlZ41ouZGxTZ7qvpBlnVEJ0/WINaByXwBbVuDhqZfVXrOZIatUf3alkTBiMZY2XiLfsPl/3D1M5BVvNRf+FwRhqCqSGv87dsNwbvGySSaqVWzEVug1mAvYIpQzxtVmIrvib316HJJ8BrHNK3jTw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CYXPR10MB7897.namprd10.prod.outlook.com (2603:10b6:930:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Thu, 14 Aug
 2025 10:49:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 10:49:18 +0000
Date: Thu, 14 Aug 2025 11:49:15 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Usama Arif <usamaarif642@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com,
        ziy@nvidia.com, laoar.shao@gmail.com, dev.jain@arm.com,
        baolin.wang@linux.alibaba.com, npache@redhat.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
        jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 7/7] selftests: prctl: introduce tests for disabling
 THPs except for madvise
Message-ID: <5dce29cc-3fad-416f-844d-d40c9a089a5f@lucifer.local>
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
 <20250813135642.1986480-8-usamaarif642@gmail.com>
 <13220ee2-d767-4133-9ef8-780fa165bbeb@lucifer.local>
 <bac33bcc-8a01-445d-bc42-29dabbdd1d3f@redhat.com>
 <5b341172-5082-4df4-8264-e38a01f7c7d7@lucifer.local>
 <0b7543dd-4621-432c-9185-874963e8a6af@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b7543dd-4621-432c-9185-874963e8a6af@redhat.com>
X-ClientProxiedBy: GVYP280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::28) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CYXPR10MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: decd7e19-93e0-41c2-32c7-08dddb203826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U3ouzqw9pxQsyYOM7cbXAM6wodbYf+fulL9oZPuZO9lS2mhgRnz4awK9BKiY?=
 =?us-ascii?Q?C2N3wFvqhiPZtlDokJt9BQMedKm4CN/ZNlO0wtFDcuVH4uV8t6R8fg+pRDpm?=
 =?us-ascii?Q?X58XoOqSZbAxz+GQ1zS0JvJa5W160oAGJ45gdFPDfX1HvFVew4qQ0MnTnDQ8?=
 =?us-ascii?Q?JhuboxrQ8X77eYPPy9aoF2x9yeLx1CCcfFQNtwwuF3+PME39oQk0HVtL5O80?=
 =?us-ascii?Q?oorJ4n0Mse1bNPVhVL2K715dg52uqKRKQdPH6+DeyTAFJGWHdsAl0f9TqhL0?=
 =?us-ascii?Q?L1RtVZ1mUh/mp0bI1Cu8Ak4/obV/QdqkEPywKS/1AQHuLVL0vjPeCTnoj7Ad?=
 =?us-ascii?Q?XJrbiTOAsZxxuyLhWi4RmDtlyffR7dWbUD6exm8t1h6Vg2RwT3CKlzZrh7X6?=
 =?us-ascii?Q?iVRlaaMXwlJ36BwxWTBPtp+tzdB9cyCfLsRhNVa5dKdaW0SOsazYz01YZ9Mx?=
 =?us-ascii?Q?qGWog/vF8dnGZNv2NXaSZMREhKSfHrD5t5+SeUHHx9geVpRrsnbIBTfJ4QvI?=
 =?us-ascii?Q?1mdV8uwvYVjK6kE1yHiC7la3+niJmcrj8x2fW0BfB55VcdvTXhPUi4pCdvL/?=
 =?us-ascii?Q?LlWEQjqeEAZtvGFXMChfN/v4QyNOq1s4ZTj4nZoXKotVrUvi+NDjOlIiz7PT?=
 =?us-ascii?Q?uyh7u9yxAtGQ/3D9rqEYJ9AG4N0qHtkO5orFJyYAcJ7T6yb1t9l9Ybm4l2ej?=
 =?us-ascii?Q?8YStP1cxxheWKngU5ZZ5QGt3KPW+3wcn7fWykcdyo5YKpyslqBa2nPEUsmEM?=
 =?us-ascii?Q?S2jcI5Fa/FA2iAmUiHEkW6C/YIEu8r6g4RTQqlb/wmKqsgnqJR7vw8HNyx30?=
 =?us-ascii?Q?bM9f+Q3WMA3aRTErPo1Ji9QyNVqCnf80qwvNyLzA7mGnzsRkku21LfzCW9va?=
 =?us-ascii?Q?n++sAnWC3B+xTqXR6OVLVgSaGHzhkIriuBy9rjMqkkhmLQJ36tLwbLUBkl4L?=
 =?us-ascii?Q?/3IJY/mM6e1Q7c/+vT5PgkSZ24j1oWKX/wU1UL4tPHZtfDJJFiJ5IUAcxe7t?=
 =?us-ascii?Q?lPXbuvV+eEIW4wimE3nBoKBZkCCQGVV4INclLYUd5l3BM3Kya5NyOZ+fRnZc?=
 =?us-ascii?Q?36UaZVBCljQzRXSDr+xjUnOtkxNWU5ygjF//8QBsuPpkf8Nb1FFTpnN6Gjci?=
 =?us-ascii?Q?wZzflwWpNz4kb72VbxhqH6vkK7FxGamF5mqcueuAOkyEJQZRfXjETa/QSz8A?=
 =?us-ascii?Q?RQVHz1BUgsi3JPxw8yW3aR5IPgQ0C8xmf5HnxctWIAR7IQnclJizm5nc+5Is?=
 =?us-ascii?Q?9cXbhY0yj75YjTXh/8mivX9aipUX7XZ1HDtKvsGHW1AYdo7eQmcYs5c61FVV?=
 =?us-ascii?Q?zqPUVHhpof+3Z2FISDKAa1H/HXZWNEIJK1TJDKO3Z5/XwFydbhU5q+VSiV6T?=
 =?us-ascii?Q?7wzMbhIDrtxW0jt5GYfiiManXSV0I6b/E63ZwrjqFGYsN1/YnfuWjM1FV5e4?=
 =?us-ascii?Q?yBzg0xWhfa4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4AacEY0SJ9x7FXs+k+IKW0TVu/keE/zzEtj+V2cbt90DvTTFiWLpuBZE8CgA?=
 =?us-ascii?Q?XgiKQ1StZ2aidYennaftsXxF/DgaNn97bf5xXb0Bi3VtKKwxH8wvVbCeTKgS?=
 =?us-ascii?Q?Bxo8q4FGMnRaytKqedwZrRywgenkkDUCRM6ecgXvFRh31FDcXftKGBm6+JQ5?=
 =?us-ascii?Q?ROk1dMWyLVqFKbSjjgIYyGEV0eSJWQMhSj2u5kBnkLchwwdfEMmBgUQIL0zL?=
 =?us-ascii?Q?1y9qs2SUeGIr2vaGnygVxje3/z7g7lmsil4TDY4iZ4LRBVtFkTCl/MF//FoS?=
 =?us-ascii?Q?wx+P64O36loElxvIRnFkcUKSuEB8PXstxzw2JphU7ffp8BN9B1JFob4OXpVe?=
 =?us-ascii?Q?oi9P1TwFx4ZRTITudj8Jef+SXVoPvz8BJfRiKlBpP8iAMtNeDz6D/hGDNvpi?=
 =?us-ascii?Q?JMeLTl7sBa5gSxqvmno2L6XcYxQUxancdJeWASPHNf5xu+1MrSImlV1Ritak?=
 =?us-ascii?Q?IZ++Vx4uj3SIV4kNNOHEvdu5LQTw7AHWFHPKWl8+UQshyi65z25Z2hbRenDv?=
 =?us-ascii?Q?oELkLa2HNO+1rjerSEEzIAPfVjZ9gD/7GzoaBxTTd24fgorXKzuBbOirrFpt?=
 =?us-ascii?Q?4xc380JN5lpbaZjLJCM8AJiWxRh48Ja0zFgmQ8EiJrUrWvoN0Q0zyrKY0rRT?=
 =?us-ascii?Q?Hm5krdpHut42Haf7AgJPB5yEVvcPlALIUwSj3J+fB+Eb/Kwi6IWzI7GR6Mtw?=
 =?us-ascii?Q?v+kfIBINMf254zMvgBLoNGPEEu+yk8oUo0dNsFU691bZH82oIG7Qj4hnzoSL?=
 =?us-ascii?Q?x84MovHcTZskZAiXS9V5cp/Ba2DmI8HBoBK0DY9mCbzHv2m5+FciWZdJtZXZ?=
 =?us-ascii?Q?2cZuj/LlF2uZbh0guZV0WgnexaB2kaQjMk5ZA7JgDEksFX06FaKTEhncooer?=
 =?us-ascii?Q?BbMQbJ9W4jJzm7EXjJlAXgMkjiJuaWuw0ilLuFEHQBXnevmUvFGRhcodXHcA?=
 =?us-ascii?Q?/epVh2k8TJksFTspozOnVfn7HfXQ4bbuLshEFswt8Bsm8NinYQ/19KnRV/UN?=
 =?us-ascii?Q?322ijQAlhCJLjzKe+xI4Q+khyJnrGNfh4A8+uditwv/J0wxbtQ7At529L9x0?=
 =?us-ascii?Q?OLadXorV3aNgq30z8I4cYd1wmKI9c41Tnti/vt8N/OfOuXV3ymBt4YHv4Gd0?=
 =?us-ascii?Q?db6/zK80jwO/r3TaJnNtCs+REqc6ty+fBQtwGRZjgkS9tsYDldy0ttwuc2re?=
 =?us-ascii?Q?r67+Jh62QxKrSSA6CnkHyglzWZYF+rX0DzZJoMWVevYVW6iIFLs9OVNCrTfF?=
 =?us-ascii?Q?qi8KorNXlvGamJ5fQJCguRP6Ve0pTSoLj3EzYRhJTaAO3THTcWpR5i1K5zW8?=
 =?us-ascii?Q?60A/NtUT7JYS9CT9c4uEw3BxLhgX5ORzQ4zV4G6sw6IJHQknulgDZUpVM0oB?=
 =?us-ascii?Q?toN2thfJtj/Ld1cjix1Ki+KtsYf5Q3QmOV8L/wWysoHlhPltXztjJsBql2uw?=
 =?us-ascii?Q?41m8ONoBS45k6f+NKLwnJFg+UyjnuILBIyces9pT2nmPPgTXZ8YZ3ni2BPyF?=
 =?us-ascii?Q?7NPF7PKGI7cSDBKERNmEXix0T+KIapvR/ZcU1qE2SGJSt40ZNc8YsuTRUB9q?=
 =?us-ascii?Q?LFigvdnkyGKopN4ETowW1CiJyyCbULCeXcPnFPYAqmD3yNuLgc2rrXGCK6th?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yg3ng9JM5Wjx4yRCfIiE1rmh1EocnDToZ7DjKWW4fqmWH7hGE1Hiy6RQevzESgVWu4sqamz11Od+uTg1Y9eX8uwJxQVPKWS/kKBgbm3zmZ/4ra/SqS5LiUlsV1rdGxDW437E6yA4j3FoGXMfWex6vUuvVYAJdBq6S5BzZ7aFa04MbbX0RFujuB6pqssJ3SvpO2wHzP4WV52SxdLNNtOha9X1GVrbeZpjDKfcDpuGhusiDVRzL59FWyPJM7A/iGEQ2ujXXc5c3jUUvGJfhamrqwRx7jG3+vi6KEkhD5O1JXIYhqhESIeKsJ5kma9L8PzIU3a7/xsST9pXJ31kstX5g0fge6qtwXhkg34ZnAK6Tox7bGgwnjzFQ0rlqjpqrhq67Sxrw2jykE4pgqU3Z0ka80j6+BQRb3AAmuU5gECGXQaDqiQcWceO9rZswavkbLiDmnFnamzS15t4HpaWmct7wCPnHHmqUiPuEKedKZFijcZbw5z/Ea+gr2n2EurnfEE9MY7S6+qY8qNk17LXt6tS4RoR9K1++qx1fLkSn3VkyKQZ7b7pZFm3V1oOb61CFbvXeQsoCxkSMvPtDtwqE0vlVcZQH2rQ9KVUBLKtDeO5kDM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decd7e19-93e0-41c2-32c7-08dddb203826
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 10:49:18.4658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iAUj2Hv4aNCEWGNxQ7r1Nqj0jDJ7UH9oFAvTewqpH8iJ5doNWx4To0WGiK3tTG5nD2G0Rz3hPWZtFzEtXKZuff/cBadwszKFO0vD7jvOjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508140089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDA4OSBTYWx0ZWRfX8clhgPd1Z+qx
 v8k8XWy0wbgl5c7/AJejQ/KLPQl0OladqUsC26eJA4ITavZG2UBuy3kLciCJFkkDIS/6jy0E14e
 thqnue7XeHMqoiu6fR3v00YZMSykviDgO1EpgEnIdESS7Db75q/cX/8iNT0Mz9xKg4Qzoio8htA
 sb3lV3lg6msdAGVO2iSbtrKq6OsgH7QLK/Y64PXhi6Vqu5jys9F1lsGQtQd1CCwi6XsJIP0+IpU
 +OEHK+wS1lME2vIV1GG5G5MrWJnGkuUy2qfPwi4c4uGPO6Z+krRHQuJdq9v2MZd0xezoB8X99NL
 FajTw1OcjkjAfBxNDp9xk7yHxgNShaaKysxuOu7NpvZrjXx1Hq17eKt1UdHzg5FxGroixQsyYoC
 37Wp2dxPv8dtjT24dg5dDwZeU2FVkjJSd2UgU5RKXZQOHwqGrgtfTkxCjektPGUfhl5ReK7V
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689dbf33 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=ONfq4mT72jvr_LTCM38A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: oHnlGKW9_FaVBvJ194iFwbxhRgp9WsZ_
X-Proofpoint-ORIG-GUID: oHnlGKW9_FaVBvJ194iFwbxhRgp9WsZ_

+cc Mark who might have insights here

On Thu, Aug 14, 2025 at 11:32:55AM +0200, David Hildenbrand wrote:
> On 13.08.25 20:52, Lorenzo Stoakes wrote:
> > On Wed, Aug 13, 2025 at 06:24:11PM +0200, David Hildenbrand wrote:
> > > > > +
> > > > > +FIXTURE_SETUP(prctl_thp_disable_except_madvise)
> > > > > +{
> > > > > +	if (!thp_available())
> > > > > +		SKIP(return, "Transparent Hugepages not available\n");
> > > > > +
> > > > > +	self->pmdsize = read_pmd_pagesize();
> > > > > +	if (!self->pmdsize)
> > > > > +		SKIP(return, "Unable to read PMD size\n");
> > > > > +
> > > > > +	if (prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL))
> > > > > +		SKIP(return, "Unable to set PR_THP_DISABLE_EXCEPT_ADVISED\n");
> > > >
> > > > This should be a test fail I think, as the only ways this could fail are
> > > > invalid flags, or failure to obtain an mmap write lock.
> > >
> > > Running a kernel that does not support it?
> >
> > I can't see anything in the kernel to #ifdef it out so I suppose you mean
> > running these tests on an older kernel?
>
> Yes.
>
> >
> > But this is an unsupported way of running self-tests, they are tied to the
> > kernel version in which they reside, and test that specific version.
> >
> > Unless I'm missing something here?
>
> I remember we allow for a bit of flexibility when it is simple to handle.
>
> Is that documented somewhere?

Not sure if it's documented, but it'd make testing extremely egregious if
you had to consider all of the possible kernels and interactions and etc.

I think it's 'if it happens to work then fine' but otherwise it is expected
that the tests match the kernel.

It's also very neat that with a revision you get a set of (hopefully)
working tests for that revision :)

>
> >
> > >
> > > We could check the errno to distinguish I guess.
> >
> > Which one? manpage says -EINVAL, but can also be due to incorrect invocation,
> > which would mean a typo could mean tests pass but your tests do nothing :)
>
> Right, no ENOSYS in that case to distinguish :(

Yup sadly

>
> --
> Cheers
>
> David / dhildenb
>

