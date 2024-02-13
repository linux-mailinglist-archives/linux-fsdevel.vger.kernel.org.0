Return-Path: <linux-fsdevel+bounces-11420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F9A853AD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 20:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB98A1C2274C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 19:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F1F5FDA1;
	Tue, 13 Feb 2024 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ayUSpQfA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MXc46arp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626DD111AA;
	Tue, 13 Feb 2024 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852140; cv=fail; b=IeksXZcYnldzInfL5Cr9D/lImBTcceO5U+/tRq9edHQ3aUqw+kZm6jwXY0ryyxR4m87ZSvo54sJEy6xbZXsayfK1Ghgj5zhGC7xKa8ETUFUl3vqI7aNbAPfL0VepFyp5Tl6XRgnhEY+NIj3dPq5sw4W0QxEMmuScNLG1bvpLLk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852140; c=relaxed/simple;
	bh=QzQ1FcViU3NZJITF/DmMLfT8E/60QDmdWBcGqlFVthM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pU2a3l1393GYR4EQipLv8z/nTMufqt3HlKLvN15eVBWitZdR5eOAHHwd6UPoDJG4rtzWya2kPNP38Wp/bMVX1gRPoIH82u0XRmKY+rc+vPiSP/WzgKhfYmJS4hOJYke5eSSOH5ZEFD0XmkkNBOPK31z+mT/X5YjcSDcbi0CjUJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ayUSpQfA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MXc46arp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DJJo3L013493;
	Tue, 13 Feb 2024 19:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=OAqo34f98Y0Xkzw1Az0p9o7sghVwbqoEkrUaKTS6t2I=;
 b=ayUSpQfAtm3nvQ5q83StZypdY6qyXFIxXTtBofiK2cgF1O4yatFvT8pgJVzzyG4/+SlR
 WZp9I+nNPGFohRsyHjPAvQFIE66rCvXs72bT6uxEUrQpaGcbiIU76fk079CZquR/PmFE
 WIUzeEkb+6hF2Qiwgl1izoLzZdCVrtUqbWUPPUcTXEyEXYkWVcCR5SFKorSk7vIApRVl
 cNqqKrAgvqfCOedUmOP0dte+e9+zIVcGYZn2gL77daBxZby/tRfpr6+txkh5nvAjFMKD
 VmUNGBwfFYjgbNUz8oQjbbOkFNCtgSdzrCPaX5Fu9KoOiGZcCa5DZsTrPWIcZV6T3m39 4Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8efvr07f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 19:21:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DIDqjW015104;
	Tue, 13 Feb 2024 19:21:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk7u306-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 19:21:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UroKaFtI1MI15X44OXYn05uw7IDbmXKeea6/2DOes0jM0iCgQbk7lFk1kxNqZ0iECf1FlFwO72FNWc48pFwfw1S8ENLcflpKTo9gpSb8luzQOSCv1c8g06L6bABnJiDnUKM7DeIZmNGXnVlMbPEqAngq8UfOOFj/Lnv8SACP3SrQPJ3nvnEp7wV+ADPiV1yu8XRGs0OpcNUDR2vcmFNvE43D33U7tVTyAvOXgFuR7Me9qHaz6VItzx95i2lzpGM3pzz5PsR/ZICnP8RrDv4/2EAkBt7gV+S2jTEQLqrYp5PtPqJTr79m5aQkFcM3cQWeL3DcZSb2OU8hDg/9hCUVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAqo34f98Y0Xkzw1Az0p9o7sghVwbqoEkrUaKTS6t2I=;
 b=meXHrOiLab31aDym/4oDFFaefIPuh09MtSzplvBf1gTVDtphwbZPdRhqIa6UlMcvgcfrFlsGlG91/t36Ec9DtlSuP7kDiLC0uY8XTf28M+3NpY85ANkg7r4aK0EKTLk/oKHzwEhT2SfROEFS+lu/dJw2W/kJcgadhiOEiTluvFow7TSi4FmILwlsHKLwCZvBrEwR+jqClXfAOL3LXOiefk7Mp8ylrEmPGb5P3NUdhd5ksKf5Ij0aMUGbQ2Vd588zn66Dpo28eEIOoyl5mqqZhvocdnBGvonISidrNJc9Mnh6Wvn9FeOcZsf4lGEOdRqzWRRy+Y3/mKD+5//zWoRiAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAqo34f98Y0Xkzw1Az0p9o7sghVwbqoEkrUaKTS6t2I=;
 b=MXc46arp9mXnd1fQWWFmmJhHZsO+adCA6mNDQdcKOVJ4RzDqsiuvcRwEjAh9YgcMOjd9PVC+yE0X/woz9QVKC5K9QJ7Il3kC4THghWviLgHSGVlHkhpnqkuxxUoo7k3hn9AajLqu8OeEKAitXikUS91Rry/meC0m8dWFzI4/ycs=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB7718.namprd10.prod.outlook.com (2603:10b6:510:30d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Tue, 13 Feb
 2024 19:21:34 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 19:21:33 +0000
Date: Tue, 13 Feb 2024 14:21:31 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
        david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
        willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
        ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v5 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240213192131.wgr7htg7crhmrsl3@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
References: <20240213001920.3551772-1-lokeshgidra@google.com>
 <20240213001920.3551772-4-lokeshgidra@google.com>
 <20240213033307.zbhrpjigco7vl56z@revolver>
 <CA+EESO5TNubw4vi08P6BO-4XKTLNVeNfjM92ieZJTd_oJt9Ygw@mail.gmail.com>
 <20240213170609.s3queephdyxzrz7j@revolver>
 <CA+EESO5URPpJj35-jQy+Lrp1EtKms8r1ri2ZY3ZOpsSJU+CScw@mail.gmail.com>
 <CAJuCfpFXWJovv6G4ou2nK2W1D2-JGb5Hw8m77-pOq4Rh24-q9A@mail.gmail.com>
 <20240213184905.tp4i2ifbglfzlwi6@revolver>
 <CAJuCfpG+8uypn3Mw0GNBj0TUM51gaSdAnGZB-RE4HdJs7dKb0A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG+8uypn3Mw0GNBj0TUM51gaSdAnGZB-RE4HdJs7dKb0A@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 69878155-707e-4a80-3e5a-08dc2cc8fd7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jXFnxyh0wqm0QlYqvaRrNyHTkXoAns4yXOIQRLqOu56J64HAHoAilObZT7Zf67WLaHAB+idZiczMb74gVQvlrFzHEJFGEohfaPM4Ft5KSA9azTijHnXFt8sxpjELo6OrlrrINV8TOtNFq0USVBbir7FFr7mdCVFCchPjw38KoR42oYfKUB1Mzh+5C7gJxcsqBAs9v5bxrs6ywdAR59+Y4BfMuGx2L5LoxWx23iL07rRPd/F4ZD/zxK8lM/isMzijhiKQ8Nb2diSY4U1C/Ircapcg/aMgp/U87Uo9/MwZPcxFK+G+d+3suDlKaeL9XDjBv1jVle0bVzsgq6X4tvP2RcJdqxjcBw0zp8gBKOl0QTtrsCF811RVVvvscSuTF5osCSWWrorEkuF02S4jJqKUMnggs0UwLEuaO4SUPd99Zd0Om75gU93+z5ztHJmcYGTrS25CadhPxhsbbbBr1I7cutrlPGWOcRryBB1vQiZzXbf852GVRGqQg6RkyU6OSUlJB/eIs/VmyORRZTERBWrgyFr4NLvdTxxApHzmns7M41FgXD3r296tvMntu7l4gDUd
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(346002)(366004)(376002)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(8936002)(4326008)(8676002)(5660300002)(7416002)(2906002)(4744005)(33716001)(66556008)(83380400001)(1076003)(38100700002)(86362001)(26005)(6916009)(66476007)(6506007)(66946007)(316002)(6512007)(6486002)(478600001)(9686003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fB09WlAMHpcLB5BdTUa4uGFQq3QE0FxN7asgLbx/4Z5yTUMVM1ytcFAIOnEj?=
 =?us-ascii?Q?zskLnVHugfV2mzWRpZ5rPZ7WxkHOI+stncIMOKYy7BoBBj03Is25x8PFcptt?=
 =?us-ascii?Q?TIDEwU0xpa7qvmvWmY0mq7tLD/nRC/Q8Tw2dfHyewWmRiO1ag8cLT4ybj0BD?=
 =?us-ascii?Q?EzvBh3Q40LS+ccj1oJYOZiUC8lVWmlvayv906MQuDMduYBJVG2qoKdZpPNe8?=
 =?us-ascii?Q?ec5fgTmrtxtcaad1l01Pqed9xkyA6lkl9IXSBH0DjcCo4ydllKtpLj7NPuCQ?=
 =?us-ascii?Q?+ulR3ghLaAmV3mwJ+sHBAd567AzX8GkFxG5dP7WIuwYqZHS4JOVLz/+Y0etW?=
 =?us-ascii?Q?CzzXOaU7U6t72yBXBUWSzQ9ijxfkSyRlGOF+t8nRTP+ieGdIzgfza/VM8tqN?=
 =?us-ascii?Q?4GyQeZetg8VOgXgTN0dBt2+H6i8jRjnCROouzOCLF6JV9J45Egmq7nFhZ696?=
 =?us-ascii?Q?eQSZ/QgwXSceLYPwq5vpzO65oJFkiGjjQJ2JiFb2twc4McWyLZBYQdJHmID/?=
 =?us-ascii?Q?2u02O+h2xFSRg5XCU9g8QmgNDRIWveRraV93jbVAISfUoM1RVQgDl0BRXzAY?=
 =?us-ascii?Q?bSsYH9OBUQ4FWhq9SIA9QShzRu6ak9fa008wUTfLWsLzMv/QlIwmVCHkWteN?=
 =?us-ascii?Q?6fsndIeN2h3v2ZHf7PGUgHYxl1ffggDkeHdbpmKaTgUCPakJNF84W2V4JetN?=
 =?us-ascii?Q?xCbkoox4e/Q8dKxmwmfXLqYh1S9ztWLz3VlRgy1jLdpVky3zJH0bE5czVLXA?=
 =?us-ascii?Q?oocf0zUWccBR/JRiZTuBpeJrMqJQgZtPBzz3e4Kwt2DTH9P1vp+fZWBDSKGo?=
 =?us-ascii?Q?L3K3c49gAHI22LioYuwojnTnI8RkWTT+0sASpXKDhTAR2LncrIFDsMwOQhW3?=
 =?us-ascii?Q?7GJCi8RIi86AFQsCWjtHfI++o2yma+UaDgWJLweNaWIFITRROqDBL6ORdTD+?=
 =?us-ascii?Q?sSMYep5q1bGIc6dR2JjhST0tml7A4ypCYZ/dXKFc8XZ+OwkuNxLKANPV8gi4?=
 =?us-ascii?Q?J9xy4Xv0PfSxwE+BvMaJeg0/Xw6gh+omYXWpkPZUKU6YTLhDTR1bX//lTQ1k?=
 =?us-ascii?Q?SaxT87x8ViIrsbY8DboLiLQhNx/y7FWlHL0gY6kclbsvKAb6PmNg0KqiRAS+?=
 =?us-ascii?Q?ztzd41c6bKiVtEqLWC5ORNzaS4vvIpgzkmnledBrRyrhlTZjHgVrJNpkKoPi?=
 =?us-ascii?Q?6MOKIp2n+mwQJlEW4WjbDWBdZXRttzwsKymDc70oPGDDpLg/tUd+E36/8to1?=
 =?us-ascii?Q?oAXpcj0IWXkLiAwK2FOXuJyKT3SzLTZXZJwAJr1X+/sxd6lv3EWPsMotO/FL?=
 =?us-ascii?Q?l0Cm/WTlBOGkTvabR2gI100iMv+mS40hG8tO6i09V5xwTeNg2imKAdAGOQrO?=
 =?us-ascii?Q?/qAfDLDUmS+lMzA2ZS2W8RLvUGUYnlnx3eX0jTq1z7Dd9hAoYuk2hwYEaLwL?=
 =?us-ascii?Q?GdeeRDOqRbEbL9KZnlxrnJ5CdlGmGmXvM/609+Pq6928ZE37OYyQ51CWPmkr?=
 =?us-ascii?Q?AD8CsQ9CwCQxLcvO3DlVec4tYfDiYme5KnotDCVTjZ0DnAPd1cfOfjnepyjp?=
 =?us-ascii?Q?VoSnKnPP0DExJSHJDb2r3oVI2ZvgZrRdW09z85Db?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	M37SAG5HGp89koCR2pe2pSmDkViMGnDjuJrsSAWxbNwNPWZVwB5As1SdhxesZ91JPEG/eygY3i2Fs7TmgzsIvgj4OT9xMGXOuLa8Av3gtDU21kZ2txJTjcmxnf2vKZD5Z8ywQ0jIRPjjUzEThRFX0rV+URChkbTKUn04mGBDSr7zz+p8n+M/fKH3QmKVYThm9++WL2CpFmzPK58O4Uj55tqQD1QNcyQYuPe5KuApIxF/lnYUDYaHXVGiIMHZ9Vw/8Be6kLCbB/1g8i146XtrlGatD8eMCtvTzVu4KnOt6uahh/di8E1B+b7A7lncGrpjmx12MKcgCl03t5VdxMJm3ig/RMS6SImu/r9LZsCBkyOZcSHU/FEfmixIN30ATzT9okCwpaXMHlN3jjqrJ6+YzhS/8KPAP9t7NFeHcq7OJ6RykiLILHR4Q4YBYGU7hPreydniXM7WRPvRYJtOuQa0FaSGloDM+SIpRkFFJ9Y7DDBTShfykF3M2SzI1wamNtXGMJyeIGfCqrEY2kLeRDkpWQu1SpC6KF2Tbe4oMnJl5UwIBlOo1cieZpQ7EOYNUQrpY3S1AwunhfaCPv5Dd39LgMNAmyZyGgGDbg+693K5X5I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69878155-707e-4a80-3e5a-08dc2cc8fd7e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 19:21:33.8763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpLKzcpRFETHBScQ3RQO3okc/3Uxk1dEQj5d8a0eYOvn1Lck6UV4pyLVGFS+LqmXqFwKH4tlYtFhAzo23PM5Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7718
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_12,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=735 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130153
X-Proofpoint-ORIG-GUID: YIXqzCdfABWKlZRT57DFssJtAQXMewo8
X-Proofpoint-GUID: YIXqzCdfABWKlZRT57DFssJtAQXMewo8

* Suren Baghdasaryan <surenb@google.com> [240213 13:57]:
...

> >
> > Yes, I don't think we should be locking the mm in lock_vma(), as it
> > makes things hard to follow.
> >
> > We could use something like uffd_prepare(), uffd_complete() but I
> > thought of those names rather late in the cycle, but I've already caused
> > many iterations of this patch set and that clean up didn't seem as vital
> > as simplicity and clarity of the locking code.
> 
> Maybe lock_vma_for_uffd()/unlock_vma_for_uffd()? Whatever name is
> better I'm fine with it but all these #ifdef's sprinkled around don't
> contribute to the readability.

The issue I have is the vma in the name - we're not doing anything to
the vma when we mmap_lock.

> Anyway, I don't see this as a blocker, just nice to have.

Yes, that's how I see it as well.

