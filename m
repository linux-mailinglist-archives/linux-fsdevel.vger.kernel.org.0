Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C4479CB8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 11:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjILJVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 05:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbjILJVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:21:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD868E7F;
        Tue, 12 Sep 2023 02:21:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C7mxaH021748;
        Tue, 12 Sep 2023 09:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=BdIN0oX2rk3bRzU8mJCgOIGfEw7RPID06AQ89YUwQpk=;
 b=iXGbcollFM4roxKSUXJ7OCLYigIWBIkRu996KBhM830jzJpRx8gipNIEGs7DFnrIqcme
 CvLUO+eL551pVAUC3TNhLXLzbvZJa9uiDWTsUytUrPGQ1KejneRXYf8J4uws1fATXU3c
 ZKqCDs0JS2Rs43J+HS1/c+TMb6l5+VvypqZf+pjcl3jNLAKemNxzdexLIqD6YP4Lt9/Z
 fiFHk0h4v3XJmEAst4VnytYpfJ9PBJ5Bhl149ihY8eWWnRk8LqnKj+hSwk1hUQzPE0JV
 0702BPm1dCLBgQntnOBAMayIjEOBJVyQwjspBH2z2mvvlnASgQ1suluRVsACZvd/sYbx VA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jwqufun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 09:20:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38C8fsUO004480;
        Tue, 12 Sep 2023 09:20:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f567j77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 09:20:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drbtfDFB7iB5mwRAnU9i3f8+QQazPvqjNBbvn7HxwD76k7MiSBKwBfTwgk1Nw3AdQaYHx4qOikcTFfnS0MFbXqv9LB53u7m8Ztl8S8Ea10aKNKJHkMVI5e9QZsPaR7ZzAfSuL6rJajT2/Ecul8Ll/eJCT/8QjUaE3KcPy01eOFh9xgzPCpyZpUIW7RMlygdN4pTseahW/ox8hj1Q8Hnw5q2uu/WFYfyT/TKHM0VW+0QsWQVYMg/STrN8aElcHtYdUJPx1/nY6WgxDFBMBqmNrQU6vxHzloriOcSmd3s/VJcOC19RBTerj+pPikYWLbftf5nuNZgqTCkxVTwrW8iWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdIN0oX2rk3bRzU8mJCgOIGfEw7RPID06AQ89YUwQpk=;
 b=VKC0b0pfKQMcH+lxSUhUTqEZQwpGFSWvntAI5mqXK1l6nnz2ltmhjtbYRhH21RczQvGmI6rhja0Sf0nyyjzHEAiDvGnocaRREo8Fo01qwFYL9nNmkNWr1PGN9om8I217OB3wO4NdR6Y+nSetvt/GBrEA97oQjVzVD9fymD1AMhLMk9f06lW3qQLTPNjdQPSVN0okEs41my8Qd7jmPPC6CrtH2orkvSfU3kpb1zm/g3thqa08fferVi/4fn3C5umMR4tLEg3K++p4FIcpvemVC+eIfzKvSn10OofRH6CfgWImHJXCzQkbrQwRmuK15mD0zijViuO/0TSSAHXfmIaZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdIN0oX2rk3bRzU8mJCgOIGfEw7RPID06AQ89YUwQpk=;
 b=qxM/NLKKlneL/xoimZcD5ncjwML2h6+LsS0c4g61/e6x8OgaJwW0b7FTULDnEyssCyb62ua67dJZSbI2sC+1jKUu7TSuqDZ1PIKM++Iuq6LkbWdZQQCyeibHI5ae9vKTRJ3YDRb7Hzhli/E9T43dkSIF35wt+ov2XditmEV5JHk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4616.namprd10.prod.outlook.com (2603:10b6:510:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 09:20:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 09:20:54 +0000
Message-ID: <b25f8b8b-8408-e563-e813-18ec58d3b5ca@oracle.com>
Date:   Tue, 12 Sep 2023 17:20:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V3 2/2] btrfs: Introduce the single-dev feature
Content-Language: en-US
To:     dsterba@suse.cz, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-3-gpiccoli@igalia.com>
 <20230911182804.GA20408@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230911182804.GA20408@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4616:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cda2bbc-018f-4228-0194-08dbb3719056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QcE9O1X+FA8aUcc3FFWccDmdx5l2hT0kM79yFo3b1CKqlkEGT6Pr5oP3/N/InY076vEUAplpravhcOmVP/OuF2KM+DMDDn1OLTwNmDfwI2PkphjVoIYoY2GKw0gRHm3BHPfiAky7I1tbrw2oy4J99ywha1swzgkB8siPc6MMpyUg8rHVU0z6NHT6gGyN9JiVzCJ9H22quRm75A+SKWd+WVGpsw1HbKN0j3AK60Uy5ZUcdTOWm8aVS84YVRXJ9LzwYL1FKhKLBaf1i3yy0ebLJxKuHi2xp4x09JexA9PhTaDTLDaxyWs31zAnQecA/DyFBzV6lW21I8BWM3fr9UI/XVD1RhDAzMJkvzjOFrc+aQvNwX1KGSSkcBMI9FsVCWUayBKYOG/7PDU6KiBPL9jeNU0ZiH03DNtYMUadtmm3qlRi2hXAZyTS7fTNTDrg4TEbBwFGrMhF4qgc5/NMi7TaDg/5p2Vm34EVwViycuXzxLanW7ZvIczOxi/IOqRSf2PtU8lOXIoBN0IDK4KAYQ4W3A6vlfXyAqw+hduMlQCl9T+AtQJGxv1ep7vQOS3QsMd1MvrfFCsCP74ShjZ1tSJ/ubrmXPSL/K41UTuNeKXBS5CFCTqbyICeVupgrTChZR5RcI1MRh5AwOJMgbmtKcxISQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199024)(1800799009)(186009)(6506007)(6486002)(6666004)(6512007)(53546011)(966005)(66556008)(66476007)(66946007)(478600001)(31696002)(36756003)(86362001)(38100700002)(2616005)(26005)(83380400001)(8676002)(4326008)(8936002)(5660300002)(44832011)(6916009)(316002)(41300700001)(7416002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTFVQjIxaTZnckpkelVGbmY2RFRzMjRxNVlRMTB1Z1QrMmtiempwWTR2djR6?=
 =?utf-8?B?UW5LdjlOWGJwKzV1UHd3QmQ0YUpWaHQ5WUF2OU1aQnNxQjdyNEFvTWtvZktL?=
 =?utf-8?B?eGthWTVPQUV0QlBwaTBnQ2V1K2czd2JmV2lhRmthdEJMRlZlOTU2cVoxS0lw?=
 =?utf-8?B?UDg4a3JFUExQMlJBY2ZpejJ1OGtaamtoQlUxbzlCM0VvT0EzV1IxUGIwZ3lq?=
 =?utf-8?B?SCtmUUVvRHRJMVNsRlB2R0EzcjBHamRYck9PZVh2NkdtMmVScFZtcTZtdnJ0?=
 =?utf-8?B?aTQxNlprT242SSs0T3QwdVFqTDNneHBMaTYyT2RJN3UxKzJlV2duZEdBc3pI?=
 =?utf-8?B?ZktMOHdMS2hKNjV2bEFIMUwwVnJvbzh3OTJ3Umw1S1RiRFowTVhMdkFNSXV5?=
 =?utf-8?B?WlFRYlpLSVR2OW96QW1kNnhIQmNSRW80SmlzUEFrNktRNE5zM2IyRHREdmM4?=
 =?utf-8?B?aUI3RUlCcnZqL2R0cXk4MjBPM0RDOCtUYjFVeFN1dkdONkUrSHlMZktobDda?=
 =?utf-8?B?eFRRSVFFUEM0OCtCSWEvZXJmcnErVkMrcW5PV0lvNjRqdjBSODFGMklYblVI?=
 =?utf-8?B?c0FDZDF0c05xQ3p4SjlaSHJISk1xR21pd0lyV3JHanhMbytxdUY1MC9BbVlu?=
 =?utf-8?B?akw4bFdtOG5tN0tjdVpESFZQNHAyUk1vMkNqTWh1L1dFSjY5QlRhemw1Y0xm?=
 =?utf-8?B?UURqc1lnNDZGajVHNUNya3FjaHowKzU2V1YrNFpTQmRIZVBxOWwrN1RRMlhH?=
 =?utf-8?B?UUI5YVdxcTI5M2RaTm9aOVUyYWhjeHNMcHl1WWtmZlBGUkNEL1YwcDljaDU3?=
 =?utf-8?B?ZDV3U1ltQWdXNjdaUVVJb1ZFMzVidWY3b0hhaFdXbVFjRHp5NC80WXJRSVNZ?=
 =?utf-8?B?dy9PdVJHdmVJSWtGdEt5T2NvTEU3TGRiRmJJak4wZ0hOa3NuTm9qSDdqSkl2?=
 =?utf-8?B?VDg3bmdOU3FaWjhrdkdvUkQ5MVgrenF6Smd0bmMraEdpN1duWTh6ZFhpZnJl?=
 =?utf-8?B?Tmt1TnpxajN2dUh0OVpRSlZrSk5KcUZLcFY5MWxicE9oemNyTERObitJVEZz?=
 =?utf-8?B?a3JlRUlkMUozRndjaVc3N2RQcHgwMDBvNDZ2aHNwY00xS3pIUytITmJBeVNs?=
 =?utf-8?B?cVpHMENXcFpvelBwYm11MGFMUUZVOFlxZmtTbEVkY0hCNG1makhPRDBncGph?=
 =?utf-8?B?UGNyNDM0bmJ3ZWhqRFB6ZWZIaEMzZmViYkVDUk9HVUVsNEw0WFd2UmwwRzRI?=
 =?utf-8?B?QU82TlNPSlduakpYalNKTnJXZUw5Q1d1cEdKZ09TOExEVzVpbHVTSEg1N1V2?=
 =?utf-8?B?U1BvS1JtYk5IL25COWRlT3ZqVmdSS2puVUxObXdiZjlsVzRRQ2pYYXZCVG84?=
 =?utf-8?B?TDZ1THc1cTNDelhYZjBqaUJqUlJGUFVkQWdCNm1YeEkvZEFMdWE4WUZyVFFm?=
 =?utf-8?B?K05CY1JwSXF0cUt3OHhobFMxeFFwQW8rU1JabW1BcnlxVk1KOXUxK2dVZ2Jz?=
 =?utf-8?B?UDNlQWwvY3dZZjBwUWpQT3FMOFNXM0lJYW02UUthUWFrNUY3cGlaRlgwYi9B?=
 =?utf-8?B?L0JIbmlxVW1nSEFCcldyUlNOR1Z5WVNNODhVcGoxT0dpMkxaMVVKd3BKdy9a?=
 =?utf-8?B?eHBUNmFreVJzTXVMOXdsT1B2QlUyVDBmUE8xU2xOVFQ5VXk2WlZ3TG1ib2VP?=
 =?utf-8?B?c2RNazd6Nk5kcE5XRGhpaFVRUFlBVzQybUJwcE5XcUYzWFJTV2hRMllJaFFE?=
 =?utf-8?B?bFVsWXF3MTI1SkRqSW0zZWRCVkd6VWtzSlRIdXcrcWhjMmRvMy9TSFZsV2Iv?=
 =?utf-8?B?UytDZ2tzMFkwZFhTWVBvaUk0RTRReHYyYzE4RzdJQ1hOeHRNZHFvb0Jyb0ZN?=
 =?utf-8?B?R050OWJQV2FLZGUvMXZZYTBXZG14MVQrdmJTbG9DenZyNW9zaU1aQUpJdXdJ?=
 =?utf-8?B?a3RpYUF0QVpNdE1lVzBvc21Dd21YQkFiOGxBVllFbTgwZEJFVVA4VWpxQmpq?=
 =?utf-8?B?ZzlWYk95Vzc5SzhWQ001MnIxYndLcU9tR3N3L1FPMVNzUzUxcC9JUHk5OC9M?=
 =?utf-8?B?TUFpb0hrVXNha29LVXUwR2w0bWR0cnc3MERvZSs1c1VLSmw2RjVkVTNWL2gz?=
 =?utf-8?B?akxrZmxaQ2tMcWhEcGVMZFY1QnN6ZUpSZlZXdGRYT2VJUE94THd0bVZUMklH?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?clEyYVdsdUtpNG1ROXdaTlVDOEcrNTNnT1ZWcXJxTkdDRDcrMHhBdTJLbjdS?=
 =?utf-8?B?cmNXMFpvYnJjTm1mWUhPMExVcHhJQ0U2dC9nOGJuVlRwVjBhZGhrcXpYYnhl?=
 =?utf-8?B?cllCS1pLdnZxN0NmZi85cWk2ZEthWlAvMUg4bWlaSk8zNDF0Q0p5VlJEdUdh?=
 =?utf-8?B?S3FuOVVYbTZYQnRER3llVmZZU2RmK040YlRaaVBlbWhzZnpaU1RYSlc2WmVV?=
 =?utf-8?B?bTFzRWRCSmhJcG14UlNiVVREK0hhcEUwNEd5ai90a1NGZzUxTk5SMyt1NzBi?=
 =?utf-8?B?V0VnbHU2ejdqY09VTlJSLzJXQ29TbklTVVQ1dmtMaWhnMHUvSGFhT2lpaU1U?=
 =?utf-8?B?bjBXVnAyYitLQlNmTTF5dTFXbktRWThmSDNMSXd3d3d0bGRPbngrWEZqZXc2?=
 =?utf-8?B?WFdFbVFVS3B1ZUtXUXRISGhMOVc1ZEl6RTlTY01qNHN6T25aaEtVOTdvQk4w?=
 =?utf-8?B?ellwSVoxOXJtSjBTV2JTc2xtcUZ0Z2lyWDM5QS9OdG8wVEZGcXh6WTJjdTJU?=
 =?utf-8?B?bVJHaDhTTUVpZXUxd3IrUWN0eGY0SW9VM3Q4MGFxYXVJMHZRSFpoWmozUHho?=
 =?utf-8?B?WjVPYWZ4bmlDdW13SmpxT0hNTnNSWkdjNUpHSUlkMHZTMDhmcXpTSFRqVTIy?=
 =?utf-8?B?Z3dkSWxCVmFmOUEweXhKSXNFdEdKeEkzZzJESW9hUFhicldEdk1CeWJ3cnVs?=
 =?utf-8?B?VUZlWkpXNFNEd0MxbEt5YlpNa2RXV3NIc2d3VjZmZ0hWcXFSMnRnMm8yNEh2?=
 =?utf-8?B?a0RaU0svTUl6eVVjNFlVRlI3QndtejNuMHVxQUtvd1NiSXBYVW9HNUNMY0V5?=
 =?utf-8?B?Mzk2b3p0OXBBRkFlTGhycE1Vd1FYNkg1MnVxVlZZeE5PWWlRVEJvSldPdzBU?=
 =?utf-8?B?QXhFd0VZeHFRR3RDMmJYLy90eS9SNlB5MnNPZFVNNWFmYXJ0SE5HdWxMaklW?=
 =?utf-8?B?OS9XMHZRd2N2cUJ0UmUxUVZleTBQZ1dXeWdlMjMxZE01TEpzS3F4R1ErV2Ni?=
 =?utf-8?B?ejNEcDYyR3NqNGhJR2puUTZwaDJSWHk3RWxRMWY3cy84WmtoTldUdkJ0ckNS?=
 =?utf-8?B?SnJ1d0NBdjBuMThYRW5NRCtrNVNuWkVyR3MyUzJXQVVoemdVcDBGaTZNTkZ6?=
 =?utf-8?B?SFd3L1VHSjUyU3BtdktoQmxNNTZZYUl4RU1RZzE1Q2t2VDdRdFVibkxkakxq?=
 =?utf-8?B?MXZ6eUVjUktBWVhjbFZ1dHh2aUZvNkFMMDJHb2U1QlN4SE5xS1MrL292WlZk?=
 =?utf-8?B?Y0pGYWdUZDFxMUtQV1cyVFdWNHQ1NE1Yb2dndjlhYTd2VnhZa0VZUGZLK1BH?=
 =?utf-8?B?NnlUd1ZmaXM3YkVZMGo1Zy9XZzVhVkpCQytuV2gyZHkvaFpBSHQzeVRxQ2JP?=
 =?utf-8?B?RytQbkc5NWN6OC9JTjRXRFl2cjhiQlpzZjlqV0pmN3UvNkV3TDRTM01kLzUx?=
 =?utf-8?B?cmdWSWhUWTVKTUhRc1MxekVoY2orM0hsZmdoUXVyaHU5QjlFZGwvSEhMMzFr?=
 =?utf-8?Q?aVI+Zo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cda2bbc-018f-4228-0194-08dbb3719056
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 09:20:54.0153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYSJG1ksLw8S7PGzJxO49KdHm6/c6rJKpNWJqJ2UfSHXgQ1lF4jN4x0AStB9heD3tjwNBFEuvca3mu//SnFmtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120079
X-Proofpoint-ORIG-GUID: Td6C_eEP7hhZ-ZBr3avVmJhqXNkgdWCd
X-Proofpoint-GUID: Td6C_eEP7hhZ-ZBr3avVmJhqXNkgdWCd
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/09/2023 02:28, David Sterba wrote:
> On Wed, Aug 30, 2023 at 09:12:34PM -0300, Guilherme G. Piccoli wrote:
>> Btrfs doesn't currently support to mount 2 different devices holding the
>> same filesystem - the fsid is exposed as a unique identifier by the
>> driver. This case is supported though in some other common filesystems,
>> like ext4.
>>
>> Supporting the same-fsid mounts has the advantage of allowing btrfs to
>> be used in A/B partitioned devices, like mobile phones or the Steam Deck
>> for example. Without this support, it's not safe for users to keep the
>> same "image version" in both A and B partitions, a setup that is quite
>> common for development, for example. Also, as a big bonus, it allows fs
>> integrity check based on block devices for RO devices (whereas currently
>> it is required that both have different fsid, breaking the block device
>> hash comparison).
>>
>> Such same-fsid mounting is hereby added through the usage of the
>> filesystem feature "single-dev" - when such feature is used, btrfs
>> generates a random fsid for the filesystem and leverages the long-term
>> present metadata_uuid infrastructure to enable the usage of this
>> secondary virtual fsid, effectively requiring few non-invasive changes
>> to the code and no new potential corner cases.
>>
>> In order to prevent more code complexity and corner cases, given
>> the nature of this mechanism (single devices), the single-dev feature
>> is not allowed when the metadata_uuid flag is already present on the
>> fs, or if the device is on fsid-change state. Device removal/replace
>> is also disabled for devices presenting the single-dev feature.
>>
>> Suggested-by: John Schoenick <johns@valvesoftware.com>
>> Suggested-by: Qu Wenruo <wqu@suse.com>
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> I've added Anand's patch
> https://lore.kernel.org/linux-btrfs/de8d71b1b08f2c6ce75e3c45ee801659ecd4dc43.1694164368.git.anand.jain@oracle.com/
> to misc-next that implements subset of your patch, namely extending
> btrfs_scan_one_device() with the 'mounting' parameter. I haven't looked
> if the semantics is the same so I let you take a look.
> 
> As there were more comments to V3, please fix that and resend. Thanks.

Guliherme,

   Please also add the newly sent patch to the latest misc-next branch:
     [PATCH] btrfs: scan forget for no instance of dev

   The test case btrfs/254 fails without it.

Thanks.
