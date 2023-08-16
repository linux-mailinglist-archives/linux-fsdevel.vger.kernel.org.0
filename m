Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FE477E7CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 19:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345264AbjHPRlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 13:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345267AbjHPRlX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:41:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26AE270D;
        Wed, 16 Aug 2023 10:41:21 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GH4aJf007383;
        Wed, 16 Aug 2023 17:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=Ef6tpg4o/6WAg8LTi167l2fZu8z0mFZCuQP1BahCTRA=;
 b=F74RQf6l7egjNGvCZ9DQNCZUh8ICaXW3dkQ65y7aq0QQLjSkFEVRqEmP2WfVpp/iEDB3
 06WeyvCNaKIr+BWQY3wJj2zSt/7LfSI8TShRST6W1x8cbMq/fPkbmUMRP2EKdxp9koXG
 66+4UOEdSkLMrGpDm3sZ6xLdt58n4LeYJW7O2w68e+nNdoGhspCnaqlIPHuN4xz3Ydlm
 4uY8RxUe2oeUe5bLVBdgWfV1LcviK7eiT42qs3UFb5AClUbU29mhUZxbv2DUVlFSnKLY
 FQvgxG1KSMYGid5A18O5Kn/5AqwXK+oRHbBoeQVAmlzkN04zozR7VocFHUVLZlqFkB67 Ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w5yp85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 17:40:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37GH6Sxn039443;
        Wed, 16 Aug 2023 17:40:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey71sbxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 17:40:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqTjUfUT+p/AG6eAsgGM87NlyVR9g8xxJ6HjQAQdAaJqvwZeKhIgZeh3GVuXJUaejg765VhiLl8kZlh1JPU0YoC0zNVWg/OzktMgKxpub66UX78/u0AZatlf6KLhAQJy/9OR83VZBxvUG0H4L4lauLVx/kcfdvtNx+/A3mX4joD0OQJn52sMlCwIV/HI6yfFktXp3U/KeMhnJSF6kI/iLhSB2dgbw9/FyUHsXrJCheXQjxO35ZPMa3KhXd2BiLAOEPMGkfyzGh4ka+vJ67SYpFExsPpPmRlEATfAqfEGGomp0q6VbyOtnAFlTwV3u25YUB1MZFe8afJCaUsPO0kQ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ef6tpg4o/6WAg8LTi167l2fZu8z0mFZCuQP1BahCTRA=;
 b=M2MgXPTxHCwQOJo4+ygGNVMc1TJ1OFWEfsNXltqBbgHJLBzebXiz+J6eJwpNBeZYgaFs8gTS8OMsejUHDtyNJUVrAk/BPmZT+Hp8MYZTS6vX71/BRxQl6QGdCL+8kw1iZAcOJZSFYc9igb9INQ7AhPMW9mH4wk9VZJ5ixDI8q8QnE2ZXrNYzdp1ixbsinqO493WY+1V9O95WnF6ajpEp1O/lzGTREVKAyrQh5M3ESdlMXN08L4yMIC/Xdqui7WugxG3nsiubDMRzphul3ltw9cOvfbosiddCLRLE5AjlFTlg2t16szXP8TUonffGC73KH5ZVsqhpau/LLrvtHNA4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef6tpg4o/6WAg8LTi167l2fZu8z0mFZCuQP1BahCTRA=;
 b=vn9jR/D5p+8sqR822QRcTi4KrtW0y4x0uFXWWiYH4CeswmyBFcTNSaAwOs4gayrcrDCCHniEy10ABVp9Ks0Cp/hn8cpdtqOj5RtMSZNRB7M2uMgdgMPjcTp7kawzvdMnfIXZSZfIYZ3GAITrxwHRqqwOURBQm1zY0OhQPKAdWKU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6169.namprd10.prod.outlook.com (2603:10b6:208:3a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 17:40:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 17:40:20 +0000
Date:   Wed, 16 Aug 2023 13:40:17 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     avagin@gmail.com, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, peterz@infradead.org,
        michael.christie@oracle.com, surenb@google.com, brauner@kernel.org,
        willy@infradead.org, akpm@linux-foundation.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 06/11] maple_tree: Introduce mas_replace_entry() to
 directly replace an entry
Message-ID: <20230816174017.4imcdnktvyoqcxw6@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, avagin@gmail.com,
        npiggin@gmail.com, mathieu.desnoyers@efficios.com,
        peterz@infradead.org, michael.christie@oracle.com,
        surenb@google.com, brauner@kernel.org, willy@infradead.org,
        akpm@linux-foundation.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-7-zhangpeng.00@bytedance.com>
 <20230726160843.hpl4razxiikqbuxy@revolver>
 <20aab1af-c183-db94-90d7-5e5425e3fd80@bytedance.com>
 <20230731164854.vbndc2z2mqpw53in@revolver>
 <6babc4c1-0f0f-f0b1-1d45-311448af8d70@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6babc4c1-0f0f-f0b1-1d45-311448af8d70@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0311.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8082d8-4fca-4527-6c03-08db9e7fdc9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bQBKP9BPYz24FX3P9T0gpqMZHyu5B21vHcSNX3xYrVPtJ96aVMf4BCUC1Pijmw2hFSdOJSjLHu7Z0IeEHKmg0YdaSupaOGvJwyYAJMnB2BSD/NEWlD0eHwbTDMjujNuXAz+e+FN1xg+00ZzSdB+6rNDRnVcQAAkX4BPLmKeGwIZhX10YZAlLMv22A7KDi2kgSV77QlF8ewyV4cYxaHcdUtngrM1sBILQOnBzXUI8rSZ1l/SYsxIhuRXeBIIHawxM4lbr1wIig8NY9aiU/VMDGiC9zsDMN31NoC1jXPRW1ZhuTX3otiWOpcSvVpvHKzr7ZIP2wbW0nuLA9TvS4nBVno6mL5Uy2ZV+lJB809iNEvAtVnYN0UKiDMpDMzbEWx48EFvpWD6GqvvKd7Ypqpyij/ODHibCeP2I1ZLxiVBw7Y3kgbslXngfe6/vWf2HQm3wl4Vc/0IPcX8UcTwM70LLC6keTyZDj7gzkmWpQ4e1CPOn2Ua6t7smI3zIkn3b3jtDGSf+stnEvEvakW/xXHf2/ggi7vGKm1OKGZCLNmf2CI2OFsRIdeZxbBAOtDKUv0Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199024)(1800799009)(186009)(2906002)(83380400001)(7416002)(86362001)(478600001)(6506007)(6486002)(6666004)(1076003)(9686003)(6512007)(26005)(5660300002)(41300700001)(316002)(66946007)(66556008)(66476007)(6916009)(8676002)(8936002)(4326008)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHJtQWlva0JGV0ttL2pBb1pYaWxhcCtkZGJrNW1LMWRLdXNxci9BRC9wT1RF?=
 =?utf-8?B?UFZrUmNBZDZzV0NjZEw2eVBxWnYxaUdLaDhYUEtOWjc5THBRTjFBM3dOWVNQ?=
 =?utf-8?B?b0tmaUZEdnFHMmNkZ3lxbitENVhQZ3JiQ3lvMnNaQVZyd0ExNXpJSXIwL0w2?=
 =?utf-8?B?cU9OekRvNVpiOGN5WmxNaWVBMThiTmt6SmFJS1h0U3pQRzVBWjExNWtoRFQ1?=
 =?utf-8?B?Y2pkZ0IvR3dMcDZNMTdjR0VEa0pPMW5hbVdaSjU3QlorU2NQRzJtdUI4bDhx?=
 =?utf-8?B?Z25UdWlUeWVxamRteGdtTEhvampoV0tLSUFDVTZQaHZ1dXJIZlk0UC9oTXdY?=
 =?utf-8?B?RkdDUmhWVzBOSHNIMWROMDlpY1doOUVWeXNpb2sxYWxoWFgvRE9iMTRIdHZk?=
 =?utf-8?B?dzRkaHdZb3FmLzlvU3FFKzZmUGJXT3BrMzg2amVPSVE2L2ExeTFHTUJqYkhz?=
 =?utf-8?B?Y2lmUEl5ZWF0dmlDUlRNRnlXQmdPakNjZkRKL0RXN2l6WGxCRmZNbVZvLzZn?=
 =?utf-8?B?QkVyWVJqdXphN2ZDU0o0TkwzbTdFK0t4ZjAyUTJObVlHaUZPM29YTWtSbjVp?=
 =?utf-8?B?TUtUT25jN3hibFNiemphVUFMdzRqYUhrY25UYnpXRW9pNDluWDFzamNsQ3VR?=
 =?utf-8?B?R2p1NGVDdXl5akRxaUZrVW44SWJjc2JKWWRaWGJiNFNQZ1hpMkxCRGFkcEUx?=
 =?utf-8?B?a2ExSEwxMFd3cVh2SVFaN1J5VGpzRTQ1K2Vwb3NvMHF3eExrZ0VnMTBSREpP?=
 =?utf-8?B?RFFTd1BHMU8xQXorbHJaK3BMZnhJQmJwYnN4RDV1VXpRc3IxaHVmc0hPckdr?=
 =?utf-8?B?UUJlZHI3c3JMQVdkSG00V1VERlpMQklzOGNyaytXQ1BIVWx4dkRSUC9RVUs1?=
 =?utf-8?B?Vkp0MUpwTzZ1L2Foc1crUytjT0pvcHZPZlozL01VbEViL2VxSWZka29DYVcv?=
 =?utf-8?B?NXhXMlNLT1l5NkJPZDVOSGdFT2hObTBYRWxUZC8za2E4VEcxUTdEbHUzVVB6?=
 =?utf-8?B?MUs5NEFDOGFwMGp5K3dvYzNsK1g4YVNBWjM4WWJjb3dNQ3FCcENlZUFtVSta?=
 =?utf-8?B?cW9WNjdubjdiZXdBUVh3SXlNWG9VT0dBRTVhanJlWEJIWmxkK01nYW1TMXdD?=
 =?utf-8?B?NDU4bGd6MnRvUnpHNjJOeFc4aWY3ei9nZlcwc3Z5YWZ1M2NDM0J1cXFQM3N0?=
 =?utf-8?B?RVh1YlpFaE56VHFZTFF4ek1Rbk9DMUVHTGREZTl0bWJRajFEWXZUM29kRkFs?=
 =?utf-8?B?d1RNVmg3TFZQWnBOaTMyVDAvM0VKQmdMQW9HOS92TkpBUG8yK3Via2pTZEZ4?=
 =?utf-8?B?bEgwdzhSU0hrZlhlOFNGNTFTVjM2bWFPa1pkellVR3hjUFp2ZVgrdEpjVStt?=
 =?utf-8?B?NzViRVpyY0JkNzhMb1BsM3doN2J0NVkxZk9WN0FKdzM2WWtib0ltQjNHT0tB?=
 =?utf-8?B?MEhURmhOVlpPSGdsdU1lVURnc1BETkNYSjJoTGgzMUs4elY1cE5ib0pFMGQr?=
 =?utf-8?B?M1BQUkk5VXFYejRER0dEdmM5UnRqS0NRTU5TTUh1SjBYaWtucXdteFd2WDlN?=
 =?utf-8?B?d0VJTE1oa09TRlVpZU84dDUyREF1Tm94ZlRzSzdCYTdvWGpRZTJ3aDkvNjMz?=
 =?utf-8?B?TTNYdndhWmpwdDB1S2dKRHJXeDZUdUVwZkxlYUF4NzRiaWZpb2xrOFVoWnRO?=
 =?utf-8?B?RHVLQy9lenQvZFpQUEZLeVBvTi9TWnRTQy9WNXBtZjNmampyYWxwalU3QVM2?=
 =?utf-8?B?clNYS2xXS0VtQWNWSlZuNGpKbHBaZWN4aFN4SGNGL2E1ckJGd3MzdGNBa0NB?=
 =?utf-8?B?VlhvWjAxMit2ZFdwQTVuZktneTJQdEpoSkhXMkZwc2RRbkFFaEtneHNnZTBB?=
 =?utf-8?B?OTVQMERmdkJCaTJuSG9EcFBCQTZaOGZxaGpwa0ZlT3NuOUN0TnZyVTUzS3BT?=
 =?utf-8?B?S2MxMnZqY1lpa3R6Qk55U1FtWHFSVWQ3NzdNdEZUS01LQkZ5Y0J5UDlGVm9Q?=
 =?utf-8?B?Z0V1TE1YWDJIVk1XbitCQlBMdnhTOWhyL1VYaTRMNmhZekwyOEptYkxqMm4z?=
 =?utf-8?B?dmlvS2RlN3BTWGFqNmNpa3VCYmVPWm4xR3pOV3JSYkV1bTdHcFZ0eFhSQnpC?=
 =?utf-8?Q?ZaHih1sp/id583Drxvu0o+/fC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?T3k5Z1J0cTgzbzVGa2VXdjBiSVMyV280Slk3R0ZTR2F5WFFWbU13Si9seDNQ?=
 =?utf-8?B?NXhTYTBmMlBrR3FxQTZNanFYOUVaSVVoVVB0ZWpwUElsaENwYUJBT1lvdHp1?=
 =?utf-8?B?ZW0rZnJEVGR0SWhJdFZXS0J1NW1FYTdqNDZrcWEyTmc2T2RiZ29TZWs2RzBH?=
 =?utf-8?B?bUhWVWRyVzRVd0xQdzBqQUpQblB2bXFST3hQaDVGN1MyZGVURjhIVmxtb2hj?=
 =?utf-8?B?VVp5K3U2dGlYbnNuUTA4N0VLaE5OZEhwLzZQNVI1YkkvdTZXWXNkNVVneUNa?=
 =?utf-8?B?Z1o0dEc2c2hIMUNlS1cvUjZsSCtJaW5sRVhrdmVFTFEwVlZNRnZOYXNhV3F0?=
 =?utf-8?B?SHowQVd1MEl6aUNoMTZMMWVoU0RBYk9lUUVZTlVPc0ZPaVlmNEdBR0tKZWdZ?=
 =?utf-8?B?RllmTm9KTk13MCtYRCtDcHNHZEQ0dWdvcXBOUkZpU0c0c1dET3FUZUJhVko3?=
 =?utf-8?B?K3dTYWRTalBZNHM5TVQrVHZ3alJuN3JzREZPY3h0QUl6aG55ejhBWUVUTUFo?=
 =?utf-8?B?Yk1RQmlJWVlUSC9xeENnR084clliQStYZXZXS0cxK0UvditOcVBWTWtxVDdR?=
 =?utf-8?B?b1EwNXVQV0ZmWDZvT0xlbmEzSEhHUVVxZkZVU3BHZm5iajFyNGY3bGlMM3pC?=
 =?utf-8?B?UWRzdmlqQ0Qyc1pFNU8rRGpmeFJUWWtVRWdZTkhuc0dka1FVSEMrTlZXQWpW?=
 =?utf-8?B?OWRaRTFxL2EyUzlpSjVuL0hTeUtrY3A3Slhtek1DcW43MTEvdkp2L1FZSi8y?=
 =?utf-8?B?alFvdk12WEJWekt6b285YkdPbVJvVGxwektudHVwSlVpRHdCWTVueHhCaHJ3?=
 =?utf-8?B?ekl3T1Rzc1BjeWJLVTZZNzRZN2xIdVYrb0hndnBlWVM3S2xkVUZoc0JJSXBj?=
 =?utf-8?B?VVNJZUtGLzJjY1QyYSt3YTgvN0d4eTJZR295SUxEeFpvbVlkT2V3Wktqb0Jm?=
 =?utf-8?B?akM3ZXM1akpLVU1WcEwybmEzQll1dDRuZUZYdkhTbTZYa1RhU2dGd3lGbFk4?=
 =?utf-8?B?d2pzZEU2SDBKL3FsbVRJcUhiWHkzV3RoU2lxTU5ITkJ1aHRWZlAzMVVDZUp4?=
 =?utf-8?B?aXRkM3U5YTBDckNPYjZoeHNOYjR5dUMyQ0ZCbjg1aGN3QmJxN2NxR21MYUtj?=
 =?utf-8?B?cVFQay9rdy83TlF0bVlxWWpNZVMzQTZMcjdvaUl2bklIM0t3Mms2SzBvRS9J?=
 =?utf-8?B?WlJaMk8zK3JMOS9yTnlJemYwd0orOXMyR0YyUnFZR1V0UU9ZOU9wWXp2V0I2?=
 =?utf-8?B?S24vSE5zZFdMMkcrTDlkeFliOXA4a1BKU1o0c2pxdE0zTmhFMnNYTko3S1lu?=
 =?utf-8?B?bzRKa0JHZG5TR09EcjFYMmF4L0ZCeSsyc0dXYlZ3OVkvSDBHYWhNajF5a0ly?=
 =?utf-8?B?WnBEVGN5enNvcmZuOEs1bUdSK2lTY3kzY2RDdnMremwrRDhXUDhHV05OU2px?=
 =?utf-8?Q?qq+4UwJg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8082d8-4fca-4527-6c03-08db9e7fdc9a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:40:20.3947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IWKatew5CFrwnSVnlOvbs1Id0W/v4H4oamxW1ksa7dyvgBg+vwfzZv5CCL33k/nQPTkdfC75TFkATzauIFWPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_18,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160155
X-Proofpoint-ORIG-GUID: Lbxce1gavI4vHHel-hmJoAGjEfViQicK
X-Proofpoint-GUID: Lbxce1gavI4vHHel-hmJoAGjEfViQicK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230816 09:11]:
>=20
>=20
> =E5=9C=A8 2023/8/1 00:48, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230731 08:39]:
> > >=20
> > >=20
> > > =E5=9C=A8 2023/7/27 00:08, Liam R. Howlett =E5=86=99=E9=81=93:
> > > > * Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
> > > > > If mas has located a specific entry, it may be need to replace th=
is
> > > > > entry, so introduce mas_replace_entry() to do this. mas_replace_e=
ntry()
> > > > > will be more efficient than mas_store*() because it doesn't do ma=
ny
> > > > > unnecessary checks.
> > > > >=20
> > > > > This function should be inline, but more functions need to be mov=
ed to
> > > > > the header file, so I didn't do it for the time being.
> > > >=20
> > > > I am really nervous having no checks here.  I get that this could b=
e
> > > > used for duplicating the tree more efficiently, but having a functi=
on
> > > > that just swaps a value in is very dangerous - especially since it =
is
> > > > decoupled from the tree duplication code.
> > > I've thought about this, and I feel like this is something the user
> > > should be guaranteed. If the user is not sure whether to use it,
> > > mas_store() can be used instead.
> >=20
> > Documentation often isn't up to date and even more rarely read.
> > mas_replace_entry() does not give a hint of a requirement for a specifi=
c
> > state to the mas.  This is not acceptable.
> >=20
> > The description of the function also doesn't say anything about a
> > requirement of the maple state, just that it replaces an already
> > existing entry.  You have to read the notes to find out that 'mas must
> > already locate an existing entry'.
> >=20
> > > And we should provide this interface
> > > because it has better performance.
> >=20
> > How much better is the performance?  There's always a trade off but
> > without numbers, this is hard to justify.
> I have implemented a new version of this pachset, and I will post it
> soon.
>=20
> I tested the benefits of mas_replace_entry() in userspace.
> The test code is attached at the end.
>=20
> Run three times:
> mas_replace_entry(): 2.7613050s 2.7120030s 2.7274200s
> mas_store():         3.8451260s 3.8113200s 3.9334160s

This runtime is too short, we should increase the number of elements or
loops until it is over 10 seconds.  This will make the setup time
and other variances less significant and we can use the command run time
as a rough estimate of performance. IIRC 134 was picked for a rough
estimate of an average task size so maybe increase the loops.

I understand the numbers here are from clock recordings to demonstrate
the significance of your change.

>=20
> Using mas_store() reduces the performance of duplicating VMAs by about
> 41%.
>=20
> So I think mas_replace_entry() is necessary. We can describe it in more
> detail in the documentation to prevent users from misusing it.

I think something is necessary for a quicker replacement, yes.  I don't
want to go as far as you did with the lack of checking.

>=20
>=20
> static noinline void __init bench_forking(struct maple_tree *mt)
> {
> 	struct maple_tree newmt;
> 	int i, nr_entries =3D 134, nr_fork =3D 80000, ret;
> 	void *val;
> 	MA_STATE(mas, mt, 0, 0);
> 	MA_STATE(newmas, &newmt, 0, 0);
> 	clock_t start;
> 	clock_t end;
> 	double cpu_time_used =3D 0;
>=20
> 	for (i =3D 0; i <=3D nr_entries; i++)
> 		mtree_store_range(mt, i*10, i*10 + 5,
> 				  xa_mk_value(i), GFP_KERNEL);
>=20
> 	for (i =3D 0; i < nr_fork; i++) {
> 		mt_set_non_kernel(99999);
>=20
> 		start =3D clock();
> 		mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
> 		mas_lock(&newmas);
> 		mas_lock(&mas);
> 		ret =3D __mt_dup(mt, &newmt, GFP_NOWAIT | __GFP_NOWARN);
> 		if (ret) {
> 			pr_err("OOM!");
> 			BUG_ON(1);
> 		}
>=20
> 		mas_set(&newmas, 0);
> 		mas_for_each(&newmas, val, ULONG_MAX) {
> 			mas_replace_entry(&newmas, val);
> 		}
>=20
> 		mas_unlock(&mas);
> 		mas_unlock(&newmas);
> 		end =3D clock();
> 		cpu_time_used +=3D ((double) (end - start));
>=20
> 		mas_destroy(&newmas);
> 		mt_validate(&newmt);
> 		mt_set_non_kernel(0);
> 		mtree_destroy(&newmt);
> 	}
> 	printf("time consumption:%.7fs\n", cpu_time_used / CLOCKS_PER_SEC);
> }
>=20
>=20
> >=20
> > > >=20
> > > > >=20
> > > > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > > > ---
> > > > >    include/linux/maple_tree.h |  1 +
> > > > >    lib/maple_tree.c           | 25 +++++++++++++++++++++++++
> > > > >    2 files changed, 26 insertions(+)
> > > > >=20
> > > > > diff --git a/include/linux/maple_tree.h b/include/linux/maple_tre=
e.h
> > > > > index 229fe78e4c89..a05e9827d761 100644
> > > > > --- a/include/linux/maple_tree.h
> > > > > +++ b/include/linux/maple_tree.h
> > > > > @@ -462,6 +462,7 @@ struct ma_wr_state {
> > > > >    void *mas_walk(struct ma_state *mas);
> > > > >    void *mas_store(struct ma_state *mas, void *entry);
> > > > > +void mas_replace_entry(struct ma_state *mas, void *entry);
> > > > >    void *mas_erase(struct ma_state *mas);
> > > > >    int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp=
);
> > > > >    void mas_store_prealloc(struct ma_state *mas, void *entry);
> > > > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > > > index efac6761ae37..d58572666a00 100644
> > > > > --- a/lib/maple_tree.c
> > > > > +++ b/lib/maple_tree.c
> > > > > @@ -5600,6 +5600,31 @@ void *mas_store(struct ma_state *mas, void=
 *entry)
> > > > >    }
> > > > >    EXPORT_SYMBOL_GPL(mas_store);
> > > > > +/**
> > > > > + * mas_replace_entry() - Replace an entry that already exists in=
 the maple tree
> > > > > + * @mas: The maple state
> > > > > + * @entry: The entry to store
> > > > > + *
> > > > > + * Please note that mas must already locate an existing entry, a=
nd the new entry
> > > > > + * must not be NULL. If these two points cannot be guaranteed, p=
lease use
> > > > > + * mas_store*() instead, otherwise it will cause an internal err=
or in the maple
> > > > > + * tree. This function does not need to allocate memory, so it m=
ust succeed.
> > > > > + */
> > > > > +void mas_replace_entry(struct ma_state *mas, void *entry)
> > > > > +{
> > > > > +	void __rcu **slots;
> > > > > +
> > > > > +#ifdef CONFIG_DEBUG_MAPLE_TREE

CONFIG_DEBUG_MAPLE_TREE is not necessary, MAS_WRAN_ON() will be compiled
out if it's not set.

> > > > > +	MAS_WARN_ON(mas, !mte_is_leaf(mas->node));
> > > > > +	MAS_WARN_ON(mas, !entry);
> > > > > +	MAS_WARN_ON(mas, mas->offset >=3D mt_slots[mte_node_type(mas->n=
ode)]);
> > > > > +#endif
> > > > > +
> > > > > +	slots =3D ma_slots(mte_to_node(mas->node), mte_node_type(mas->n=
ode));
> > > > > +	rcu_assign_pointer(slots[mas->offset], entry);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(mas_replace_entry);
> > > > > +
> > > > >    /**
> > > > >     * mas_store_gfp() - Store a value into the tree.
> > > > >     * @mas: The maple state
> > > > > --=20
> > > > > 2.20.1
> > > > >=20
