Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A9A7B8DB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243958AbjJDTy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 15:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243903AbjJDTy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:54:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307ECA6;
        Wed,  4 Oct 2023 12:54:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394FIxBP027960;
        Wed, 4 Oct 2023 19:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=BWDU7ZgabFD+sSPafmrX3CLQegtRTKDu4hNqt69EGK4=;
 b=GST+tP5I361+RlyfuRwYaUROxddWzqYxHPgvGggIQqkjn1+eXvSONaDw3K0C+jPb8JsG
 8HA6MdXfAx6SPandIL1uzgAmq+r+e0ekuhAxojOFKWCwxvirvQC9ajiTzaifv+8QXGIz
 2zRvLg+FCuOOKMYUCjW2J2TLRBw6UJnQQ66BdBhRcmwo/Mog/gvtYpBKpaZnJPtDyNnc
 zHf5ch4iv7lJ+YH3xskxNdI4zytmRjCOtNYAdj0KszZ5f52T273N6d3YyF5MSvTmEUvq
 MP2XG8OxhBKdiZnTqh+K7B+6oUfhe0HsUunE4ewT7cUPhVRtbub8hTlZjiGLVT1L2QuZ tA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebjbyudg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 19:53:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394JrH3t008791;
        Wed, 4 Oct 2023 19:53:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea48kqkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 19:53:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaxnFYRnvscERxPdHW5zSq4QfKPlNNpp48IIloHyySiNMgn9Qubvs62rm2mR0C5iak2oCE+sFLxZhd3ZO+phyHcNOdfr65Fc/4cf/xNfA6/ctBRA+in47egv27pJcxZEsjU8yaeqt61Q3QeSthdicMaAzGN5RrMVIr9BQ+2wPDbPo/2tpfNQctrnmU7YTY9oTtFH3diol2SKB2XLH5kdrnrfR2U/JrWYrLd/vJZCR8qEXY+zu/pFd0rLMNu1Zi5b8+0UUjcL0X9tI/p3P8lJGamHySrSULLnGC2+Nf+AlB3JKibNQxssGgCX3jD6Oq1jAkWi2sxPpV4hOKsPRfK8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWDU7ZgabFD+sSPafmrX3CLQegtRTKDu4hNqt69EGK4=;
 b=H8Ue8S8B8r6k3Zmtjt7EMqBwCg9un7etbdyi99fiz+dCn6pJwEA3Wva7jzfECVWU0tvVq/cYO4rqnhlxEn3NQZM1UKzut9Hd+qjw4mcqoPGkQVKwm0Hay+o9lBw7boqz+9WCn6i0JhHoF5PpVB4g3VSeE6Zznuz+7+403IM0B4aIfEBiY97t/DI3m/jR19+09o8/0yla5EFdwEIG6GiHMboqkK59OVVl0NqzSmlNxsTGH265Q6sPpzjy8V5aTxk0erpB/mGjlYtCbb6IiUrxaWmmFX6dgEL31CGGIfjRtUnngpzWHBQ0ThFtcPh6unROOQwE4F5LoVYhxguyMwRHhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWDU7ZgabFD+sSPafmrX3CLQegtRTKDu4hNqt69EGK4=;
 b=CiPmbIj1Dw7tFzb+XJn9JUjuV18sstNYWMAZY2B32vP3PE6T1rebHkU/WVNBQHQ2Uq19r7UhkWQ6XEUp18iF6jsnZp5zqODPa/j6rMSTAoIkpDeO+VnCXfG3idDwhu0PslaqIK/lSYGOO9/M+DFXJklHXbdS4kPkqVOKDOtCldM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6621.namprd10.prod.outlook.com (2603:10b6:510:223::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Wed, 4 Oct
 2023 19:53:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 19:53:51 +0000
Date:   Wed, 4 Oct 2023 15:53:47 -0400
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
Message-ID: <20231004195347.yggeosopqwb6ftos@revolver>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <58ec7a15-6983-d199-bc1a-6161c3b75e0f@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0383.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH8PR10MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 29477a66-a176-46c0-02b6-08dbc513a172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0lWqohXn8rj4IoVkk5m8HzAhrwtlw1VDXjVHFQTpGzCqnSuCIn3QTgrTn/Fsxdd+rm8Cil+HhUfiDTjrVwapTftpcZTaoQUoKXhHvnNkmHXJ5irRju5DY/h/m8m1rAUJcuz9FWEHjhHKq3Ce2pRDoBZktEPxwy7UvDxNdkqub5zbB3+pT+LxV9QO8NCpNu4PBSIMUTK2wm6wK2SimjJIthC2xhEVE97OQm51sQofF/0e00BxDpmohigKcjeLvNOQBF+PzSQoC4EBS7yLQrVJ4FvRaW3v81i39AamAsBzA88rUZjazyQksf8r/puaJKXJXZj8b1UpCYcLqmlAhIHRb/B3Xh1PbVpoEabDJaeCb1cDjQAMBl5h0VYVaR8/OFfg4sDm5wfnQn7If5aQ+PGrx+8Az7j9yPxXD83jFVjhtGu8eZptkZFFlKYpOB2Z4SgNQNHqkjpJTHGKGfmrn6qUPbp5M9/tjPoFar0JVidauXh4sms7A5Nko0EiFV8wuWG3zN3UXZFcfcliTbzcYu2GID7LJOpK+N54YGPwYNga7GEYANIT8/TKr8lZOyn5t8RXDV/7gwlP/4qKp4GrIdzTH7q1K/SjvT4izTS/V7BreU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(30864003)(26005)(2906002)(4326008)(5660300002)(66946007)(8676002)(6916009)(41300700001)(66476007)(66556008)(8936002)(6486002)(9686003)(478600001)(966005)(6666004)(6506007)(7416002)(6512007)(33716001)(316002)(1076003)(83380400001)(38100700002)(40140700001)(86362001)(404934003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjQwdDQ3NWN0ak9OdGpPL1FEN05tK2ZNQUM4bGJCa1pYNGdkZzc4Rk11Sy9B?=
 =?utf-8?B?aDJwOWYxbStHOGdVWWdHWnc1NlVYbGl1RnZEM2Y2ODhPb3ViRzFFMDZNbDdr?=
 =?utf-8?B?Y3dpREU2K1NlOENzVlJDWUdiL0JQQ0w4QjBlTm13QktrVmozNmkzUHVZajFh?=
 =?utf-8?B?ZXVhTkdDdmJNVGt6TjZWajcvdEdjY2NmZUsyNzVQaEFVWkxUVDB2cjBoaUt0?=
 =?utf-8?B?RjlaNFBoc0ZnWHVmZkZ2WVdWOS9jVHpuUGxEbXhrbmZSdmU5MEpEV3E1Ukp5?=
 =?utf-8?B?Q2Ftd0xQd3NmdnYzbkh5ZzgyaEhxTFVNd3ZBUzdpb3BJYjNLZ1NoSWlGZnhu?=
 =?utf-8?B?RzlsRnIvS0FtK0NXcVlCdEhVa0pZTDU3d1NHeFI0MEloc285ZzJJRTFSRTdk?=
 =?utf-8?B?YmhaYkpybW93NDVaSFZRS2NzRkZTSFdtb0l1amtmK1hwUDgxOG1CdGlueFZH?=
 =?utf-8?B?aVJTL3ozeHcxem5MSlBkM05zT2E4ZWJITDQ3clRBMXFMNk8wc293RW9XRGlI?=
 =?utf-8?B?MURwL0NXQ2JFeTFmem1GRFpnSDFGdFJxaHZsaVdIN3g5Mnl5VEJxcmRRempF?=
 =?utf-8?B?MmNtV2hxbDYrYUhBY05RV3RpeGdwUkpQL0NkNURKZjh0ZVlTTERMcjU4STI5?=
 =?utf-8?B?ZlhrL084R0tMN2EyRi9RZ3g2cDZrUnlKaWdtRVpta3M2dFY0V2RHOGlWU1ds?=
 =?utf-8?B?Tmw2OGQzNThNZ28vU05qT2lvV1E5ZUxOWDJuOFJuRVN2SWIxeWI3MGF5bm95?=
 =?utf-8?B?UEJTL2F6RVo0T1FrSGYrZjVSWHg1MUpldCtXSU1jUFRoVmpSQlJMMDNMOVpR?=
 =?utf-8?B?enJQOGMwZXhTa2NpdzRJR21meGNWV05zdHVmTXBFa0hjcVA4b2ZTbUNaTXR0?=
 =?utf-8?B?TGZOdXZJbk9WcXYxMVIzMnlwQ2xlNU5leUdVazFWWTVFSDFycVJaWkNubHYv?=
 =?utf-8?B?SXA3RndoTG9LOTlzUnpLb0VHTGt5dVVOaXdsVUYxR0Jkay81S25ZMzhpaTFN?=
 =?utf-8?B?QWJNWUplMHZpMnFaNHAwTUZFamd3SkZITDZNdGcveFdyaWVXNlkvdjZSaldu?=
 =?utf-8?B?aFlQRVdrNVFvQURWQWkvV2h5UE83UitEWnBRaXdLRWQzalZzWVZmNEZxdW0x?=
 =?utf-8?B?T3Bzb0lZTFZsMXBXYzM4Y0FwcGI0Si9GdkFtem5mOU1RNERGdi9qZGltazVz?=
 =?utf-8?B?bHYzUVRzSzRsYms1YmxrYmExMUdkNDlPcWh4U1FjbjZVUVdWdU1pNFZkTDJt?=
 =?utf-8?B?RVJhOGVTUk96L3Zvb0xNL1IyVkhPSGZnaHlHcUcvNVU5SmVUY2U1RXBYWEk4?=
 =?utf-8?B?dGlTWEU0cWtNRXNBQ012WTdYTEpsM1FBcUxpbmtNM2g2MVBoOUNPZ3hmMzZs?=
 =?utf-8?B?TXcvdktLU25jWkcrZjFBY3YwWGhFNVBUa2dhRDBsM01KeDZ4ekpTdXZvMGNx?=
 =?utf-8?B?dENVMytCK2hOQ2g2VjZDUUszRDZIWElXTFprYUs0eXJvS2E1MXJQNld4eXpY?=
 =?utf-8?B?TUl3UTNhYjhPVHpQTFFwTVc3NDRHVlNOYjVqL095RVJ3eEdYekozU0V5MXRk?=
 =?utf-8?B?YVRUcnFyeWsyczArb1haV3BEcDJsUzVocWlMTDAvOG9HVUU5eUg0ZS9lUldW?=
 =?utf-8?B?bWl6ejhYbGQwYTNWamhwM2xLRTNRNEdvYjRodWozQ2NTeGFjbGkrUmpBQURZ?=
 =?utf-8?B?TGMrcW5GZTAvckRvcTF1UkE0bW4xWkNhMU95QUZwSWUyKzlrVmtOTmlDV0Jm?=
 =?utf-8?B?UEUvZFMwaWFRR2tpUCtqRmxycmFvOWpwSFhneUFsUithc1d6VnBNRXBMektC?=
 =?utf-8?B?c0xnQXQ1WDA1ZnpxTDlDUWg5ZG1KWFVtUXpnNWRMZGFhdkVLMmd3MThLaFBi?=
 =?utf-8?B?dUFsendJNjh6VXhpMm9meDhoY1FHeDhuQlpDZ21NNTJVQ0IzRFFBMWpQYlZW?=
 =?utf-8?B?S3hpdTQzUGVzbGc1eVJlVDkwWFNCVE1uS0w1eUF3R1lwbytqU0twSWdoZVVD?=
 =?utf-8?B?bEh3NTJBamJkYTZvWnhPN1lVMWpsNG0vaEUwd2x3R3ZLM1Jza3ZyaGE5MkUy?=
 =?utf-8?B?TWFlRC9IUE9LOCtpSGhKWlk4WWlVbWxVczd3UFJiRmYvVnJWK1JxY3ZESDgr?=
 =?utf-8?Q?OLI882Tovm9wc/QaZKgCpwA1N?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZVJOOXJFVW9JVnp1Qi8vaitub2xLbExyREtJV2VHcyt0Q3poMDhyYXN6Z3kz?=
 =?utf-8?B?S3hlQ0RiQVlVMld2cnF2UXRqVmhBQ01QUkVFWGF5UkQ4YUdFZFpHc2x4dDUx?=
 =?utf-8?B?L0RiODMzSldqeVUrYSt3TU42c2xhcHJlNzhsVlROcm1LM0RvcXQ0QlBIdmVN?=
 =?utf-8?B?blJ0aWhSTjFuNGxWZmNzSzN5V2lqUzFoTXB2V3JKbzdXZ3FrM0ZwcXFFVnNU?=
 =?utf-8?B?NzJqMktIZkRUVUErTzYwNkRwQW42QzE2N1FrRnVxd3o2LzNHMDJmT1dhMlRv?=
 =?utf-8?B?ZGd5ZFhuWXJPZkdDVndpN215My9kOEt3b2N1azd4UGhkY2VpRGFRVEpZQk5h?=
 =?utf-8?B?dVczTUhBSW50UmdsSU9WOHR0Ry9xdURHV1BoZkdCaVBiTk5QRndlVFJlVHZR?=
 =?utf-8?B?NmhabVBKNWt6dnA0bkJaMmZsODFaMU1LRVJtdTExdWtuT0VKQ1BxRm5JZ3dD?=
 =?utf-8?B?TTNRdVhDeTR2OSt2Sk81SE04M25ib1hTb0I5SkkzMmRNNCt3ZmhnaC82SjBK?=
 =?utf-8?B?S2U2QUZDVE5BdmtYbFNGR3hNa1FHRFhJZERrSjViMHNoNFJUaEp5ZllrMkI1?=
 =?utf-8?B?YXYzZnI2ZnJpbXgreHFtUGFSN2ZtbTdlakJrYmI3ZE16ZER5cnpmdG5HUzJ4?=
 =?utf-8?B?bWFXejZ6TmFna2FWU0I3V2xUTDBCemhwRGJwSjFuUHFxVVlTd2JyMkljNXpr?=
 =?utf-8?B?MjAvZVVvbTZyT1l6SldjaEkvcVVlVlN4dTBTVW4rMjhqc1BOV2w2dWRORkxE?=
 =?utf-8?B?Nzh1Tk9FYnYrNFA3bm1zblRVU054Uml4enl5VjlGNm1hQlJQc1d6cmJ5ZWhy?=
 =?utf-8?B?a0NCcEp4bDNTWldLSTBlMjM5UUl4eUdNTStUd3JkZU5HazdSazVlbzhScDh6?=
 =?utf-8?B?SWxkYnFEaHRnekMreDBtY3R6cENVUTZsNDNOL1E0NWlvblFsejZwU3RPaHdY?=
 =?utf-8?B?Y3ZFNVpoSjZ0eGNnNCtycHhZZ1AyVE1JcE9CWUozOWpzNkZ0eVl0K08yaDRZ?=
 =?utf-8?B?MDdRVStxS0NuaXA2ZmNmaFg0NWttM0g5VWtPdkI2ejBwQlVraEljRTVVNzlU?=
 =?utf-8?B?UllzNjYrVVZoclJxRjB0WlZWM1VoY2dialRvbTV6SjJsT3ZJYk44YmZGaXFE?=
 =?utf-8?B?QTR5WSs4ZWtNZEtKQ3k5cEVROU5zaTQzY2VveUtNMUc1WE5NeS9CUXpqWFc5?=
 =?utf-8?B?MXY3eDBTNGtFaFUwdEhyR2trYnBMa2Faa0N2RzB3bmhSQUU2VlZvUFA2UHA2?=
 =?utf-8?B?c1BmUzFnTitQcitjUHFRVlU5aHNHeloyM3VLSkNWaEN0amhlNEsvVkt3Z3ZB?=
 =?utf-8?B?ME1vWkZ3Qit0UnVjbCszS1N0ZWcrS1FEQ25ZVXE5bGZWNWJ2ZHorQVhvc3dz?=
 =?utf-8?B?bVhkYWZISFA4aHVmMDQ2UytqMlBhVWJMUklkcEJMenp0WUsyTWZMUEhtdnBM?=
 =?utf-8?B?SkRMeCtOZGNFODFrQnRmSXg1ciswSjYwSGM4V0pDUUhsc3IrU1R3dG1sSFJF?=
 =?utf-8?Q?nZDb1anZyfpCTXUhWiut2VT511q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29477a66-a176-46c0-02b6-08dbc513a172
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 19:53:51.2980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1o8Yy/TCQ9zHEItJ+NzTcHQVGI5FzJ3DUPwfWdHeg7+djqhXCiQY4DxpJNXQCX9fymLimSfzgfoTUSEIi1kNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6621
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040147
X-Proofpoint-GUID: Ly29ezRaO76ao_hYxpZ0Fz3Ma9xagYur
X-Proofpoint-ORIG-GUID: Ly29ezRaO76ao_hYxpZ0Fz3Ma9xagYur
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [231004 05:10]:
>=20
>=20
> =E5=9C=A8 2023/10/4 02:46, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230924 23:58]:
> > > In dup_mmap(), using __mt_dup() to duplicate the old maple tree and t=
hen
> > > directly replacing the entries of VMAs in the new maple tree can resu=
lt
> > > in better performance. __mt_dup() uses DFS pre-order to duplicate the
> > > maple tree, so it is very efficient. The average time complexity of
> > > duplicating VMAs is reduced from O(n * log(n)) to O(n). The optimizat=
ion
> > > effect is proportional to the number of VMAs.
> >=20
> > I am not confident in the big O calculations here.  Although the additi=
on
> > of the tree is reduced, adding a VMA still needs to create the nodes
> > above it - which are a function of n.  How did you get O(n * log(n)) fo=
r
> > the existing fork?
> >=20
> > I would think your new algorithm is n * log(n/16), while the
> > previous was n * log(n/16) * f(n).  Where f(n) would be something
> > to do with the decision to split/rebalance in bulk insert mode.
> >=20
> > It's certainly a better algorithm to duplicate trees, but I don't think
> > it is O(n).  Can you please explain?
>=20
> The following is a non-professional analysis of the algorithm.
>=20
> Let's first analyze the average time complexity of the new algorithm, as
> it is relatively easy to analyze. The maximum number of branches for
> internal nodes in a maple tree in allocation mode is 10. However, to
> simplify the analysis, we will not consider this case and assume that
> all nodes have a maximum of 16 branches.
>=20
> The new algorithm assumes that there is no case where a VMA with the
> VM_DONTCOPY flag is deleted. If such a case exists, this analysis cannot
> be applied.
>=20
> The operations of the new algorithm consist of three parts:
>=20
> 1. DFS traversal of each node in the source tree
> 2. For each node in the source tree, create a copy and construct a new
>    node
> 3. Traverse the new tree using mas_find() and replace each element
>=20
> If there are a total of n elements in the maple tree, we can conclude
> that there are n/16 leaf nodes. Regarding the second-to-last level, we
> can conclude that there are n/16^2 nodes. The total number of nodes in
> the entire tree is given by the sum of n/16 + n/16^2 + n/16^3 + ... + 1.
> This is a geometric progression with a total of log base 16 of n terms.
> According to the formula for the sum of a geometric progression, the sum
> is (n-1)/15. So, this tree has a total of (n-1)/15 nodes and
> (n-1)/15 - 1 edges.
>=20
> For the operations in the first part of this algorithm, since DFS
> traverses each edge twice, the time complexity would be
> 2*((n-1)/15 - 1).
>=20
> For the second part, each operation involves copying a node and making
> necessary modifications. Therefore, the time complexity is
> 16*(n-1)/15.
>=20
> For the third part, we use mas_find() to traverse and replace each
> element, which is essentially similar to the combination of the first
> and second parts. mas_find() traverses all nodes and within each node,
> it iterates over all elements and performs replacements. The time
> complexity of traversing the nodes is 2*((n-1)/15 - 1), and for all
> nodes, the time complexity of replacing all their elements is
> 16*(n-1)/15.
>=20
> By ignoring all constant factors, each of the three parts of the
> algorithm has a time complexity of O(n). Therefore, this new algorithm
> is O(n).

Thanks for the detailed analysis!  I didn't mean to cause so much work
with this question.  I wanted to know so that future work could rely on
this calculation to demonstrate if it is worth implementing without
going through the effort of coding and benchmarking - after all, this
commit message will most likely be examined during that process.

I asked because O(n) vs O(n*log(n)) doesn't seem to fit with your
benchmarking.

>=20
> The exact time complexity of the old algorithm is difficult to analyze.
> I can only provide an upper bound estimation. There are two possible
> scenarios for each insertion:
>=20
> 1. Appending at the end of a node.
> 2. Splitting nodes multiple times.
>=20
> For the first scenario, the individual operation has a time complexity
> of O(1). As for the second scenario, it involves node splitting. The
> challenge lies in determining which insertions trigger splits and how
> many splits occur each time, which is difficult to calculate. In the
> worst-case scenario, each insertion requires splitting the tree's height
> log(n) times. Assuming every insertion is in the worst-case scenario,
> the time complexity would be n*log(n). However, not every insertion
> requires splitting, and the number of splits each time may not
> necessarily be log(n). Therefore, this is an estimation of the upper
> bound.

Saying every insert causes a split and adding in n*log(n) is more than
an over estimation.  At worst there is some n + n/16 * log(n) going on
there.

During the building of a tree, we are in bulk insert mode.  This favours
balancing the tree to the left to maximize the number of inserts being
append operations.  The algorithm inserts as many to the left as we can
leaving the minimum number on the right.

We also reduce the number of splits by pushing data to the left whenever
possible, at every level.


> >=20
> > >=20
> > > As the entire maple tree is duplicated using __mt_dup(), if dup_mmap(=
)
> > > fails, there will be a portion of VMAs that have not been duplicated =
in
> > > the maple tree. This makes it impossible to unmap all VMAs in exit_mm=
ap().
> > > To solve this problem, undo_dup_mmap() is introduced to handle the fa=
ilure
> > > of dup_mmap(). I have carefully tested the failure path and so far it
> > > seems there are no issues.
> > >=20
> > > There is a "spawn" in byte-unixbench[1], which can be used to test th=
e
> > > performance of fork(). I modified it slightly to make it work with
> > > different number of VMAs.
> > >=20
> > > Below are the test results. By default, there are 21 VMAs. The first =
row
> > > shows the number of additional VMAs added on top of the default. The =
last
> > > two rows show the number of fork() calls per ten seconds. The test re=
sults
> > > were obtained with CPU binding to avoid scheduler load balancing that
> > > could cause unstable results. There are still some fluctuations in th=
e
> > > test results, but at least they are better than the original performa=
nce.
> > >=20
> > > Increment of VMAs: 0      100     200     400     800     1600    320=
0    6400
> > > next-20230921:     112326 75469   54529   34619   20750   11355   611=
5    3183
> > > Apply this:        116505 85971   67121   46080   29722   16665   905=
0    4805
> > >                     +3.72% +13.92% +23.09% +33.11% +43.24% +46.76% +4=
8.00% +50.96%
             delta       4179   10502   12592   11461    8972    5310   293=
5    1622

Looking at this data, it is difficult to see what is going on because
there is a doubling of the VMAs per fork per column while the count is
forks per 10 seconds.  So this table is really a logarithmic table with
increases growing by 10%.  Adding the delta row makes it seem like the
number are not growing apart as I would expect.

If we normalize this to VMAs per second by dividing the forks by 10,
then multiplying by the number of VMAs we get this:

VMA Count:           21       121       221       421       821      1621  =
     3221      6421
log(VMA)           1.32      2.00      2.30      2.60      2.90      3.20  =
     3.36      3.81
next-20230921: 258349.8  928268.7 1215996.7 1464383.7 1707725.0 1842916.5  =
1420514.5 2044440.9
this:          267961.5 1057443.3 1496798.3 1949184.0 2446120.6 2704729.5  =
2102315.0 3086251.5
delta            9611.7  129174.6  280801.6  484800.3  738395.6  861813.0  =
 681800.5 1041810.6

The first thing that I noticed was that we hit some dip in the numbers
at 3221.  I first thought that might be something else running on the
host machine, but both runs are affected by around the same percent.

Here, we do see the delta growing apart, but peaking in growth around
821 VMAs.  Again that 3221 number is out of line.

If we discard 21 and anything above 1621, we still see both lines are
asymptotic curves.  I would expect that the new algorithm would be more
linear to represent O(n), but there is certainly a curve when graphed
with a normalized X-axis.  The older algorithm, O(n*log(n)) should be
the opposite curve all together, and with a diminishing return, but it
seems the more elements we have, the more operations we can perform in a
second.

Thinking about what is going on here, I cannot come up with a reason
that there would be a curve to the line at all.  If we took more
measurements, I would think the samples would be an ever-increasing line
with variability for some function of 16 - a saw toothed increasing
line. At least, until an upper limit is reached.  We can see that the
upper limit was still not achieved at 1621 since 6421 is higher for both
runs, but a curve is evident on both methods, which suggests something
else is a significant contributor.

I would think each VMA requires the same amount of work, so a constant.
The allocations would again, be some function that would linearly
increase with the existing method over-estimating by a huge number of
nodes.

I'm not trying to nitpick here, but it is important to be accurate in
the statements because it may alter choices on how to proceed in
improving this performance later.  It may be others looking through
these commit messages to see if something can be improved.

I also feel like your notes on your algorithm are worth including in the
commit because it could prove rather valuable if we revisit forking in
the future.

The more I look at this, the more questions I have that I cannot answer.
One thing we can see is that the new method is faster in this
micro-benchmark.

> > >=20
> > > [1] https://github.com/kdlucas/byte-unixbench/tree/master
> > >=20
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > ---
> > >   include/linux/mm.h |  1 +
> > >   kernel/fork.c      | 34 ++++++++++++++++++++----------
> > >   mm/internal.h      |  3 ++-
> > >   mm/memory.c        |  7 ++++---
> > >   mm/mmap.c          | 52 +++++++++++++++++++++++++++++++++++++++++++=
+--
> > >   5 files changed, 80 insertions(+), 17 deletions(-)
> > >=20
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 1f1d0d6b8f20..10c59dc7ffaa 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -3242,6 +3242,7 @@ extern void unlink_file_vma(struct vm_area_stru=
ct *);
> > >   extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
> > >   	unsigned long addr, unsigned long len, pgoff_t pgoff,
> > >   	bool *need_rmap_locks);
> > > +extern void undo_dup_mmap(struct mm_struct *mm, struct vm_area_struc=
t *vma_end);
> > >   extern void exit_mmap(struct mm_struct *);
> > >   static inline int check_data_rlimit(unsigned long rlim,
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 7ae36c2e7290..2f3d83e89fe6 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct mm_st=
ruct *mm,
> > >   	int retval;
> > >   	unsigned long charge =3D 0;
> > >   	LIST_HEAD(uf);
> > > -	VMA_ITERATOR(old_vmi, oldmm, 0);
> > >   	VMA_ITERATOR(vmi, mm, 0);
> > >   	uprobe_start_dup_mmap();
> > > @@ -678,16 +677,25 @@ static __latent_entropy int dup_mmap(struct mm_=
struct *mm,
> > >   		goto out;
> > >   	khugepaged_fork(mm, oldmm);
> > > -	retval =3D vma_iter_bulk_alloc(&vmi, oldmm->map_count);
> > > -	if (retval)
> > > +	/* Use __mt_dup() to efficiently build an identical maple tree. */
> > > +	retval =3D __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
> > > +	if (unlikely(retval))
> > >   		goto out;
> > >   	mt_clear_in_rcu(vmi.mas.tree);
> > > -	for_each_vma(old_vmi, mpnt) {
> > > +	for_each_vma(vmi, mpnt) {
> > >   		struct file *file;
> > >   		vma_start_write(mpnt);
> > >   		if (mpnt->vm_flags & VM_DONTCOPY) {
> > > +			mas_store_gfp(&vmi.mas, NULL, GFP_KERNEL);
> > > +
> > > +			/* If failed, undo all completed duplications. */
> > > +			if (unlikely(mas_is_err(&vmi.mas))) {
> > > +				retval =3D xa_err(vmi.mas.node);
> > > +				goto loop_out;
> > > +			}
> > > +
> > >   			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
> > >   			continue;
> > >   		}
> > > @@ -749,9 +757,11 @@ static __latent_entropy int dup_mmap(struct mm_s=
truct *mm,
> > >   		if (is_vm_hugetlb_page(tmp))
> > >   			hugetlb_dup_vma_private(tmp);
> > > -		/* Link the vma into the MT */
> > > -		if (vma_iter_bulk_store(&vmi, tmp))
> > > -			goto fail_nomem_vmi_store;
> > > +		/*
> > > +		 * Link the vma into the MT. After using __mt_dup(), memory
> > > +		 * allocation is not necessary here, so it cannot fail.
> > > +		 */
> > > +		mas_store(&vmi.mas, tmp);
> > >   		mm->map_count++;
> > >   		if (!(tmp->vm_flags & VM_WIPEONFORK))
> > > @@ -760,15 +770,19 @@ static __latent_entropy int dup_mmap(struct mm_=
struct *mm,
> > >   		if (tmp->vm_ops && tmp->vm_ops->open)
> > >   			tmp->vm_ops->open(tmp);
> > > -		if (retval)
> > > +		if (retval) {
> > > +			mpnt =3D vma_next(&vmi);
> > >   			goto loop_out;
> > > +		}
> > >   	}
> > >   	/* a new mm has just been created */
> > >   	retval =3D arch_dup_mmap(oldmm, mm);
> > >   loop_out:
> > >   	vma_iter_free(&vmi);
> > > -	if (!retval)
> > > +	if (likely(!retval))
> > >   		mt_set_in_rcu(vmi.mas.tree);
> > > +	else
> > > +		undo_dup_mmap(mm, mpnt);
> > >   out:
> > >   	mmap_write_unlock(mm);
> > >   	flush_tlb_mm(oldmm);
> > > @@ -778,8 +792,6 @@ static __latent_entropy int dup_mmap(struct mm_st=
ruct *mm,
> > >   	uprobe_end_dup_mmap();
> > >   	return retval;
> > > -fail_nomem_vmi_store:
> > > -	unlink_anon_vmas(tmp);
> > >   fail_nomem_anon_vma_fork:
> > >   	mpol_put(vma_policy(tmp));
> > >   fail_nomem_policy:
> > > diff --git a/mm/internal.h b/mm/internal.h
> > > index 7a961d12b088..288ec81770cb 100644
> > > --- a/mm/internal.h
> > > +++ b/mm/internal.h
> > > @@ -111,7 +111,8 @@ void folio_activate(struct folio *folio);
> > >   void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
> > >   		   struct vm_area_struct *start_vma, unsigned long floor,
> > > -		   unsigned long ceiling, bool mm_wr_locked);
> > > +		   unsigned long ceiling, unsigned long tree_end,
> > > +		   bool mm_wr_locked);
> > >   void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
> > >   struct zap_details;
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 983a40f8ee62..1fd66a0d5838 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -362,7 +362,8 @@ void free_pgd_range(struct mmu_gather *tlb,
> > >   void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
> > >   		   struct vm_area_struct *vma, unsigned long floor,
> > > -		   unsigned long ceiling, bool mm_wr_locked)
> > > +		   unsigned long ceiling, unsigned long tree_end,
> > > +		   bool mm_wr_locked)
> > >   {
> > >   	do {
> > >   		unsigned long addr =3D vma->vm_start;
> > > @@ -372,7 +373,7 @@ void free_pgtables(struct mmu_gather *tlb, struct=
 ma_state *mas,
> > >   		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and may
> > >   		 * be 0.  This will underflow and is okay.
> > >   		 */
> > > -		next =3D mas_find(mas, ceiling - 1);
> > > +		next =3D mas_find(mas, tree_end - 1);
> > >   		/*
> > >   		 * Hide vma from rmap and truncate_pagecache before freeing
> > > @@ -393,7 +394,7 @@ void free_pgtables(struct mmu_gather *tlb, struct=
 ma_state *mas,
> > >   			while (next && next->vm_start <=3D vma->vm_end + PMD_SIZE
> > >   			       && !is_vm_hugetlb_page(next)) {
> > >   				vma =3D next;
> > > -				next =3D mas_find(mas, ceiling - 1);
> > > +				next =3D mas_find(mas, tree_end - 1);
> > >   				if (mm_wr_locked)
> > >   					vma_start_write(vma);
> > >   				unlink_anon_vmas(vma);
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 2ad950f773e4..daed3b423124 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -2312,7 +2312,7 @@ static void unmap_region(struct mm_struct *mm, =
struct ma_state *mas,
> > >   	mas_set(mas, mt_start);
> > >   	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADD=
RESS,
> > >   				 next ? next->vm_start : USER_PGTABLES_CEILING,
> > > -				 mm_wr_locked);
> > > +				 tree_end, mm_wr_locked);
> > >   	tlb_finish_mmu(&tlb);
> > >   }
> > > @@ -3178,6 +3178,54 @@ int vm_brk(unsigned long addr, unsigned long l=
en)
> > >   }
> > >   EXPORT_SYMBOL(vm_brk);
> > > +void undo_dup_mmap(struct mm_struct *mm, struct vm_area_struct *vma_=
end)
> > > +{
> > > +	unsigned long tree_end;
> > > +	VMA_ITERATOR(vmi, mm, 0);
> > > +	struct vm_area_struct *vma;
> > > +	unsigned long nr_accounted =3D 0;
> > > +	int count =3D 0;
> > > +
> > > +	/*
> > > +	 * vma_end points to the first VMA that has not been duplicated. We=
 need
> > > +	 * to unmap all VMAs before it.
> > > +	 * If vma_end is NULL, it means that all VMAs in the maple tree hav=
e
> > > +	 * been duplicated, so setting tree_end to 0 will overflow to ULONG=
_MAX
> > > +	 * when using it.
> > > +	 */
> > > +	if (vma_end) {
> > > +		tree_end =3D vma_end->vm_start;
> > > +		if (tree_end =3D=3D 0)
> > > +			goto destroy;
> > > +	} else
> > > +		tree_end =3D 0;
> > > +
> > > +	vma =3D mas_find(&vmi.mas, tree_end - 1);
> > > +
> > > +	if (vma) {
> > > +		arch_unmap(mm, vma->vm_start, tree_end);
> > > +		unmap_region(mm, &vmi.mas, vma, NULL, NULL, 0, tree_end,
> > > +			     tree_end, true);
> >=20
> > next is vma_end, as per your comment above.  Using next =3D vma_end all=
ows
> > you to avoid adding another argument to free_pgtables().
> Unfortunately, it cannot be done this way. I fell into this trap before,
> and it caused incomplete page table cleanup. To solve this problem, the
> only solution I can think of right now is to add an additional
> parameter.
>=20
> free_pgtables() will be called in unmap_region() to free the page table,
> like this:
>=20
> free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
> 		next ? next->vm_start : USER_PGTABLES_CEILING,
> 		mm_wr_locked);
>=20
> The problem is with 'next'. Our 'vma_end' does not exist in the actual
> mmap because it has not been duplicated and cannot be used as 'next'.
> If there is a real 'next', we can use 'next->vm_start' as the ceiling,
> which is not a problem. If there is no 'next' (next is 'vma_end'), we
> can only use 'USER_PGTABLES_CEILING' as the ceiling. Using
> 'vma_end->vm_start' as the ceiling will cause the page table not to be
> fully freed, which may be related to alignment in 'free_pgd_range()'. To
> solve this problem, we have to introduce 'tree_end', and separating
> 'tree_end' and 'ceiling' can solve this problem.

Can you just use ceiling?  That is, just not pass in next and keep the
code as-is?  This is how exit_mmap() does it and should avoid any
alignment issues.  I assume you tried that and something went wrong as
well?

>=20
> >=20
> > > +
> > > +		mas_set(&vmi.mas, vma->vm_end);
> > > +		do {
> > > +			if (vma->vm_flags & VM_ACCOUNT)
> > > +				nr_accounted +=3D vma_pages(vma);
> > > +			remove_vma(vma, true);
> > > +			count++;
> > > +			cond_resched();
> > > +			vma =3D mas_find(&vmi.mas, tree_end - 1);
> > > +		} while (vma !=3D NULL);
> > > +
> > > +		BUG_ON(count !=3D mm->map_count);
> > > +
> > > +		vm_unacct_memory(nr_accounted);
> > > +	}
> > > +
> > > +destroy:
> > > +	__mt_destroy(&mm->mm_mt);
> > > +}
> > > +
> > >   /* Release all mmaps. */
> > >   void exit_mmap(struct mm_struct *mm)
> > >   {
> > > @@ -3217,7 +3265,7 @@ void exit_mmap(struct mm_struct *mm)
> > >   	mt_clear_in_rcu(&mm->mm_mt);
> > >   	mas_set(&mas, vma->vm_end);
> > >   	free_pgtables(&tlb, &mas, vma, FIRST_USER_ADDRESS,
> > > -		      USER_PGTABLES_CEILING, true);
> > > +		      USER_PGTABLES_CEILING, USER_PGTABLES_CEILING, true);
> > >   	tlb_finish_mmu(&tlb);
> > >   	/*
> > > --=20
> > > 2.20.1
> > >=20
> >=20
>=20
