Return-Path: <linux-fsdevel+bounces-48209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FB6AABF86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38443A61AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E63266B65;
	Tue,  6 May 2025 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g8fHyXI3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sXvRXulL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5DD1E1DE2;
	Tue,  6 May 2025 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523893; cv=fail; b=RclY3JsIVK2SexreD253e2dZ9LMTg1Ssc0uolC8KymAYxY0Z4OHiS9VDs6uTtwzf0WhfY6+hOiMFOuC92xNG4wMMcNNy/GSAYQLWlRU1ZlXz0kSDG5mPLugzHID7QRS9ZVKfrF5RfqPjbrCnTU0AHet+wlKgjt6cJCNxUW3XR2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523893; c=relaxed/simple;
	bh=DMyvfx/HHEQTIj+cWuNuB0/VGKamCIS6jb4Vr0qjwbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qWgEVZ0WiAHgDTIrQTWhVrA4mEtTEPMST/+AjSMiZCjRXPSTIW4ZFCcPKBst6XGlLZ0oH6FP6pkwrNBzFN5N/BJdLSa+SZw/IevffpyeDugRllTF8JnScuFcdZuD8lNnNeH0YXecbKyMTLNfLhw73aPLC526irQiUI2kc4QEVwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g8fHyXI3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sXvRXulL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5468bibX027384;
	Tue, 6 May 2025 09:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=DMyvfx/HHEQTIj+cWu
	NuB0/VGKamCIS6jb4Vr0qjwbg=; b=g8fHyXI3HYG/7DdBWp3jYUBt1dQ7eSv0Nt
	BiCSYXI3ZDR5Ko5wrVUIhR3GmliSxmF9QKBR4ldXvvqCFH46iy44toEL53/YR3YW
	mtZTxde7iAxppM4BoET6gjPxZBEshDX5tZSQgtiF7xYZwNnCiY2an9c/pudriXaK
	gR4XyJokqvvCubhjGCfqtDZFmR6OVwbDhoe30GX1mPeij0MevHBNlaq72WG2TTpw
	rwjwZv411kSdy+kG+mq13CsZnF7esshMgP24I8U4kd5C9fBn4vrmnHiVXOAQ9+mA
	woRdxiuXJk18XquXxJdPpHSNbWObSJ57hsH3WKcekVFeOMYLXIHA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ff2t045d-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:31:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5468xT67035580;
	Tue, 6 May 2025 09:28:09 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010019.outbound.protection.outlook.com [40.93.12.19])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kf0u4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:28:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDl8jWaSbmrOEbcmMk8R2/LTPiShCQCzczny+YX9VO3NYzLk3TjKbVQp+QLL2LBVLBX7im2VSu1+p6hdgyS+R3L7K3+Amnve+kc17K9H0610n3zuglSWmtG3aOalxHSFA4SxrJ/V7lUBC7fBei28svY6H3wYc4NNfvK5d2VogG8KnwOVjGYMsshtAFbHAHlsjbcTO0dEehaTOz4epo+452ZB8jQ36HfulV8yZ72sJfDsz70mvoakf5M9Nh27JMorsnnFF7x+F4UcawnGCnUrNf8xy/90S5fg0RXTqH4mY/5DTGhWdCHWmIQBgUhwTiILdRERsh7oP5EKe2KLBwtCiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMyvfx/HHEQTIj+cWuNuB0/VGKamCIS6jb4Vr0qjwbg=;
 b=pnWnIS5XC8/KKL3umNIqzMCVzlRh6MYIwmCa2smTiPDevXnM1zircXBmyXyJz+iL/MLo3RNqdGYCeIoH52qI04qu9SD5QVy8nH5cz9/I/4XYzCh5xsmFRBBKH5iIl7ssC5vnmsjU1rGCPLKEtzD61GmstfOBvw+jWT9fbqM4pTeTvyNIitrFJiF/CDYqjummlnPqRZVSrWr3fYwb9yMFKQNg8yv74ogh+CD1t0VG00ywPqV92rJavNj9a45c2nCW2j9fFtrVtp+hJGKyXGfz7HNtiRSYK3ziM34g5G9RZK008Xg2dUu6fCM9TB2L1v5+ibqQwUNu7Am2q5Fw2jL6sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMyvfx/HHEQTIj+cWuNuB0/VGKamCIS6jb4Vr0qjwbg=;
 b=sXvRXulLe/9VvfkV1wNDu8hvgehZIUb6N7nf/R08EHFKQUimltsxO1vQqEUffaBPZ5X7tbcMrsRbTLuCDIfzyIA3pQyJ6zJ6Sj1eJ1qEiylHDG9p8OmjR3qaENhr6x2Bz2magLW9ePkbB6iv1DFqKzJeqQsI/Qq6nsjs76njVMQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF5F5663669.namprd10.prod.outlook.com (2603:10b6:f:fc00::c2b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 09:28:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:28:03 +0000
Date: Tue, 6 May 2025 10:28:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, John Hubbard <jhubbard@nvidia.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        seanjc@google.com
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
Message-ID: <3000d8ee-7660-4097-aa8b-2c254c82c4ce@lucifer.local>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <5b0b8e1e-6f50-4e18-bf46-39b00376c26e@nvidia.com>
 <20250501114235.GP4198@noisy.programming.kicks-ass.net>
 <20250501124646.GC4356@noisy.programming.kicks-ass.net>
 <20250505-postablage-drinnen-ddaa539abc18@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505-postablage-drinnen-ddaa539abc18@brauner>
X-ClientProxiedBy: LO4P123CA0090.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF5F5663669:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c1872f-1e7f-4820-d561-08dd8c804d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8s56hP0CBV9L1S5l+3Cfg1onk9RfUIFFgs+9Sxrj2On/SpIB6JFcZvYfEHWv?=
 =?us-ascii?Q?OhwQ9gE02zxxYNYaLJEltDgzfrY3ctULz3ZV8Wf3TUtycbnTtZNK6fotjhbS?=
 =?us-ascii?Q?5QsHbcwG9YTxvcCIF0InGO1xGoyvTxLK7VDejlCsiiBvrk3AfTbXE+0hTwIP?=
 =?us-ascii?Q?pFkEXFOj4ptPxZEf+qORsv29zf5FvN+d1w6OVDmVjgIu/6BPdHevvT47hxhe?=
 =?us-ascii?Q?RdiMsMfRjrMEb8W56Pcit4wYwm3Q91ngnuwr8fdfSOQRtXGhndWaL3xY61qL?=
 =?us-ascii?Q?MoPa7oeurFqskK/tVbPu+fb/47NUAed7RVMXV2wKLLCEpe+2vpL/PLrtLRf2?=
 =?us-ascii?Q?JO2RPtQRmPiZWbwp3UstgyS1nACvk/0rSzIGgmyB9ddVDZXM5iidHSYuIrNP?=
 =?us-ascii?Q?dkgV++TjBOGxVrR5Hgg/TlWlwPZwcJQMNvSXVM2FAHFXc+rwGCFbrxoNkKSA?=
 =?us-ascii?Q?osrWxLhzVxwk7hR+ThTW6ZLBxF9zWqGKM+2TR2Eq87BuxxSHH9cnojeqIqOm?=
 =?us-ascii?Q?vn7YTv1TwQ1v/R+JXEOwD8F4ihOP2k7kR6S3JeWlVz00hqDcsf2Wvhu45ztO?=
 =?us-ascii?Q?0nec05S/4uX7ousrHNrQ0S9+tHXPZNBlnLBAoUtHnjK5nG74/JkIa3M9VSry?=
 =?us-ascii?Q?U+gHvY1SaXoTeXVehIulAE44r1SbxO/khsqtIbKePg5ZS9fZ3ONTFKKX7U1r?=
 =?us-ascii?Q?NpAh9hlV5MB4qgvhBhl6Ft8N2rFGR4crE1Xoz+8KtGbbacFjEWi8HGtF2LKt?=
 =?us-ascii?Q?nrzhYK22esQK30QwiT/TLBY7PGpxWLHoa0QfwXKWVv5/+crmolsBOj/sFEsX?=
 =?us-ascii?Q?ez+KjNoHpD3yprCYjgYcKatqfqvNxR4y5DowzXes2+Q6rHBx4o8S7PPqb7IN?=
 =?us-ascii?Q?VpCmigQxO5yuHA+3tPVzP0H8P+9iy+eo3jxM5bERAOdo4hMz2Nn8MixuOB+9?=
 =?us-ascii?Q?RsapK0BhZoXCTYwpTaU4IqjSrgX01y05cEMNZBqQEt8xxmm3I5CziyLw7wwd?=
 =?us-ascii?Q?b7XYioFG9wefNKmvLiI4erRcJG4b2cM16503ulp9miTqNCdm98UtqMKVeSdx?=
 =?us-ascii?Q?iO69DNyQFWqXBSjvGAcvD6cY03V6+prwRXo1ZrF0VXFXf0pVCHReBAz2fv/L?=
 =?us-ascii?Q?0eRgqqgW7cQ9q7e2DzdNCs6fP066gPObKLKO10n6hnbUPDK1+B+b9ddogiLx?=
 =?us-ascii?Q?f7If/f8p62Ti57WlnGDcezJ8ZIGvZtcyp4lc2HZwVnQAE4cQc+u7h5hQLLKe?=
 =?us-ascii?Q?s6+xfAq4DI4LDbGgc4SyeQpvSN0UFopGKUaQIa31ymtAjNQkYHWIC8U2Kso+?=
 =?us-ascii?Q?4QO2ZDybktz0TU3mCbyVpBk8qq/Qh7nWZFeGwMidaSdIYNRT3pF8prEXmY92?=
 =?us-ascii?Q?V55oshAtNhA+V2y0+8ny4OEt9q9ZT4Nd03osvSL4YazUra8EJP/PJqOKO1wD?=
 =?us-ascii?Q?OwyjJNYUyvU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y53LcxGp+e47BI/Urm0WRea+/X4kBDT1RKOOmpjQm0j8/cBn4R8tIuP1pB13?=
 =?us-ascii?Q?L+r+ZyxLZodgXR4qH4ZWNbY/KtXmqVn8G5LG9WbPO9fWeq6CJpLcw1rHlHLo?=
 =?us-ascii?Q?V0uTHSzGZsueWpQdur19flpuT93xWkNVg3WdfQWB1NlKY6MsPwvFASszlcki?=
 =?us-ascii?Q?dXNA0tMh8dIcBJqteuEdzTcD2jRBSgW9ep57HK9AiV5rcCiNVLnqgOmfnRNi?=
 =?us-ascii?Q?ly9WihowD3UHbbDOn7M2LNvDg+3/N25sdXCAllrX1YC0xqYeHyP1tJqZjjs0?=
 =?us-ascii?Q?NQzBeLYyv/IqxMlr1Xiu2lSsep/QJCwGUzfEbKjrGD301WSF1LBBWzGl0T/I?=
 =?us-ascii?Q?DRR4lSIZOFHcxTqWgPzboIMDyllTO2ONKCSjzAIZuB5/JYaTalFj+4nPM0TD?=
 =?us-ascii?Q?GIwsWGuBSylwvBiUUrZN+9wvxACAh6EWtijjvljvdLibeeXHv+5al/txU8Ag?=
 =?us-ascii?Q?wbdZtDD8hgJFZs9/arHBNgEAtxfOzWkDc80//0cQ9uH5DA0V9bzjRgbkgsT1?=
 =?us-ascii?Q?uy1+YHqBAP/zW7xWRVYYDiZ6S7nKhaxl5LFLE+IF3thCRqNr3rsKqTopfi5N?=
 =?us-ascii?Q?nm5MUJ8+wkfrKThLdw6wcLhOKPUY7f7SF/9z4dMXoyyQn/AnR1CazlMJrNmL?=
 =?us-ascii?Q?YNC9LbI5taNrBsX+6RaVTdDIKsBL8QLLOOF+isDJZV5pdsIoUO6H69YgZAXa?=
 =?us-ascii?Q?BFiegxbi1lDKao/X3h0ywXpKmqRngNVcNpia2l9GeLgNCDBL8Rxw3WS/QEK+?=
 =?us-ascii?Q?idT2qohvzNnMCtwM3CMf1AoxtuOrBaUetmwGKAbgru4z7tkLVbZUMUYNxaoW?=
 =?us-ascii?Q?amnzEwLNhm0dLB+ypLGO29Mu1HCm2zWfJoN7ZKyKqAW/yxR4J/p5jE2HfHrt?=
 =?us-ascii?Q?SblC4sKjYHDkhJpRXtFCdHNFaYbCfIZXWj5ZMy+3SKWd2SKey9sIRvIxMrk8?=
 =?us-ascii?Q?sxNehyTFZHeWYw+r7lAViO1c0hEJbmm6CD3l1tQWh4bYzaWWpFlGTLrh4K67?=
 =?us-ascii?Q?+UlOdIRoHoJGsma/EdEpkD6gPX5ss3Io7hZ1IbYaC84cCqhRv7InPKFyu37V?=
 =?us-ascii?Q?j33WV3HUAnWbzpsh1AuVc8EzvGPjSY0Bg3k3uU8sdtW7MDUbZ3BTogKOt5so?=
 =?us-ascii?Q?ihRoDejonBdNY/MOcfgk/RwUxoa6jg0/YLJlHzaN8ZFe+TZ5RTSKuJpgD4Hk?=
 =?us-ascii?Q?IbtMGyapklui/z4lnvfXjOAX4uU2XUrcJ3BUZ7LEFtBMQNVgCFQ6b9QoYtwP?=
 =?us-ascii?Q?PGr/XdwlYTiFmgZmybXTcOMnU7E4Dgty9EzOTVK44dpmDpr4cLZVzfNIf+tV?=
 =?us-ascii?Q?/+5+yX0nW3oPPlOqx5NECXq26MuEe5rmVlD4MERee1ayXhnTaPikFaGiJvuk?=
 =?us-ascii?Q?O+LVMPM9uy180UCNxkFN5zbCbBI0pHTDVrl9oTUdOUjOGuBC/AWc1UWGyPR2?=
 =?us-ascii?Q?JQ3AtBZcC0YclWPe+ADkqFO+B883ra8/kLv+vSxeRnlN1eEiGnAa+U8r2q8f?=
 =?us-ascii?Q?c+BvSYr267hFkBsRbPmgUYNU+kSp+WDmnxA8vXH6OXsezpiXyhqSelDS+wHX?=
 =?us-ascii?Q?wjLselxysJDJ2rWGGnX1Y54hFUcSdB/cZhYHapGITEZVWtASlY4vuL5HummC?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N/g+ubEAcDFVhv5MBKohlj1NZpfNxTNEyE/xC4lgZrF/CkAATfOgUF23yLMViXanp20V7pS2Q+c3pMQKe77FvDTISNsl5eN6ZpUWJ+I43J/nzFoiS4U2IW+F1/dMbOXw0BKTo8+N/AxuzdhPHNa3W/nsZ7Skor+4tsQEIPPEUrAIlyI0yg3Hf9D1DBwFjaP438e31lr+CIk6j6Viejg6eGepP+JDW7DBjXaPBNwB69ZSZfW57zUyE7eS/KtMQ3FUvd5sELIFHlVkn5ioFwzxv27n39pTka9Ky2uqRJmAQCBMIbNRC3Pq/2W7egFsL8TtJ09wZ53gtBqXDcMAZlqKyRK0p2o1a1CopMVE8Ck5S9OqjnRbfFEPcL7DPGxU5DIIASeVgRf0yvrdMgxMZw4odzvvy1WYLlNHvkvzKbLaYLmT8NzGolv/8tGBP8LuVfJ4h2douWDJ7f7Fgo2Y3VAZQWmzg0bvx9/Bpr2QO3gSvuaRRr/mvoDsNQwrBoYxks+8FvVpT9C1f3hnZYopIxN4LfM90to0tDJ/JiF+mJH0mRVmFV5x3iSAQGS93Nlktea5QRoGWVE/JLcCY340+TguhJ6eEQtdYyib7ihP7pFIBmw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c1872f-1e7f-4820-d561-08dd8c804d26
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:28:03.5652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nL6woG+roNgXd6DhPA2y9FbY8dvU652HULYFZzpDaxlCokD6mTQpo+UGnd55ApVbQfgIQhIQWiHvfGGQcHG1eA0X+M7wEVF/JHHEmQMFQFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5F5663669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=968 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA5MCBTYWx0ZWRfX3T+6vOHPFPlr ZPmi55YI1HP8K/9ofWGstkB3h7W6t+MsC9lPfDjy7KWsbgkInytzCifB1yjnZVxLifXyWbEAd9P /9qs3FySvB8IjGYDs67s+Yg1TwA3TDT0A0Bvvgik1F+ib6qUzfAXOpfRoGmQ62fwqMnzO+BHhWK
 zSFYU/VDdnEKr9PZAnU3pICBXmvfLk1Ot9+J4n+RwMp22dv4zz/N6aCanqUSnbSBF1phzmLQlXo sZiG1r33Cs41JAW/hG66gtryllt00lblAYxUnH3Nt25+yFdU3KZn06qTn9hFljlB0oGA9Ff/kNc nmAZv8K9srqr77Nud4veFkVwJKvvxeXksGTAn9fW0Vzjz8dTx62g3gofxitKNdbm8pKkz2Jg5Pm
 Il+j2Yg/gkz1BfYN56WMyxFBtJOnhPZI2RHYNcuYj4oAl/ugXAX21axiqo0XCO3tgQfQ1KPp
X-Proofpoint-GUID: MEJrwHCeMB1D26tE6fvY8zG1ClS9tofX
X-Proofpoint-ORIG-GUID: MEJrwHCeMB1D26tE6fvY8zG1ClS9tofX
X-Authority-Analysis: v=2.4 cv=Xr36OUF9 c=1 sm=1 tr=0 ts=6819d6e3 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=fvxc5qcxjXObj9NY8DcA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13130

On Mon, May 05, 2025 at 03:35:13PM +0200, Christian Brauner wrote:
> I'm completely lost as to what's happening here or whether the test here
> is somehow at fault for something.
>
> The pidfd.h head explicitly has no dependency on the pidfd uapi header
> itself and I will NAK anything that makes it so. It's just a giant pain.

There was a debate in my series here about my having to make things work with
'make headers', but thanks to John we resolved it the sane way by using the
tools/ stuff.

I _believe_ Peter is just using this thread as an example of a recent case of
people being asked to do this insanity (correct me if I'm wrong Peter) and it's
unrelated to pidfs in general.

