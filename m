Return-Path: <linux-fsdevel+bounces-62245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14397B8A79C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 18:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA853AD650
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 16:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8B831E0ED;
	Fri, 19 Sep 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lUZFgd/5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LoC2Ka54"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C81320CCD;
	Fri, 19 Sep 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297577; cv=fail; b=SklKWO2kKU0Y/1LM6JYlOsSLsBR1GaPEJGWhDFmsuVpd+w4uWcKnoUo3k4QgRsp23ah/aPv0j6FoaVAdADJwpIoRTHzxX1hfhbZ8eRs5KyKdr2pOfmUvfq+TURvPmhlloYzK2/ziBHO29G8wiWd663YcdJVGEP6nwLdOI4DW+yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297577; c=relaxed/simple;
	bh=3KdlgQRpoT1C2XNnhxsTmH/9umImsKvLQ68MFNXSKoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GydFVoeW8ckDwwmQzYMncUlx6EjV/SDaJQTVqqkKu/wAx8twQ7UjX8yFIL3jNHaN+PF6QgkhU07L50I5pg7BmCQDG+xewfKiPcccqtl0UNvB9zKnxBheBP+rs0yPw9ypfh9/TtwloAkCqVGpTyGalEjJAj5zhSe82wFmrxbvv7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lUZFgd/5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LoC2Ka54; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDu15h015975;
	Fri, 19 Sep 2025 15:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3KdlgQRpoT1C2XNnhxsTmH/9umImsKvLQ68MFNXSKoQ=; b=
	lUZFgd/5lZtfhWkqfDyzqJM7bi7RJRkyYv4Ro4HRDIwxDDgOl476eASw8JMv5bjY
	IP8JilI3kzD0T7aXHeUiCLRdn+GfxvsJ/XIWiuTr30eJB9pMSgEHoUit2At+FGws
	i9wDRz2jZnz8wrdBBeIOzIFsQ/HS5D/85LZBXMa+kVoiVgy3EiGZ+5h3zWBkeVu2
	avwVCj0eapezpDzGYDtYdmcmF32uppxikMdYgbh3/9H2yNjlDTRd/sZXjYi9IgEz
	kVnTg5FhgPxaJ9zEgCdaIhue3uyAOoMZNDf07a8arMYxcPe/lxDahThwLwe7Jy3z
	k3Bt679phnF+FXJmQNAsBQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx95tpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 15:58:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58JETVvu001511;
	Fri, 19 Sep 2025 15:58:47 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012069.outbound.protection.outlook.com [40.93.195.69])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2gua16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 15:58:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4Q1uq0KqLSasVOIodOO5GJ7zpdnebS+QVBbefBHaiP0g+eIFtpCY47wGSnqdMrub3d2QRbydzNzvJ3r0qvBKAHqifROKVdzyN4X04meNc1nQFVxx+8IM/0BdArz71h7nQXa6q5rPoeIp50/yC5tPZMTxWQJ/Lok+QPQqgW2hgP3i0GuDCkru/FYJZmwlLu8eSK5TDo4rZIxuiIT8GZfx4/G4+nMVe1ekSuESGj0wbAzkPeWop7ID71YtBje9CaarvHGGZG6U54WkkxIrimaRz+EtvPDufMwO1dz2XvcRw2hj24NMfKNIs8pF1PyP7kWytUtSjxLgAssxiRcu50/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KdlgQRpoT1C2XNnhxsTmH/9umImsKvLQ68MFNXSKoQ=;
 b=pbcIfsX+RAaPsbfqESR8Qrd0fM9/16kjs7g2SA0OP+VMvE0AAX6xyLVHRD5WsmZp7AWV6pVJYRADxwEEyKFM/8DXTpL/wk7FI0vZdxPpw4E7yL4zFr8tyPq+dpvc85AGtu805GgWolXx6/5cEbqlwAWwZ3Q91B2JW1Ig0W51DxATu0/fjBfwYi6T4F5ghh0o46LaYjhtqOAOrWooBFocb4wZfJqIcwWJEjVX/KPQKRtRDn4DWohMGecadf8K+/ivm6/Zn+AGvWY7QuniHEXlNScGtwu9IHo9VJmnZmNPu4zJhUxCsE3RvX4mZYxLP/SoBF3QiIGU9+zcxe+wlusP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KdlgQRpoT1C2XNnhxsTmH/9umImsKvLQ68MFNXSKoQ=;
 b=LoC2Ka54BsimxifNWW/8qhn7bYizu9gxgJYykPqP3pcXZmmM+ctu7gq2KyKMxBUZP+E2ew+hFBwP7x9jq5rNgWzIqwWkYwUA0pvATBBv1dSSUV6SBnoOUMwfIhyqHZS84tlRj9Ai4SF6M4y2Wxs28XZRct1aOVrkSanMiuxhn1o=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS7PR10MB5088.namprd10.prod.outlook.com (2603:10b6:5:3a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 15:58:41 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 15:58:40 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: jiaqiyan@google.com, jgg@nvidia.com
Cc: akpm@linux-foundation.org, ankita@nvidia.com, dave.hansen@linux.intel.com,
        david@redhat.com, duenwen@google.com, jane.chu@oracle.com,
        jthoughton@google.com, linmiaohe@huawei.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, muchun.song@linux.dev, nao.horiguchi@gmail.com,
        osalvador@suse.de, peterx@redhat.com, rientjes@google.com,
        sidhartha.kumar@oracle.com, tony.luck@intel.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, harry.yoo@oracle.com
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
Date: Fri, 19 Sep 2025 15:58:32 +0000
Message-ID: <20250919155832.1084091-1-william.roche@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250118231549.1652825-1-jiaqiyan@google.com>
References: <20250118231549.1652825-1-jiaqiyan@google.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS7PR10MB5088:EE_
X-MS-Office365-Filtering-Correlation-Id: ff012241-c907-42ea-55b1-08ddf79566cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nn1fMF+IVInXDZ9jGN5+PbnMHEawI86QR1sxVeEnkkvpecKNLj/RkaYJidqt?=
 =?us-ascii?Q?Ji5woJOCVTkc08Pd0uGm38vlF3IQ1/51ukZ+84Z0qW+aiarpIa3Zb3PS44Al?=
 =?us-ascii?Q?0PTSNmXPJnri7Lw2pvmw2NsTw8HlbeVECiJ6mnYA7AElK+S6Z9ffVro4aRfn?=
 =?us-ascii?Q?6fdn9+kLvvCN0Xz3goEytmb06j7yh1zNoi+s3LBwig9DNqWO1nAwUyWVNzc6?=
 =?us-ascii?Q?FN2K3T+W86yaSqgL+8hp/oeRb8WdV/QPNfrgsMFoXQIcPaIXaezOKJCV7Zhy?=
 =?us-ascii?Q?2kNjfVc6xLh+ai+v7a1CUQAN+z9plPkpDBAqNlg+/SkXXD9c2iDGdLpuM4kI?=
 =?us-ascii?Q?IdgL8CEfIBfMqEH4EObcR6AcQamQUU/gD+vWpm6LDdf0q+XwpvrV+1jTok1b?=
 =?us-ascii?Q?h2jDLpkvxjzwErDQlMwOWS8sGTQ20U2Bq/An0hrycO3jqV927jlLYw+1QqXd?=
 =?us-ascii?Q?1ijG4QyByUlY4RTEUjs/3HYAW58fgzYZ/4horM/geNH/5anVrgvRTtBognWw?=
 =?us-ascii?Q?VzjV4nkD4bJwCoHhCZIMD9ZNPg6bbwC9HlXfDxbipnhbf91QDf5WO7lCZoSL?=
 =?us-ascii?Q?rzawIq0N6uHoR9ZOuG9K69ZxCux0i7W1dDe4DB4jgHXzai7tVjWZ+ixlhbKl?=
 =?us-ascii?Q?Yp9smJGoDdDjS3oG5B9N2nANNMqN9RqnPRiTxLMPBRoQZllOlAa/yO5RNvth?=
 =?us-ascii?Q?eJ8ue+l4D5cf9xYkfDp8/Hq4PhXXvXDdjcbNdqxhaxPOvizYx0+Mjxiyl/Tm?=
 =?us-ascii?Q?50I1DleEjhdwB9SCCUC3YG1aM03gAuxRB5hA38MUFuRUzPT0HmM4Rf7H/buV?=
 =?us-ascii?Q?X4J7LRv1NAJ775c/yZCI4UBu1MDwqrwQxGf4AzQNOTAm5yz0cQSzRXnsAPYf?=
 =?us-ascii?Q?x2m3SSFbW0W3asMkoEjJvn203j2S8JlQFGbQxSroJljdgCjsHtjsq66RBTO8?=
 =?us-ascii?Q?Do3Ez44MdRO4DCUdifM52rMpiBfm4g2VyDp4pW5J9PwL1W7KcHe7XE21i1+8?=
 =?us-ascii?Q?Cgcp9DFhww/hhvlT9idvBfU+d8cH7jUQ8W6oZiTAFSqkHT1YAGQZF5BhkuhX?=
 =?us-ascii?Q?vfjsHb2irORpUcmpDwUZRFFEEayJ/XiALTlZhheqFR3+CLy8LJthc8CtYmY0?=
 =?us-ascii?Q?cIsLEdQqS8L3eR2bta9BQdeEuWDDowPm6f/YJNr2lcupfIkEZE6O0kTuQtWe?=
 =?us-ascii?Q?gumVrWtn5w8S2Kv7Z3Bisnbe2DDqDBSPXnoYDl8gzW5mBBd4FJENyeP3rJ1M?=
 =?us-ascii?Q?6k5oUOo4Klj+Hpy5kEYmJkGzw6hcrR62/mGw6pEwwEeIvHYiRj+SK9Hak7j6?=
 =?us-ascii?Q?35JM7A3EFPw7lcChsMysHuZTeJObFcNMFAR0i2bos71WNdv99L7Kgxen6EZK?=
 =?us-ascii?Q?l+kXuIo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zcUsnrLNlBKPQYCB+/zJ9Qmmn6qSeOx+jFHzuXx/6KzMojozZmEWUT/SmbTI?=
 =?us-ascii?Q?3I03CLv+fRd7c6YzVyLf8YvxrEFzwpo3fNyhvWHERKM7HGtLOoIuvAFytm8N?=
 =?us-ascii?Q?OYwsfdIUqpIekPYz/uTigkDkRt1cxhINid3paHBZcH427Oyq4KRPVdtKkXrw?=
 =?us-ascii?Q?vnrCyR59O0FpgD/kn0sN1QEDTaqxRD5GozTC9LTPBRkXgVO4WRo7uVH8Y+oQ?=
 =?us-ascii?Q?doEY35jWbNatff8lfPc5PcTxW9acYsgi+4VZjfLQPHF/YCi6pKxbQ1lyVlr/?=
 =?us-ascii?Q?As5ACsq/gOqTt1wwooVP01q+2WGH//mKFHAIFWg91tOwiGDxsSGWNpqbCqMt?=
 =?us-ascii?Q?zzF9zbztJivv+s3KnGQwcR2BiXgOEGw/W2n7yYV/l3T1thR2TMWaulCJQ2z+?=
 =?us-ascii?Q?F0azFabu/Mt4boBOKxq9yjh3s4neAkmcBKCfxd0AE6lcE7B48UDsxWj89mlL?=
 =?us-ascii?Q?kjLdX5Xp/FCzE2NkzP9MFoUkgFWAFWxN6nsi8Oj/q5k+Z5Deou9VuNJ3meDy?=
 =?us-ascii?Q?x8hgFtvM4HNJXe13dBquuZidfujg9tmP81GHOtziU0/bLRoBqrY2yT/g8A/o?=
 =?us-ascii?Q?qhQsTHqXvp8xPywsfZqdWTd760404n4qiSAGEdGFo9pxSRC064qivEGZiuWd?=
 =?us-ascii?Q?zqTX7EdHs3cLGyAqoLw2IaTK/vX9LtqPRx9NZOGw1za9K35j8Pxor0drNeEk?=
 =?us-ascii?Q?MASB6C+VJ6/HD7fiDYUyLOdEzhcd4nlNFcd2b4Xy/aGesjXYYh36pyK6FYAE?=
 =?us-ascii?Q?NriDjFIbnp/ibv32qKbsfEhwX+jlEZDG3kRs+adWMIwZbnxBOEjuhMH0twIA?=
 =?us-ascii?Q?Gdf470BzRGPbDsv1L0YO77jk4E4HnR8qOqshvoWohpmpQGqNU9io67jBASuE?=
 =?us-ascii?Q?v/od2CbTdYuAknslvwjZmJAVzDgPck1T9+fzim5Wkyse4rSjzCnP7zMPEBrP?=
 =?us-ascii?Q?0qBqtXpNfjcpZZxLATxgZKpIggaDnUlBvcNv8+RNMUL7lngzIXBTv0V0fgkp?=
 =?us-ascii?Q?StCALQy4axbLDEoMeU5GkvyQHmdtjpwOvcDX3GDsgoHE4LT7b3f7nPoZe1q4?=
 =?us-ascii?Q?RVrynLLFY/lf1n9DcpjtlUzMFv3QLRJ4vpENQtLISE9rKdfqMx/gyEIopng4?=
 =?us-ascii?Q?WToGFPAb/hxX02fT8EyQlvauWbUvGYBYQzIlM2/2TH91Yb3bAmk+WUtN7Bvz?=
 =?us-ascii?Q?E2u3IJ8nbS2y39OXc5mGxumTAP6J0/7HKMsSYS6mudqykfGkNsC5m9ocHw1z?=
 =?us-ascii?Q?RcbjsfGFTe3qkyrllyuCEjRXK+nCNkVxru32UQwKVjcPsx4dRQ1sWK+AbepN?=
 =?us-ascii?Q?t789ALWLoeeaVHKE9LLk6LxjbK5BFTFF4M5xVEZn5JeaPvU84zZ3S6s6fZCu?=
 =?us-ascii?Q?GXPTyvfsPsCCRAqz5IKrUtEFR+cvgnES3jnbhlxer+FXAs8V+PcOw/F9qSpL?=
 =?us-ascii?Q?3Q4WHx4sneSNMaUgkjRghiF1d8G1eWd8CAabh7alSwCTwSZDLThZXIBPROis?=
 =?us-ascii?Q?IZOkbLwqfycCB4KPtF8BFk/s2oSMNQxngad3m330hVpVPdV0oyvCAa1J68Li?=
 =?us-ascii?Q?0rEfJZaC1atVmxcR+nsnw20fZPkGP481JUjYolMLG2u1Wqn8eKLo//a56wVA?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kY/0HAlYvNX6rrOmW7rTHc0Bgs2eyXZveg9q8YC6Fvl/ihWVNzGwzmitlboIAJMpZ0T7CpOLp+szTnxlQ+hZaqh5o+KSiuvNFr9Fimw3PxZQFISnZfGN9BHc/co+sDNbyC6wkZley6tFRSeEaHfvPV6Tg/+mjveTY733avGBOPSptGPsbIQxWWCj/NGfWGUKO+uqTZLiYomwXJBmqTKIcIPPjh8FeMiGWuyKImDOf/Q+mgccCkNwtRht3RRinDtxmn1V0qEUIXjl6EVc6JmvtLH7G1rOoI+HKRdatWRwrD/xlUpgntg4q1GnUb2ugqDrXwEozLcvhpjRcUt1u26YWOIWUALQjls9MX4FvplbIkg35sKWC2DeuDImZR5p+8DgxA7jCD8SlaGJJChJwSSYPA38l9Opuyi6Wi25VhVQHx1H2q82cnGLwn4XCphbStuHiOV6/CRK8vHJb1qI0Xn+0cJYED6WYRQ4pf3sH2xeuq9BGAWAj+xqabrfPWGP9ZVzJ5KbAFFua7nTGTnDk8F4nPnl5r555Xb70kQjl/ujddiSCMSrs0H6jhhpR35F2EGwqZdAqRBhveqxSa5mdp2PUAMYt46djLskzUlR+td9DWI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff012241-c907-42ea-55b1-08ddf79566cd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 15:58:40.7617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atc6alQ1sXv58/6lKnHYK7NYbxUY52DnfDjBYr7YmT6s/mPJWQ+XCfQ1Owz2Tg2b0qd3J1IpVX/hM49WBfYu7PPF00NNE1LLC1Tw9O4XUfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509190150
X-Proofpoint-ORIG-GUID: jbNNuWxFUAvXYC9rgl84pjaYpWZtoAKW
X-Proofpoint-GUID: jbNNuWxFUAvXYC9rgl84pjaYpWZtoAKW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX18r9wVV8E+L8
 42eNKRM8CJ7NgQ27sHEeYI1eaKaC8/G0akTsiEFVv+AqIrgaoSS9CHhgEYS9LhDIObBoJ3h5py9
 fOJAQjCL2cm+JzMaa6DDoWnfa9hP5BG6Qxz5He1RV5avY06exq1taPx/LnrpttgFIVVLqNpywK5
 is+rukFyZA9Sv5jJho/kQWPc2QHIdFRXoxgTSfEfgbJBvOFr50WA53donJIFkjz8+ooL8Fb67em
 hAx4ZEdtQ1qnWKQyzxPvYBrBdRCdcfxcRb8pUe5f63XNmt3LdOzg6Ep8IoYfTx4F4AjSMxYNX/s
 iJ+qMfOkAgbED743DHAvZoDtyZ4bvRUCR8h37AHISCBmk2DhTajEjdhcgQp+yRfANn/2cFgJzra
 WfQ++lU/
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cd7db9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=M51BFTxLslgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Id1uti8x5LAU3UlyTX0A:9

From: William Roche <william.roche@oracle.com>

Hello,

The possibility to keep a VM using large hugetlbfs pages running after a memory
error is very important, and the possibility described here could be a good
candidate to address this issue.

So I would like to provide my feedback after testing this code with the
introduction of persistent errors in the address space: My tests used a VM
running a kernel able to provide MFD_MF_KEEP_UE_MAPPED memfd segments to the
test program provided with this project. But instead of injecting the errors
with madvise calls from this program, I get the guest physical address of a
location and inject the error from the hypervisor into the VM, so that any
subsequent access to the location is prevented directly from the hypervisor
level.

Using this framework, I realized that the code provided here has a problem:
When the error impacts a large folio, the release of this folio doesn't isolate
the sub-page(s) actually impacted by the poison. __rmqueue_pcplist() can return
a known poisoned page to get_page_from_freelist().

This revealed some mm limitations, as I would have expected that the
check_new_pages() mechanism used by the __rmqueue functions would filter these
pages out, but I noticed that this has been disabled by default in 2023 with:
[PATCH] mm, page_alloc: reduce page alloc/free sanity checks
https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz


This problem seems to be avoided if we call take_page_off_buddy(page) in the
filemap_offline_hwpoison_folio_hugetlb() function without testing if
PageBuddy(page) is true first.
But according to me it leaves a (small) race condition where a new page
allocation could get a poisoned sub-page between the dissolve phase and the
attempt to remove it from the buddy allocator.

I do have the impression that a correct behavior (isolating an impacted
sub-page and remapping the valid memory content) using large pages is
currently only achieved with Transparent Huge Pages.
If performance requires using Hugetlb pages, than maybe we could accept to
loose a huge page after a memory impacted MFD_MF_KEEP_UE_MAPPED memfd segment
is released ? If it can easily avoid some other corruption.

I'm very interested in finding an appropriate way to deal with memory errors on
hugetlbfs pages, and willing to help to build a valid solution. This project
showed a real possibility to do so, even in cases where pinned memory is used -
with VFIO for example.

I would really be interested in knowing your feedback about this project, and
if another solution is considered more adapted to deal with errors on hugetlbfs
pages, please let us know.

Thanks in advance for your answers.
William.

