Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7877BC38A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 03:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjJGBMR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 21:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjJGBMQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:12:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB80EDB;
        Fri,  6 Oct 2023 18:12:10 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396LNxRC026633;
        Sat, 7 Oct 2023 01:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=IQ/Y4GTZQT1n/Sgrv7PZygmMthsu/NN4CKk513gI42g=;
 b=NhWA3fUfql6S3lZY0kC22xfSxRO525Mt4s2SEp6Q2jVgCvW+rha1y60JKxDXMjSXP3CM
 j1bk+bHmyFZCgTDBy4nDcteiJc6mvdqursp0f2coUIPl1LxdCobs5HxNVisK3anJPvFF
 h+nHUP+Syb2NhOqIE03ty31NgSZCK5AnCzV6tEjiXaXdvjiIP44E1PNgtEA66UfZbHQi
 g8oq1ME50a5fDeQUEvegYZT+kBbhgtMlVMPzLQMALIvwdeQiNN0JDoQSVb8+I1gvgS1N
 PDAs5puWNjpQJb2fmbnTppnsIMcYqO6svXtzWyixnYR5r0TObtD29OWY5QJ8HrCj3iBw 3w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqe52uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Oct 2023 01:11:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 396MWZk9033618;
        Sat, 7 Oct 2023 01:11:10 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4bm30u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Oct 2023 01:11:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gh/Gc7sz/pR1z2wVnZgZRqb/hQKHvDzEYdac8Tx6eaBMW4pCizsUopR853ZRA9FJiJ84TABdc7atg8otsong/gbDaOOjIw3BKhe6hwH18jXZWurfnzOZM6Ia4qg5acTHZtAhhrhWH+5s8ALPwiC/8oWl0DkfpVaXebcvBNSt+/rkNIaRCDr8TsmCxEMjhkdceFPJiAJzdc+KCWSagLBxjknSdPKBxH0UmE2h/f0NuvUmxgHDQ4Y7Dz2J72IJpFGc/tMcMDGKhbyf8s7fmGMYHI8hcGm1hWSs1FVueHFHJuWc7/cqXc9W0behRorgn4aXQWyIl1ETOPHyDE+g2eRSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQ/Y4GTZQT1n/Sgrv7PZygmMthsu/NN4CKk513gI42g=;
 b=ePaWWYBQuPNPokwsZbapQQ8G2g2aTkByXNVdGjErwtZFrQaxH/zVZlBIfpwLh5T95x0vzAFBpWbnnj1fhH6ru/yeCJ6hP430U5MrWSifNbsBOxMTB7vZTwj9tIjKv6SaLac8KaHsE3iNfKWB1zr/xMjMbX5ZkDGLIBJ78JG7LFpLX/EGX+FVTnQMTdkU/LpoyOHRF58w3UgSlI1t/nBghGU9seTb2yKTqbB98GIBvRJa4wEv5+Y8rKGvQP4kr1F1B6CIWC4HWDax1eycnzXMR4iP2XQope7jKz1dPNeSbcKZQrQ1yE18pHHFgQ9I2t8H/nfB7PN+x/0kEvs5CsVpgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQ/Y4GTZQT1n/Sgrv7PZygmMthsu/NN4CKk513gI42g=;
 b=OLwOl9LSFIiK1CXepXQKTfi+K6mbrcApYhLHCBrTrFUl4OCFekq2eMNaP3J2svV89mCmfCXosG82rP2eQ6FdU2nc5mXurkwUjhE2kMvWaTOFDhnPdiiygTEJSz7+kNQcg5hXCj9Eg8BcRIkLvfo1CSxlHAVUvMBfHpFKWmirUuo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4619.namprd10.prod.outlook.com (2603:10b6:806:11e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Sat, 7 Oct
 2023 01:11:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6838.039; Sat, 7 Oct 2023
 01:11:06 +0000
Date:   Fri, 6 Oct 2023 21:11:02 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        mjguzik@gmail.com, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, peterz@infradead.org, oliver.sang@intel.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
Message-ID: <20231007011102.koplouxuumlog3cu@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230925035617.84767-1-zhangpeng.00@bytedance.com>
 <20230925035617.84767-10-zhangpeng.00@bytedance.com>
 <20231003184634.bbb5c5ezkvi6tkdv@revolver>
 <58ec7a15-6983-d199-bc1a-6161c3b75e0f@bytedance.com>
 <20231004195347.yggeosopqwb6ftos@revolver>
 <785511a6-8636-04e5-c002-907443b34dad@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <785511a6-8636-04e5-c002-907443b34dad@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0048.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA2PR10MB4619:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dcc736d-6a22-4a7e-426e-08dbc6d24860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdFGgvdJ8ci1AZguWg6HQWX96B2WG1dLUjQabk7/bUmc506Igy4/doty0cYASWY7kU2COk1VTXp1dEZJ5EYjMtIKWvaO8eVCLZyQJ6+nFdBAsOSndl3Zeyl8XRMZQs0Q4HgbnXmHqeaKbAS3HEnVh22MyARsi+5RoA/TxWqVzyKLV5+VtWLGoFUkXC8Z88EGBDXmNM/nMAItFzgRv3o4Kuke4UCtL8A/4YavJI5Y8mKAD/PsmtuJbp5gCVJflY8McXw4mDwxMNzyqVr5f9IEZKJiG9P1QB6day6zwbKVBTJtioQjKwGKYNlFAgkjFSbOQFHeQZb5JsbJmGBZ/FusIcob3sWcNo9NAKsHZGG/lE9fOdxdgUz+2c8+qpT86o56GzIDz1bVxBuqfx6ksCWccZWhAETedTdLFCLLNVu3+uWz+g4DDwl9wUSaj+mmDp7XYVzSz+HYU/vW9+QrYn/7AHeIFkGNHOrXj36sZyaB5QBt0n9jx5qtyvu/7BUnyQReHO9myamn6KYLXAJ+if8nddr6s26Q2kkjIC8ZSHiziQL/jxq9BGtiBfsTLf1FHHM0hrKcQRH3Cr4MG+jgKuCJC6nGhoUj7dzfu9G4RPBn9Zk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6512007)(6506007)(478600001)(6486002)(966005)(6666004)(40140700001)(86362001)(38100700002)(2906002)(30864003)(9686003)(7416002)(33716001)(83380400001)(1076003)(26005)(66556008)(316002)(8936002)(66946007)(66476007)(6916009)(5660300002)(41300700001)(8676002)(4326008)(404934003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHgvYmg1OHlRZWV5S1ZnN2VKMWI5aFFzM1V3L1F3YVJvN2cvR2t6bVY0alpJ?=
 =?utf-8?B?aDV2dHpyM3VGRlNhbWJGMjlST2NjbjFkcmxodVZRZm5SM0tIRXRWQ0RUQ2Zz?=
 =?utf-8?B?L3ZjYlBCa2NJZyttTC9kSVl0MkUxdllvZ24wRktNV3NFVmROT3pVb2VCK2dF?=
 =?utf-8?B?d2NCT3ZraEg2c0xvTzZVc0VYemRiczVnVGpCaU5YWEtWZld4RWxSZGFxbGVZ?=
 =?utf-8?B?cHA2VVliaGNCMktRTm1nWFBtQjhwOEFOOXY4YVhjVnJrQXdHTk5WVHdJUFhP?=
 =?utf-8?B?bFhHQ0FvMFduenF6NXBzKzlvU2dDcWhVUTBydU16N3JHY2dwUkdSU2Q3a1ly?=
 =?utf-8?B?SXV4emp2c0Q1NXBTUkFDdG8yM3NSL0lwd1MxNTRTMlh4UzlLU3QxSUpiRkkx?=
 =?utf-8?B?MXo3dGFicmpyWjFGeWNpRWlvYWhxWTFtalNTOGFmbUx4VG95VjBCZit3eHp2?=
 =?utf-8?B?dUhpbmM0TU5UVXQxNWJweXFQcTZ0eFNqZ0JMYmlEQWJ4RVFCTWZySThtcjBq?=
 =?utf-8?B?VEFyUGZVOVBwNENSeHJpUmFUVi92Vk5WeTJ6YlFHYjVETzY1b1FsN3ZXQjhM?=
 =?utf-8?B?K0hoTVR6NEZkNXU1WXJQQXptclRueUlEdmtUU2dZdk56dUc4UG00MFgvZ0Qy?=
 =?utf-8?B?czhJcjIxeW8xbjd1MDdkSVFWNWVhdnhEOVZIN1cxUk5ReVlPTkdTQ0hza010?=
 =?utf-8?B?NnYzb2tOWFVCOVc4WGRaRHFobVQydU03d3NMREFWR2JiUUhmSjdtNTdtc1I5?=
 =?utf-8?B?V3U3T3N5bExEU3lTLzVvdkhvcGhXRHdSZlBRRFJVWDFNS1BTK1ZpeTJzSnZt?=
 =?utf-8?B?dXRyWDYzWU5Eanp4OGlmbHdkZDMyOHFZVDVqdG03UHVxdnpRMG5XWHVNNHEz?=
 =?utf-8?B?QW9Cc1ZTRUJxd256blJiRDI0NndKTHdsc0FIMDEyZnJDTnpHdEMyWTk5VTA0?=
 =?utf-8?B?c1ppbHZDY3FVLzhxVzkyODlXRlV2bHRLbXlGNjlLMU1SVVVacEYxYVV2VmxX?=
 =?utf-8?B?cFhtaUFkYlRQdFpMTkd2NVA4eEx2YXVyYXIxanNqdnYxaEM0N0FscUtaK0JV?=
 =?utf-8?B?bzRzMmR4dXd6WXZELytUVVYrOHl2b3BEZXp6cFFzOExpY3R4WFVyMzBaNzY4?=
 =?utf-8?B?TjlMK0luNXo3MTkwckNkcVZrY0ZleXhUNUZXMGd5WTRoakVLTFJ4RHJndDdp?=
 =?utf-8?B?VUdRclRJM0MrNE5lVXphcWRHSWVDNUtWOURvQW0zSjhMVU5MMWt6MSsyaHBM?=
 =?utf-8?B?SWVsak9VeXZIeHRpNUxTS1NKRlg5bHFkb0dwMjBOSC9zYkJKWko0QWt1Rmgw?=
 =?utf-8?B?UWx6dlNqOXhUbm03ejExWjNMY3FwaGdwam9OQjBTaUtQYk1QMFFLSit3ZFFj?=
 =?utf-8?B?aEQrYVU2TkJLdk9Fc2dOcHdMSGErcThOY2lWU1hxNHJ3US9MUjdkbGVXb3pM?=
 =?utf-8?B?YkxlSUEzWVhtR0k3ejBoSVlGMk9MTHZvQ0hmZHZjazF1Q0p4RXc0UXNFQjRR?=
 =?utf-8?B?MzFWRCs0NnRnTDQzWkl5V01YdEw1TjFyaHlhemVrWlFLeG84b2d2TWZUWnFr?=
 =?utf-8?B?ZHo0QkZ2QmtYVGZJN2ZpMkg2OFFSRDVYYVYvUVlqTEx3eFdZTFBZb2d3dGlV?=
 =?utf-8?B?V0hBblU0MlBVN0hXMDZtbExISU8rQmNjQXdIcGJBWlBHSHNWcGw0UUFGb3dY?=
 =?utf-8?B?SkhoMkF0QVBCc05JOWFsRGtoUk5xK3Z6Vjg1NzIzWCs2MGhqR20xbTVsNG9L?=
 =?utf-8?B?NUF1dkpOVlUzUTJYUng1NTh4aFJIcy80dzlzRHd3Ym5OeENUVGV6b2tUbGk4?=
 =?utf-8?B?Y2NGbnNQTmFmTE1ZQ3hGSGp1RFBCSUp5WFFJMTl6aVRDL2wvYmhybXlja0Fn?=
 =?utf-8?B?RnlWZnhpNjliQmxCckNJOWpjSFVPZktnbXcrT2ZkZmhqSk5VL3dEbW1VNHFz?=
 =?utf-8?B?eGdrVkloN1NaU2QrdEFnTGhmUVhGaXFBeDAreENWcjA5RG11YzRpaVcvTnZD?=
 =?utf-8?B?V1FEMnY1WFNKMUZ2K3BQelVLa2tRMzdWeDFyNGhoYW8xd2FwWlYzQmtseFVY?=
 =?utf-8?B?UEdEQW1vazJjN3lnVTh3S2lFNERvVnkzRnVlUjdValRhYzZacEh6U21rclQx?=
 =?utf-8?Q?KUiZKpfJADDHru+svuILxLlwX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?b1l1WGRxWkhvNTM0aCsxQS9ZUnpINVJQalh3OWN6MlF6SXVJQnd4dG0zRkI4?=
 =?utf-8?B?ZHFBcVBCZVdXWk1rVjBHSm1rMDZKMVBYemtiTWhqeDJUNWR4NGV2UzZGcEJW?=
 =?utf-8?B?d1VCQk8zeFBpeDRqVE9WRXNEYW5XdnpWaCtxSWxMT2N4SWR5MHB3RlJRWW9S?=
 =?utf-8?B?aldiQmFMRXBBbWFKbndFeXY5ZE5EWDBicE9IS1V1OVBia3dwOGhhUzFGSXhm?=
 =?utf-8?B?TFpnMWRBa2JQend4MUpUMzJGaXBON0RCcFh4TXJRK1FuZzE4TGF6RmxzSlRS?=
 =?utf-8?B?K0hLM3JnaW1RY1dsWHIyMCsrVEZMQ3hwdFowU2tkd2RrbndFYW1hanhEaDZn?=
 =?utf-8?B?OEJwVlVETGFmbVV1YmRnZzJUWEJoTE1KSnU3eHN4OHFKVUUzcFhkb0JWNzZQ?=
 =?utf-8?B?VEN0bFNTOWdrSDZUZVNMdm10R3VjdTNTa1lXN2V4VjJNeDdKR29HSnA0ZENN?=
 =?utf-8?B?M3hvUU5nM3hEOWliM1dTaEx1YjVTKzNJbzNTeGt0Rm93UGFDaU5vYktZcUZZ?=
 =?utf-8?B?WVRTQzZUMi9heUFGZEtoU2I5dFdnSzRMaUQ5ZFN1QnFuY2lwcDZ0dlRzcVBn?=
 =?utf-8?B?MDdQYU1sNWFBM0pITm1PdmpqR3dzVG8xNSt0Y2o4S0ZkMGZ1M3BndHZYbkVa?=
 =?utf-8?B?OXd6MVVYZjZKcFZEdUpYRlBpNW4yRjUzZ2JkTGRoR0UybGpZVWhqdFNOR3Bk?=
 =?utf-8?B?R1RmNXZrcjJOQzJuQXJXaE40UHZ2Z0JJbUFHMVZmM0QycWtoVUQ5eS9nTTBq?=
 =?utf-8?B?aEQzQkpNRGRrUmRyQWpPSDdXQWhKV3JSSThPaGwzWU1LMnd5YVQxTXBSSGxR?=
 =?utf-8?B?TmY5eHJISEJXWEJqSE1NM01CWmhYRTNFTktka0xyQWxwaXdTTmY2SDErWXBV?=
 =?utf-8?B?TVZPd05ZelB6YkJSNVBKV1dXcEFZaXNoSEh6UnFPMmVqeEpHZmU3WWpUMERs?=
 =?utf-8?B?aTNwbjhISFFVcEZ5cm92UktQRjVaMjYvcWRrM3V0NFRNY0VkL0tSU0U4ZDlS?=
 =?utf-8?B?bW5melF4K1lwZUUzOFNvZ0xnQW4zUzFpZU8vV3MyWm03TkRKbzZEcVcxZk9I?=
 =?utf-8?B?eXFTNStSb3czNUZVNUU0b0RBNUlHeUV2aFliZ3gyaDF4ZkoyUmRJWCtzcHZu?=
 =?utf-8?B?S3h6aThzalBIeFdobTVjREY0amw2bHk2bjNQY3l6dTVHb2M4S2RLYmZUcHZy?=
 =?utf-8?B?dTR3TnJxZGtMd21LczQxSDVxa0l3eHZMZ0laeW5QeTY2RGlsUlpYSU9aWS9j?=
 =?utf-8?B?UzRXbHgzWmdpaWdLVC9kWFZLYkV4SE1YUm03TVVkdk1wWXRlbGN3NC9oWDFh?=
 =?utf-8?B?NTJrbUc3aE9KT0JLRWJraXEzVk9KaktSR0lTUHR6b0FUdWJ6M1JaakZJUkNM?=
 =?utf-8?B?OWFzeGtidkkyQVc1YjFxejNsa0poOTQyUUp4S2UzMjJuNVFwQUJVT1o0eDc1?=
 =?utf-8?B?ODlhcjJ6QlBOYTlQZzdxUmVFT1VTZHpIUlZZdXlCUUljU1ZsNElCSHY2SFBH?=
 =?utf-8?Q?fbJUDhTPSRHQmuUhYD04WPmGukY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcc736d-6a22-4a7e-426e-08dbc6d24860
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 01:11:06.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlAfcm8Gmpf+5SMbLjWMLY628Rfkr9ym4mRhhOLymv5dYcAcTOET7HjeSaztGtSf1Q9tOVW6sqds5OmseRl1/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_15,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310070008
X-Proofpoint-GUID: n7mAteawbDAEneTQIxY-O_wLYv4f3hFl
X-Proofpoint-ORIG-GUID: n7mAteawbDAEneTQIxY-O_wLYv4f3hFl
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [231005 11:56]:
>=20
>=20
> =E5=9C=A8 2023/10/5 03:53, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [231004 05:10]:
> > >=20
> > >=20
> > > =E5=9C=A8 2023/10/4 02:46, Liam R. Howlett =E5=86=99=E9=81=93:
> > > > * Peng Zhang <zhangpeng.00@bytedance.com> [230924 23:58]:
> > > > > In dup_mmap(), using __mt_dup() to duplicate the old maple tree a=
nd then
> > > > > directly replacing the entries of VMAs in the new maple tree can =
result
> > > > > in better performance. __mt_dup() uses DFS pre-order to duplicate=
 the
> > > > > maple tree, so it is very efficient. The average time complexity =
of
> > > > > duplicating VMAs is reduced from O(n * log(n)) to O(n). The optim=
ization
> > > > > effect is proportional to the number of VMAs.
> > > >=20
> > > > I am not confident in the big O calculations here.  Although the ad=
dition
> > > > of the tree is reduced, adding a VMA still needs to create the node=
s
> > > > above it - which are a function of n.  How did you get O(n * log(n)=
) for
> > > > the existing fork?
> > > >=20
> > > > I would think your new algorithm is n * log(n/16), while the
> > > > previous was n * log(n/16) * f(n).  Where f(n) would be something
> > > > to do with the decision to split/rebalance in bulk insert mode.
> > > >=20
> > > > It's certainly a better algorithm to duplicate trees, but I don't t=
hink
> > > > it is O(n).  Can you please explain?
> > >=20
> > > The following is a non-professional analysis of the algorithm.
> > >=20
> > > Let's first analyze the average time complexity of the new algorithm,=
 as
> > > it is relatively easy to analyze. The maximum number of branches for
> > > internal nodes in a maple tree in allocation mode is 10. However, to
> > > simplify the analysis, we will not consider this case and assume that
> > > all nodes have a maximum of 16 branches.
> > >=20
> > > The new algorithm assumes that there is no case where a VMA with the
> > > VM_DONTCOPY flag is deleted. If such a case exists, this analysis can=
not
> > > be applied.
> > >=20
> > > The operations of the new algorithm consist of three parts:
> > >=20
> > > 1. DFS traversal of each node in the source tree
> > > 2. For each node in the source tree, create a copy and construct a ne=
w
> > >     node
> > > 3. Traverse the new tree using mas_find() and replace each element
> > >=20
> > > If there are a total of n elements in the maple tree, we can conclude
> > > that there are n/16 leaf nodes. Regarding the second-to-last level, w=
e
> > > can conclude that there are n/16^2 nodes. The total number of nodes i=
n
> > > the entire tree is given by the sum of n/16 + n/16^2 + n/16^3 + ... +=
 1.
> > > This is a geometric progression with a total of log base 16 of n term=
s.
> > > According to the formula for the sum of a geometric progression, the =
sum
> > > is (n-1)/15. So, this tree has a total of (n-1)/15 nodes and
> > > (n-1)/15 - 1 edges.
> > >=20
> > > For the operations in the first part of this algorithm, since DFS
> > > traverses each edge twice, the time complexity would be
> > > 2*((n-1)/15 - 1).
> > >=20
> > > For the second part, each operation involves copying a node and makin=
g
> > > necessary modifications. Therefore, the time complexity is
> > > 16*(n-1)/15.
> > >=20
> > > For the third part, we use mas_find() to traverse and replace each
> > > element, which is essentially similar to the combination of the first
> > > and second parts. mas_find() traverses all nodes and within each node=
,
> > > it iterates over all elements and performs replacements. The time
> > > complexity of traversing the nodes is 2*((n-1)/15 - 1), and for all
> > > nodes, the time complexity of replacing all their elements is
> > > 16*(n-1)/15.
> > >=20
> > > By ignoring all constant factors, each of the three parts of the
> > > algorithm has a time complexity of O(n). Therefore, this new algorith=
m
> > > is O(n).
> >=20
> > Thanks for the detailed analysis!  I didn't mean to cause so much work
> > with this question.  I wanted to know so that future work could rely on
> > this calculation to demonstrate if it is worth implementing without
> > going through the effort of coding and benchmarking - after all, this
> > commit message will most likely be examined during that process.
> >=20
> > I asked because O(n) vs O(n*log(n)) doesn't seem to fit with your
> > benchmarking.
> It may not be well reflected in the benchmarking of fork() because all
> the aforementioned time complexity analysis is related to the part
> involving the maple tree, specifically the time complexity of
> constructing a new maple tree. However, fork() also includes many other
> behaviors.

The forking is allocating VMAs, etc but all a 1-1 mapping per VMA so it
should be linear, if not near-linear.  There is some setup time involved
with the mm struct too, but that should become less as more VMAs are
added per fork.

> >=20
> > >=20
> > > The exact time complexity of the old algorithm is difficult to analyz=
e.
> > > I can only provide an upper bound estimation. There are two possible
> > > scenarios for each insertion:
> > >=20
> > > 1. Appending at the end of a node.
> > > 2. Splitting nodes multiple times.
> > >=20
> > > For the first scenario, the individual operation has a time complexit=
y
> > > of O(1). As for the second scenario, it involves node splitting. The
> > > challenge lies in determining which insertions trigger splits and how
> > > many splits occur each time, which is difficult to calculate. In the
> > > worst-case scenario, each insertion requires splitting the tree's hei=
ght
> > > log(n) times. Assuming every insertion is in the worst-case scenario,
> > > the time complexity would be n*log(n). However, not every insertion
> > > requires splitting, and the number of splits each time may not
> > > necessarily be log(n). Therefore, this is an estimation of the upper
> > > bound.
> >=20
> > Saying every insert causes a split and adding in n*log(n) is more than
> > an over estimation.  At worst there is some n + n/16 * log(n) going on
> > there.
> >=20
> > During the building of a tree, we are in bulk insert mode.  This favour=
s
> > balancing the tree to the left to maximize the number of inserts being
> > append operations.  The algorithm inserts as many to the left as we can
> > leaving the minimum number on the right.
> >=20
> > We also reduce the number of splits by pushing data to the left wheneve=
r
> > possible, at every level.
> Yes, but I don't think pushing data would occur when inserting in
> ascending order in bulk mode because the left nodes are all full, while
> there are no nodes on the right side. However, I'm not entirely certain
> about this since I only briefly looked at the implementation of this
> part.

They are not full, the right node has enough entries to have a
sufficient node, so the left node will have that many spaces for push.
mab_calc_split():
        if (unlikely((mas->mas_flags & MA_STATE_BULK))) {                  =
                                            =20
                *mid_split =3D 0;=20
                split =3D b_end - mt_min_slots[bn->type];

> >=20
> >=20
> > > >=20
> > > > >=20
> > > > > As the entire maple tree is duplicated using __mt_dup(), if dup_m=
map()
> > > > > fails, there will be a portion of VMAs that have not been duplica=
ted in
> > > > > the maple tree. This makes it impossible to unmap all VMAs in exi=
t_mmap().
> > > > > To solve this problem, undo_dup_mmap() is introduced to handle th=
e failure
> > > > > of dup_mmap(). I have carefully tested the failure path and so fa=
r it
> > > > > seems there are no issues.
> > > > >=20
> > > > > There is a "spawn" in byte-unixbench[1], which can be used to tes=
t the
> > > > > performance of fork(). I modified it slightly to make it work wit=
h
> > > > > different number of VMAs.
> > > > >=20
> > > > > Below are the test results. By default, there are 21 VMAs. The fi=
rst row
> > > > > shows the number of additional VMAs added on top of the default. =
The last
> > > > > two rows show the number of fork() calls per ten seconds. The tes=
t results
> > > > > were obtained with CPU binding to avoid scheduler load balancing =
that
> > > > > could cause unstable results. There are still some fluctuations i=
n the
> > > > > test results, but at least they are better than the original perf=
ormance.
> > > > >=20
> > > > > Increment of VMAs: 0      100     200     400     800     1600   =
 3200    6400
> > > > > next-20230921:     112326 75469   54529   34619   20750   11355  =
 6115    3183
> > > > > Apply this:        116505 85971   67121   46080   29722   16665  =
 9050    4805
> > > > >                      +3.72% +13.92% +23.09% +33.11% +43.24% +46.7=
6% +48.00% +50.96%
> >               delta       4179   10502   12592   11461    8972    5310 =
  2935    1622
> >=20
> > Looking at this data, it is difficult to see what is going on because
> > there is a doubling of the VMAs per fork per column while the count is
> > forks per 10 seconds.  So this table is really a logarithmic table with
> > increases growing by 10%.  Adding the delta row makes it seem like the
> > number are not growing apart as I would expect.
> >=20
> > If we normalize this to VMAs per second by dividing the forks by 10,
> > then multiplying by the number of VMAs we get this:
> >=20
> > VMA Count:           21       121       221       421       821      16=
21       3221      6421
> > log(VMA)           1.32      2.00      2.30      2.60      2.90      3.=
20       3.36      3.81
> > next-20230921: 258349.8  928268.7 1215996.7 1464383.7 1707725.0 1842916=
.5  1420514.5 2044440.9
> > this:          267961.5 1057443.3 1496798.3 1949184.0 2446120.6 2704729=
.5  2102315.0 3086251.5
> > delta            9611.7  129174.6  280801.6  484800.3  738395.6  861813=
.0   681800.5 1041810.6
> >=20
> > The first thing that I noticed was that we hit some dip in the numbers
> > at 3221.  I first thought that might be something else running on the
> > host machine, but both runs are affected by around the same percent.
> >=20
> > Here, we do see the delta growing apart, but peaking in growth around
> > 821 VMAs.  Again that 3221 number is out of line.
> >=20
> > If we discard 21 and anything above 1621, we still see both lines are
> > asymptotic curves.  I would expect that the new algorithm would be more
> > linear to represent O(n), but there is certainly a curve when graphed
> > with a normalized X-axis.  The older algorithm, O(n*log(n)) should be
> > the opposite curve all together, and with a diminishing return, but it
> > seems the more elements we have, the more operations we can perform in =
a
> > second.
> Thank you for your detailed analysis.
>=20
> So, are you expecting the transformed data to be close to a constant
> value?

I would expect it to increase linearly, but it's a curve.  Also, it
seems that both methods are near the identical curve, including the dip
at 3221.  I expect the new method to have a different curve, especially
at the higher numbers where the fork() overhead is much less, but it
seems they both curve asymptotically.  That is, they seen to be the same
complexity related to n, but with different constants.

> Please note that besides constructing a new maple tree, there are many
> other operations in fork(). As the number of VMAs increases, the number
> of fork() calls decreases. Therefore, the overall cost spent on other
> operations becomes smaller, while the cost spent on duplicating VMAs
> increases. That's why this data grows with the increase of VMAs. I
> speculate that if the number of VMAs is large enough to neglect the time
> spent on other operations in fork(), this data will approach a constant
> value.

If it were the other parts of fork() causing the non-linear growth, then
I would expect 800 -> 1600 to increase to +53% instead of +46%, and if
we were hitting the limit of fork affecting the data, then I would
expect the delta of VMAs/second to not be so high at the upper 6421 -
both algorithms have more room to get more performance at least until
6421 VMAs/fork.

>=20
> If we want to achieve the expected curve, I think we should simulate the
> process of constructing the maple tree in user space to avoid the impact
> of other operations in fork(), just like in the current bench_forking().
> >=20
> > Thinking about what is going on here, I cannot come up with a reason
> > that there would be a curve to the line at all.  If we took more
> > measurements, I would think the samples would be an ever-increasing lin=
e
> > with variability for some function of 16 - a saw toothed increasing
> > line. At least, until an upper limit is reached.  We can see that the
> > upper limit was still not achieved at 1621 since 6421 is higher for bot=
h
> > runs, but a curve is evident on both methods, which suggests something
> > else is a significant contributor.
> >=20
> > I would think each VMA requires the same amount of work, so a constant.
> > The allocations would again, be some function that would linearly
> > increase with the existing method over-estimating by a huge number of
> > nodes.
> >=20
> > I'm not trying to nitpick here, but it is important to be accurate in
> > the statements because it may alter choices on how to proceed in
> > improving this performance later.  It may be others looking through
> > these commit messages to see if something can be improved.
> Thank you for pointing that out. I will try to describe it more
> accurately in the commit log and see if I can measure the expected curve
> in user space.
> >=20
> > I also feel like your notes on your algorithm are worth including in th=
e
> > commit because it could prove rather valuable if we revisit forking in
> > the future.
> Do you mean that I should write the analysis of the time complexity of
> the new algorithm in the commit log?

Yes, I think it's worth capturing.  What do you think?

> >=20
> > The more I look at this, the more questions I have that I cannot answer=
.
> > One thing we can see is that the new method is faster in this
> > micro-benchmark.
> Yes. It should be noted that in the field of computer science, if the
> test results don't align with the expected mathematical calculations,
> it indicates an error in the calculations. This is because accurate
> calculations will always be reflected in the test results. =F0=9F=98=82
> >=20
> > > > >=20
> > > > > [1] https://github.com/kdlucas/byte-unixbench/tree/master
> > > > >=20
> > > > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > > > ---
> > > > >    include/linux/mm.h |  1 +
> > > > >    kernel/fork.c      | 34 ++++++++++++++++++++----------
> > > > >    mm/internal.h      |  3 ++-
> > > > >    mm/memory.c        |  7 ++++---
> > > > >    mm/mmap.c          | 52 ++++++++++++++++++++++++++++++++++++++=
++++++--
> > > > >    5 files changed, 80 insertions(+), 17 deletions(-)
> > > > >=20
> > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > index 1f1d0d6b8f20..10c59dc7ffaa 100644
> > > > > --- a/include/linux/mm.h
> > > > > +++ b/include/linux/mm.h
> > > > > @@ -3242,6 +3242,7 @@ extern void unlink_file_vma(struct vm_area_=
struct *);
> > > > >    extern struct vm_area_struct *copy_vma(struct vm_area_struct *=
*,
> > > > >    	unsigned long addr, unsigned long len, pgoff_t pgoff,
> > > > >    	bool *need_rmap_locks);
> > > > > +extern void undo_dup_mmap(struct mm_struct *mm, struct vm_area_s=
truct *vma_end);
> > > > >    extern void exit_mmap(struct mm_struct *);
> > > > >    static inline int check_data_rlimit(unsigned long rlim,
> > > > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > > > index 7ae36c2e7290..2f3d83e89fe6 100644
> > > > > --- a/kernel/fork.c
> > > > > +++ b/kernel/fork.c
> > > > > @@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct m=
m_struct *mm,
> > > > >    	int retval;
> > > > >    	unsigned long charge =3D 0;
> > > > >    	LIST_HEAD(uf);
> > > > > -	VMA_ITERATOR(old_vmi, oldmm, 0);
> > > > >    	VMA_ITERATOR(vmi, mm, 0);
> > > > >    	uprobe_start_dup_mmap();
> > > > > @@ -678,16 +677,25 @@ static __latent_entropy int dup_mmap(struct=
 mm_struct *mm,
> > > > >    		goto out;
> > > > >    	khugepaged_fork(mm, oldmm);
> > > > > -	retval =3D vma_iter_bulk_alloc(&vmi, oldmm->map_count);
> > > > > -	if (retval)
> > > > > +	/* Use __mt_dup() to efficiently build an identical maple tree.=
 */
> > > > > +	retval =3D __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
> > > > > +	if (unlikely(retval))
> > > > >    		goto out;
> > > > >    	mt_clear_in_rcu(vmi.mas.tree);
> > > > > -	for_each_vma(old_vmi, mpnt) {
> > > > > +	for_each_vma(vmi, mpnt) {
> > > > >    		struct file *file;
> > > > >    		vma_start_write(mpnt);
> > > > >    		if (mpnt->vm_flags & VM_DONTCOPY) {
> > > > > +			mas_store_gfp(&vmi.mas, NULL, GFP_KERNEL);
> > > > > +
> > > > > +			/* If failed, undo all completed duplications. */
> > > > > +			if (unlikely(mas_is_err(&vmi.mas))) {
> > > > > +				retval =3D xa_err(vmi.mas.node);
> > > > > +				goto loop_out;
> > > > > +			}
> > > > > +
> > > > >    			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
> > > > >    			continue;
> > > > >    		}
> > > > > @@ -749,9 +757,11 @@ static __latent_entropy int dup_mmap(struct =
mm_struct *mm,
> > > > >    		if (is_vm_hugetlb_page(tmp))
> > > > >    			hugetlb_dup_vma_private(tmp);
> > > > > -		/* Link the vma into the MT */
> > > > > -		if (vma_iter_bulk_store(&vmi, tmp))
> > > > > -			goto fail_nomem_vmi_store;
> > > > > +		/*
> > > > > +		 * Link the vma into the MT. After using __mt_dup(), memory
> > > > > +		 * allocation is not necessary here, so it cannot fail.
> > > > > +		 */
> > > > > +		mas_store(&vmi.mas, tmp);
> > > > >    		mm->map_count++;
> > > > >    		if (!(tmp->vm_flags & VM_WIPEONFORK))
> > > > > @@ -760,15 +770,19 @@ static __latent_entropy int dup_mmap(struct=
 mm_struct *mm,
> > > > >    		if (tmp->vm_ops && tmp->vm_ops->open)
> > > > >    			tmp->vm_ops->open(tmp);
> > > > > -		if (retval)
> > > > > +		if (retval) {
> > > > > +			mpnt =3D vma_next(&vmi);
> > > > >    			goto loop_out;
> > > > > +		}
> > > > >    	}
> > > > >    	/* a new mm has just been created */
> > > > >    	retval =3D arch_dup_mmap(oldmm, mm);
> > > > >    loop_out:
> > > > >    	vma_iter_free(&vmi);
> > > > > -	if (!retval)
> > > > > +	if (likely(!retval))
> > > > >    		mt_set_in_rcu(vmi.mas.tree);
> > > > > +	else
> > > > > +		undo_dup_mmap(mm, mpnt);
> > > > >    out:
> > > > >    	mmap_write_unlock(mm);
> > > > >    	flush_tlb_mm(oldmm);
> > > > > @@ -778,8 +792,6 @@ static __latent_entropy int dup_mmap(struct m=
m_struct *mm,
> > > > >    	uprobe_end_dup_mmap();
> > > > >    	return retval;
> > > > > -fail_nomem_vmi_store:
> > > > > -	unlink_anon_vmas(tmp);
> > > > >    fail_nomem_anon_vma_fork:
> > > > >    	mpol_put(vma_policy(tmp));
> > > > >    fail_nomem_policy:
> > > > > diff --git a/mm/internal.h b/mm/internal.h
> > > > > index 7a961d12b088..288ec81770cb 100644
> > > > > --- a/mm/internal.h
> > > > > +++ b/mm/internal.h
> > > > > @@ -111,7 +111,8 @@ void folio_activate(struct folio *folio);
> > > > >    void free_pgtables(struct mmu_gather *tlb, struct ma_state *ma=
s,
> > > > >    		   struct vm_area_struct *start_vma, unsigned long floor,
> > > > > -		   unsigned long ceiling, bool mm_wr_locked);
> > > > > +		   unsigned long ceiling, unsigned long tree_end,
> > > > > +		   bool mm_wr_locked);
> > > > >    void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *=
pte);
> > > > >    struct zap_details;
> > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > index 983a40f8ee62..1fd66a0d5838 100644
> > > > > --- a/mm/memory.c
> > > > > +++ b/mm/memory.c
> > > > > @@ -362,7 +362,8 @@ void free_pgd_range(struct mmu_gather *tlb,
> > > > >    void free_pgtables(struct mmu_gather *tlb, struct ma_state *ma=
s,
> > > > >    		   struct vm_area_struct *vma, unsigned long floor,
> > > > > -		   unsigned long ceiling, bool mm_wr_locked)
> > > > > +		   unsigned long ceiling, unsigned long tree_end,
> > > > > +		   bool mm_wr_locked)
> > > > >    {
> > > > >    	do {
> > > > >    		unsigned long addr =3D vma->vm_start;
> > > > > @@ -372,7 +373,7 @@ void free_pgtables(struct mmu_gather *tlb, st=
ruct ma_state *mas,
> > > > >    		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and =
may
> > > > >    		 * be 0.  This will underflow and is okay.
> > > > >    		 */
> > > > > -		next =3D mas_find(mas, ceiling - 1);
> > > > > +		next =3D mas_find(mas, tree_end - 1);
> > > > >    		/*
> > > > >    		 * Hide vma from rmap and truncate_pagecache before freeing
> > > > > @@ -393,7 +394,7 @@ void free_pgtables(struct mmu_gather *tlb, st=
ruct ma_state *mas,
> > > > >    			while (next && next->vm_start <=3D vma->vm_end + PMD_SIZE
> > > > >    			       && !is_vm_hugetlb_page(next)) {
> > > > >    				vma =3D next;
> > > > > -				next =3D mas_find(mas, ceiling - 1);
> > > > > +				next =3D mas_find(mas, tree_end - 1);
> > > > >    				if (mm_wr_locked)
> > > > >    					vma_start_write(vma);
> > > > >    				unlink_anon_vmas(vma);
> > > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > > index 2ad950f773e4..daed3b423124 100644
> > > > > --- a/mm/mmap.c
> > > > > +++ b/mm/mmap.c
> > > > > @@ -2312,7 +2312,7 @@ static void unmap_region(struct mm_struct *=
mm, struct ma_state *mas,
> > > > >    	mas_set(mas, mt_start);
> > > > >    	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USE=
R_ADDRESS,
> > > > >    				 next ? next->vm_start : USER_PGTABLES_CEILING,
> > > > > -				 mm_wr_locked);
> > > > > +				 tree_end, mm_wr_locked);
> > > > >    	tlb_finish_mmu(&tlb);
> > > > >    }
> > > > > @@ -3178,6 +3178,54 @@ int vm_brk(unsigned long addr, unsigned lo=
ng len)
> > > > >    }
> > > > >    EXPORT_SYMBOL(vm_brk);
> > > > > +void undo_dup_mmap(struct mm_struct *mm, struct vm_area_struct *=
vma_end)
> > > > > +{
> > > > > +	unsigned long tree_end;
> > > > > +	VMA_ITERATOR(vmi, mm, 0);
> > > > > +	struct vm_area_struct *vma;
> > > > > +	unsigned long nr_accounted =3D 0;
> > > > > +	int count =3D 0;
> > > > > +
> > > > > +	/*
> > > > > +	 * vma_end points to the first VMA that has not been duplicated=
. We need
> > > > > +	 * to unmap all VMAs before it.
> > > > > +	 * If vma_end is NULL, it means that all VMAs in the maple tree=
 have
> > > > > +	 * been duplicated, so setting tree_end to 0 will overflow to U=
LONG_MAX
> > > > > +	 * when using it.
> > > > > +	 */
> > > > > +	if (vma_end) {
> > > > > +		tree_end =3D vma_end->vm_start;
> > > > > +		if (tree_end =3D=3D 0)
> > > > > +			goto destroy;
> > > > > +	} else
> > > > > +		tree_end =3D 0;

You need to enclose this statement to meet the coding style.  You could
just set tree_end =3D 0 at the start of the function instead, actually I
think tree_end =3D USER_PGTABLES_CEILING unless there is a vma_end.

> > > > > +
> > > > > +	vma =3D mas_find(&vmi.mas, tree_end - 1);

vma =3D vma_find(&vmi, tree_end);

> > > > > +
> > > > > +	if (vma) {

Probably would be cleaner to jump to destroy here too:
if (!vma)
	goto destroy;

> > > > > +		arch_unmap(mm, vma->vm_start, tree_end);
> > > > > +		unmap_region(mm, &vmi.mas, vma, NULL, NULL, 0, tree_end,
> > > > > +			     tree_end, true);
> > > >=20
> > > > next is vma_end, as per your comment above.  Using next =3D vma_end=
 allows
> > > > you to avoid adding another argument to free_pgtables().
> > > Unfortunately, it cannot be done this way. I fell into this trap befo=
re,
> > > and it caused incomplete page table cleanup. To solve this problem, t=
he
> > > only solution I can think of right now is to add an additional
> > > parameter.
> > >=20
> > > free_pgtables() will be called in unmap_region() to free the page tab=
le,
> > > like this:
> > >=20
> > > free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRES=
S,
> > > 		next ? next->vm_start : USER_PGTABLES_CEILING,
> > > 		mm_wr_locked);
> > >=20
> > > The problem is with 'next'. Our 'vma_end' does not exist in the actua=
l
> > > mmap because it has not been duplicated and cannot be used as 'next'.
> > > If there is a real 'next', we can use 'next->vm_start' as the ceiling=
,
> > > which is not a problem. If there is no 'next' (next is 'vma_end'), we
> > > can only use 'USER_PGTABLES_CEILING' as the ceiling. Using
> > > 'vma_end->vm_start' as the ceiling will cause the page table not to b=
e
> > > fully freed, which may be related to alignment in 'free_pgd_range()'.=
 To
> > > solve this problem, we have to introduce 'tree_end', and separating
> > > 'tree_end' and 'ceiling' can solve this problem.
> >=20
> > Can you just use ceiling?  That is, just not pass in next and keep the
> > code as-is?  This is how exit_mmap() does it and should avoid any
> > alignment issues.  I assume you tried that and something went wrong as
> > well?
> I tried that, but it didn't work either. In free_pgtables(), the
> following line of code is used to iterate over VMAs:
> mas_find(mas, ceiling - 1);
> If next is passed as NULL, ceiling will be 0, resulting in iterating
> over all the VMAs in the maple tree, including the last portion that was
> not duplicated.

If vma_end is NULL, it means that all VMAs in the maple tree have been
duplicated, so shouldn't the correct action in this case be freeing up
to ceiling?

If it isn't null, then vma_end->vm_start should work as the end of the
area to free.

With your mas_find(mas, tree_end - 1), then the vma_end will be avoided,
but free_pgd_range() will use ceiling anyways:

free_pgd_range(tlb, addr, vma->vm_end, floor, next ? next->vm_start : ceili=
ng);

Passing in vma_end as next to unmap_region() functions in my testing
without adding arguments to free_pgtables().

How are you producing the accounting issue you mention above?  Maybe I
missed something?


> >=20
> > >=20
> > > >=20
> > > > > +
> > > > > +		mas_set(&vmi.mas, vma->vm_end);
vma_iter_set(&vmi, vma->vm_end);
> > > > > +		do {
> > > > > +			if (vma->vm_flags & VM_ACCOUNT)
> > > > > +				nr_accounted +=3D vma_pages(vma);
> > > > > +			remove_vma(vma, true);
> > > > > +			count++;
> > > > > +			cond_resched();
> > > > > +			vma =3D mas_find(&vmi.mas, tree_end - 1);
> > > > > +		} while (vma !=3D NULL);

You can write this as:
do { ... } for_each_vma_range(vmi, vma, tree_end);

> > > > > +
> > > > > +		BUG_ON(count !=3D mm->map_count);
> > > > > +
> > > > > +		vm_unacct_memory(nr_accounted);
> > > > > +	}
> > > > > +
> > > > > +destroy:
> > > > > +	__mt_destroy(&mm->mm_mt);
> > > > > +}
> > > > > +
> > > > >    /* Release all mmaps. */
> > > > >    void exit_mmap(struct mm_struct *mm)
> > > > >    {
> > > > > @@ -3217,7 +3265,7 @@ void exit_mmap(struct mm_struct *mm)
> > > > >    	mt_clear_in_rcu(&mm->mm_mt);
> > > > >    	mas_set(&mas, vma->vm_end);
> > > > >    	free_pgtables(&tlb, &mas, vma, FIRST_USER_ADDRESS,
> > > > > -		      USER_PGTABLES_CEILING, true);
> > > > > +		      USER_PGTABLES_CEILING, USER_PGTABLES_CEILING, true);
> > > > >    	tlb_finish_mmu(&tlb);
> > > > >    	/*
> > > > > --=20
> > > > > 2.20.1
> > > > >=20
> > > >=20
> > >=20
> >=20
