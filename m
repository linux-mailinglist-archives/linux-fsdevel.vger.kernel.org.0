Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA857BC3D0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 03:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjJGBfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 21:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjJGBfI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:35:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409AABD;
        Fri,  6 Oct 2023 18:35:05 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3970ArSl010370;
        Sat, 7 Oct 2023 01:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=xWIILLZ8k6Yu5Urm/Om8QLE0UjNPjN3hBOJYEFHWqG0=;
 b=Obfu3bwqiUMbq11Mn0XYJuYXOvhciovOGp03XU28//YAUaB5LOWBx3YkfXCbeHuMcLYf
 JawdmZN7M2k+TL/GhsdtL4wOUJo0kQ5i9FMCEYmvj5vmdWbjunJlj2acliAge0toD0jG
 NIUSJyeZWheNYd9tKMXZAi7BluG/Yw0zc8RHB7KREMCtadazXP/XCPx34nOwGXzIniIZ
 3sQtm0yljRiiw9/ldH5u4F7Xc00GA3Vag3UirOCXkz21Y9/HqyRysfXwPk0o6TOL09pV
 Cv7tXfoklc2q/NG8AegvAS9ouJhPHFOjYrfhBvrL6+hKu9xK9vH7Va2NA20DX/3NKrYM hw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea92cy3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Oct 2023 01:33:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3971XCt8004841;
        Sat, 7 Oct 2023 01:33:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws2g0u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Oct 2023 01:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOB6E8woOn5syIrQCKnE10Hn6/Zmp6HvTDiuY1od8R0zon3bHNYeO9JrzCr6RAK8nOPIkpU6hbuZvUeI7T5ALOVL8xGxtCHwc2A6BwGS7IFNjpXBxlJTLuiAxLpQs8KsH0aEoH1t1vDeZqHtuo/0Ih44okn7/5VEl2a2QmfC8/CIQRrCdcxtZj/l5GYBp44neRt/kLFeerRi6tv33t7GNwaeAr46doSweoMaHFi67lMvwSZjFu7prtFrrerrkt0RiJEyTGTrqpUvICWd/pnrf28y6+5F6dY0khmtVm3Lgpn+ZDpD2R+ywGvgcgdUZEOBMWpEkasS8/EAT3GjE04dHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWIILLZ8k6Yu5Urm/Om8QLE0UjNPjN3hBOJYEFHWqG0=;
 b=cKIT7CE/HrmgWkOfp2vlH8BjI8GnOrz/ClycyXU6hKQCDiGok2I1ZV78wd4hNcGLvuia88yJfOGlxXEB30smjh5bHFXepxdpqI2IHhQAGb7z1MdQagz7ipOpWM+rcnRPo0FLjOIJbWHJa94wlYMn3tEDgWzL65NCjuSARMGa1F+Q2Bj8Hn4Fbaua1BlAywS7xg/q9nIHWqViES8sNQLQK48e8KTzCjD46nRICDTQPBUapV1TxlBYpN3Y11ARFpXWa88ZnQLdr9f7drgvzXpai+c5AqgKQ87dpJQ7PR5a7aM8dJKZWF6F5KpULhfHF7SvVS9587kd3pCdrjUqZ/nzsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWIILLZ8k6Yu5Urm/Om8QLE0UjNPjN3hBOJYEFHWqG0=;
 b=Q2wSEhgWKdhcy/fnuISEoGELVApijRB1m85iHEoByf8ZdMZhRQvqWby8/uQF/5YOr8KRKMHhQ02aL3uipn7KAQEjelqvshyx+HjPMLWVZGfbTg+tDmGlsHBhcueyo1HqD35Y4m/bFPapV6XxvJ8Q9jNC0akZw3i9eswDHwNCm1g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5327.namprd10.prod.outlook.com (2603:10b6:5:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 01:32:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6838.039; Sat, 7 Oct 2023
 01:32:35 +0000
Date:   Fri, 6 Oct 2023 21:32:31 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
Message-ID: <20231007013231.ctzjap6uzvutuant@revolver>
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
 <20231007011102.koplouxuumlog3cu@revolver>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231007011102.koplouxuumlog3cu@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a856f8-1ffa-4290-48e0-08dbc6d54897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsZIDkVXKEIZRqwrtOyg5RG9Xw+i3zL33a3J/Mv/SnX4iobqmGdj9QAhdE+9zm49zuhpGfff+/iYC7nBwSZtafu8E0RXMkyhUzOip01oYuefhOuGKoPa5XKXbiP8sFodpgAEb6UerF7MCRG+yj2b6WmRvEnEdQ5ujy3i2Fncc7aFdLw1qg5P7kIVHSNahqlbuW0Qr0HjNXU2jV3oMk4yGPuVqrFu7kydY/aan6otcgVHohhPUO+mi6VNLpOksluVLQZv0FLWLBXXnxOQhGG74d+wTeK3Rjxi5rjUIiZaol1R+ystuXImm+HIb4zVE+s5LGp0MlmGcO7jbRMTsj3Ei/h4Q37DZVqjXyi+RsPKdcyeg6WenkbHUgbMT6zUk70qcaSSKsNBD2nBt4GN2HN/ipqDiZsawonsgBJNUDnR2OJ8ufBg/SyIuCXVQ/kLOfWb+fZ1QffJZbw8sIo5G/bjciePU9M4lplcyFKWIOJwvave/CUKq4QUSbptl//vsAmy4ORUbDLOzACVX+pWjB7DZ9ehxDTES87xGlckhiePxFQDeWsqW7O9eBsMi1OAVXG/QDy/e6Lvfy6qQhv6tnOWAUPZpgFKqpi0swh/nmiEBT0vm9HbnHTo8HfPdxJhlI1l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(366004)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6512007)(9686003)(6506007)(26005)(38100700002)(40140700001)(86362001)(921005)(2906002)(30864003)(7416002)(6666004)(6486002)(966005)(478600001)(83380400001)(1076003)(41300700001)(316002)(8676002)(8936002)(33716001)(5660300002)(66476007)(66556008)(66946007)(404934003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUgxTzRuTEZhYzd4V3FNeDBiRnBiQ2NBUU51blZnWVNuTXoyMy9LdzJhQlMx?=
 =?utf-8?B?bGxPdWlCUE9lK1BWbGc0NkxEOGRiNFRQbGsxT2dMVkJHM2NmWGxkUjM2NjFW?=
 =?utf-8?B?TEpBMmU5NDNKOVNKVE5wOVVtanZvUitCZGtDRi8wOEdjOU9kMUxNcmE5QU50?=
 =?utf-8?B?RVVycngwS2MxTDRCWGVwbk5iY0NIaE0xdENxVEY4RFh1QVdUZnNpQ1kxQmN6?=
 =?utf-8?B?TE00VGhvaUgrRDE1bGRYT096RGNpZER3bk0vOGdVaVRnckFuUm9iSkxhWWhj?=
 =?utf-8?B?czZhb1Z0ZUVkMDU0UFBrQ0t4aWFCYmxTNE1ya2tuSHh4UnJPeU1kSE1rYjlT?=
 =?utf-8?B?dFQyQkhHVDVtNE04dkgvcjI3OEgzcUtKa2I1bElJNHN0eUdEQUhZVGpoSE1Q?=
 =?utf-8?B?emJ0T1RYZnF6cFVrdGJ5azV5TElDTFlHUjJZUHB6WUpDaVIzcjRVRmNIZGww?=
 =?utf-8?B?Yk5zQ2ZjQVdDQzZWL2ErRFVmM0FJUVFVMHJwclVGYTFOZ1ZrQXh5Q2k5TDJj?=
 =?utf-8?B?d0ZmODE3WVNYSVpZeFhSWHJKUHY0bERlNWlCYkZ2QjZPY0NacHcyVTRjQmNN?=
 =?utf-8?B?RklmUFdpQUVXTEVmU3NUa3k1ZkxXREpwZFRLalN1czFYYkZ4MDBRTDNBNHRn?=
 =?utf-8?B?R0ZxNDN5Vyt2TTVRanpOWXhoTFFuM2hTL1lCV2dXd1ZxNHRBUS84eFAyU1ly?=
 =?utf-8?B?azRZNnVMY2JrQ1NMc2RiakI4YUxFT3g4NjBIcUdnVFpvNVU4S1NOeFVrK0JG?=
 =?utf-8?B?M2VvMWpsRSs2V1JpUys3L1lwZzRNZkhZTkJ0UTdsZjQvNTBKb29GZnBXUXdQ?=
 =?utf-8?B?Sm5pU0RRYWlvL1grOVhIZThSMmwrMVlqa3BoK08rQ1o1TkR0TG5qeUFMRXZK?=
 =?utf-8?B?aFNNQ1U1T1FhclhTVy95SFFJUlVya2FWL2hUMCtvRUNhVk9ic1RiUTJOUG5Z?=
 =?utf-8?B?c3lSRzZ6VXNNWlpiK25FYWcrNk83cEM2ZTRlenRqQlFzTnVFN2NsY0hXOVZz?=
 =?utf-8?B?ZkJYeHF0V0ZaNG5obFVuV1hzcUhZWnJ4NjczR3hKaHZtU05wM3A1SkR0T0tV?=
 =?utf-8?B?WG14aENRSnNkM01sTUNPS3JubndOWHZhMUhmYVNWVXV2TkxCNWZKOWp3Qm56?=
 =?utf-8?B?WUo3eFJ5ekJUVlhnbDdwS2V3ZmRCdEhsVmdDK3ZtUmJiUnhEZ21UQlVWNDh3?=
 =?utf-8?B?YzJFR1JmdnZtaDQxK2l2dkt6T1NBSWMrVjZBcmlwbDJnM1ppTUErTk4zWlVt?=
 =?utf-8?B?UFRHd3FqcFVhT05ZMkMvWm1qZzhmVnFBeEIrNVZJbUg3YlI3VmtNOFpKNkFU?=
 =?utf-8?B?WWxXVTFXZ1E0NnAwSVZKNE4rTlZvNzhpeVdUczMyTDZyeVZudFpvN1BXcHFQ?=
 =?utf-8?B?RXdQdENHMEF5dDFUNm4zMW5SZzJHMHNEUnZGVkVpMHlaT3BsdVIxWGd5dlZG?=
 =?utf-8?B?NEFFLzhjWU1RUlBsUGJHb0UvK3FldmJzS1FFZWU0bjhYaFVGVFVFZS9lSFps?=
 =?utf-8?B?TVZNMXNCU3RXaGY4dnZqWWFFcWxmN0s2aWd2dVUrK3VmanVXR0RyOElJSS9w?=
 =?utf-8?B?VjY2bG5lWTRKRUVJL0s4eUZIODlBUW1xL0FSc2IzYVptUENRZmFINisvN0F3?=
 =?utf-8?B?NzJtTkxOQlV2OG1uY24yMWMwdldsQmh4cWpTZDhNZ2dnOWl2azJNS3A3aUww?=
 =?utf-8?B?ZjhoUFFPUGQvVE9RZk1tejBJUDJmS0lKS1J0a2pMcXVFazdPUlZ3SWlVb3JL?=
 =?utf-8?B?WGo2R0F2cHVqZy9pd0RxUXRkRklEZS9ESXpzRThRUDkrLzZadlh4cmo2SitI?=
 =?utf-8?B?ZDQrZFE2UXhzVnFHdk1ESFB5Qnh0eUtjM0owZUpkN1ZvOURTZkFacS9Cd3Jn?=
 =?utf-8?B?L2lhQ1V5ajVyWGFOcHR2WTl1NWZNOS9EYjJKTzRmWCtnZ0lJaUJhK0F1dmxF?=
 =?utf-8?B?MW5pTWVPL29zS0FUQ2tFdFJLYkR3aVhmQWpQSFlQMERFSEFOTnN4Rnc2ZVhI?=
 =?utf-8?B?TVpMb1k3M2l6MlVESGNDRmFzNVZnQitnQ1RCTUREN1pXWjJGdDg0clFBUGVG?=
 =?utf-8?B?UmpCanowSjY4S3lxQ0Z1NlRJUlNPUk5lOUZtSWZFUXJCYUUwN0ZoVlRCY3Ew?=
 =?utf-8?B?dldXOUdxWTB1cExiU1JEQmVuMTRwampKVytjVGtySjdhTVVuakxONWZmMG1S?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZFVYNDgvZkYvanNtOHFrTjZXU3lBcHV1Nnl1UEVJeUd1T1h4NHp2UUhvbzNz?=
 =?utf-8?B?KzljMXBtUm9tZG55ZzhScXdyZ2FWZ3IvU3NBb0lCR0tST0lNWVNid0J4WHky?=
 =?utf-8?B?TVd3Rkhnak9ZQ0pJcHVkUHBwMXpFS2pNYU8rTWdWVDFJZzhRQ3g5WVF0UGZ1?=
 =?utf-8?B?N1BIMklDcktOdDloZFRhRUVqL0RWeFV6ZjhacHNiTDJoendBTExyMHA4UXFP?=
 =?utf-8?B?WkxOZ2VUV1JjK05oWHNHRHhTMXhHSlB2cW1aeXczNjAyRTdOY21YeDg1a1RG?=
 =?utf-8?B?Y2ozbFM1SXI2VUVwRVNFN1VGZXdLR3ZYbVBGWEk0RkluNHh4QUNrTDJpa1lQ?=
 =?utf-8?B?dHNVY1ljOWM2NStyMzBtWjdUMmZ4TFFoaTVCUjRSVDRYdmNDbUg4MGZWU3ZT?=
 =?utf-8?B?ZVQ5T1RSUHQ3cXZVSWtrR29JSkhQSUF6ZlpoTUQraGJVUVFybXVrMlVSWmtP?=
 =?utf-8?B?bTJQVmFQaEM5ZHhGTzc2OEtIOGlFem05QUFSSjBtTk5TQlBsVlJjdnY5ejN2?=
 =?utf-8?B?ZnVPMXZKemNRY0szbklta01KUDJQdzhoaWVhWmdlNXlRanowcGJmR2RrVDln?=
 =?utf-8?B?Q3dKOTR5K2txZ2V3dVVPZXhNRTg5MW5Bcmo0eFlVVkhWL1BjVmc4V29XOFB0?=
 =?utf-8?B?c2xqNHZ5a1B6Z2Yzd0hQMHNYOTZBa1pHcGVZL3FEaUEzcXNCc2hxNFNMM0xU?=
 =?utf-8?B?dTFLZisxN0VZeDRoUk1RUkRtczNoUEt5VGdRV2tlcWFZdWg1Ui9ZYVlIV3JE?=
 =?utf-8?B?MkJhaGNpQnBTQU1SNFFJbVFJN1RlKzFlUEk1OS9lemJXWUd2SWhWaVE2emli?=
 =?utf-8?B?OHJkbkZXd0tuNGJUOUw3aWw0SU5NbGJ6ak5mSGkwNkFxRWxGaitFcHBJMkw0?=
 =?utf-8?B?VkdDMENRelRrSitpT3c3bEhIRlQvZDlKMnhSTFpFQjUyRFNaOW5uYXZZMFBJ?=
 =?utf-8?B?TUpsQjk5bDJWaThPNjRBV3JLUElON0FpYVhXNmcyd1hjNHhOOVNEcklyc0Jx?=
 =?utf-8?B?bU4xb0NjajdLSnYzTGdwWndTeVZydHpQVEt4MmtCWVBoWC9nMDJ1M1dKbWhY?=
 =?utf-8?B?eFVPRlByRXd6OUVOVGlGcmE2WEgxL3g1TWNLMytPdm5BSGIybjhJcGgwYUc0?=
 =?utf-8?B?dEI5WkZDVzFHWWFEbHFUdk82dGE1L1ZwM1VqS0Z4QmdNaXdrZzYyYWI1NU9t?=
 =?utf-8?B?QTMxTFVoeTkwMFl6VHh3SFZxY2l6blUwaE4weEFSZ3lwUFJLUHd5MFhPNi9m?=
 =?utf-8?B?Z2VqRktiTWsxY1Aycmt5SnFNUnNvRnB5d3ZZdktYczQxd1V1TjFaRFF5cDlH?=
 =?utf-8?B?ZFlteDBxMVhrL3IxMmRKRHpqelptaWM2ZS8zc20rUkdkQWlqc2E1TG9xYkha?=
 =?utf-8?B?aXBzTXQ3QUQrSEZHYW5yNGU0ZEJOcDg0NlNVM1VPS0grNmpzdEk2NDYrWXpz?=
 =?utf-8?B?ak9zR3lDZ1QyQ0tUN0s5YjFRZGdOMEhZUjB4Z3k5Zjh1Wi8zS1ZJY2d0Tmo3?=
 =?utf-8?Q?ZQJshyZZHKky/GsSEGIdp05V8M7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a856f8-1ffa-4290-48e0-08dbc6d54897
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 01:32:35.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZeGTBKyXSG4YAl+5xEt/DNtpP4l84ll9JHVMvFHvIYCKscZ0lI8uA1mSuTQlN5SF56JjFu0ygqTcvkUEoQyhDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5327
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_15,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310070011
X-Proofpoint-GUID: fBhHK6ajO6TkjYixD2g4oYw5wx7ASQLc
X-Proofpoint-ORIG-GUID: fBhHK6ajO6TkjYixD2g4oYw5wx7ASQLc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [231006 21:11]:
> * Peng Zhang <zhangpeng.00@bytedance.com> [231005 11:56]:
> >=20
> >=20
> > =E5=9C=A8 2023/10/5 03:53, Liam R. Howlett =E5=86=99=E9=81=93:
> > > * Peng Zhang <zhangpeng.00@bytedance.com> [231004 05:10]:
> > > >=20
> > > >=20
> > > > =E5=9C=A8 2023/10/4 02:46, Liam R. Howlett =E5=86=99=E9=81=93:
> > > > > * Peng Zhang <zhangpeng.00@bytedance.com> [230924 23:58]:
> > > > > > In dup_mmap(), using __mt_dup() to duplicate the old maple tree=
 and then
> > > > > > directly replacing the entries of VMAs in the new maple tree ca=
n result
> > > > > > in better performance. __mt_dup() uses DFS pre-order to duplica=
te the
> > > > > > maple tree, so it is very efficient. The average time complexit=
y of
> > > > > > duplicating VMAs is reduced from O(n * log(n)) to O(n). The opt=
imization
> > > > > > effect is proportional to the number of VMAs.
> > > > >=20
> > > > > I am not confident in the big O calculations here.  Although the =
addition
> > > > > of the tree is reduced, adding a VMA still needs to create the no=
des
> > > > > above it - which are a function of n.  How did you get O(n * log(=
n)) for
> > > > > the existing fork?
> > > > >=20
> > > > > I would think your new algorithm is n * log(n/16), while the
> > > > > previous was n * log(n/16) * f(n).  Where f(n) would be something
> > > > > to do with the decision to split/rebalance in bulk insert mode.
> > > > >=20
> > > > > It's certainly a better algorithm to duplicate trees, but I don't=
 think
> > > > > it is O(n).  Can you please explain?
> > > >=20
> > > > The following is a non-professional analysis of the algorithm.
> > > >=20
> > > > Let's first analyze the average time complexity of the new algorith=
m, as
> > > > it is relatively easy to analyze. The maximum number of branches fo=
r
> > > > internal nodes in a maple tree in allocation mode is 10. However, t=
o
> > > > simplify the analysis, we will not consider this case and assume th=
at
> > > > all nodes have a maximum of 16 branches.
> > > >=20
> > > > The new algorithm assumes that there is no case where a VMA with th=
e
> > > > VM_DONTCOPY flag is deleted. If such a case exists, this analysis c=
annot
> > > > be applied.
> > > >=20
> > > > The operations of the new algorithm consist of three parts:
> > > >=20
> > > > 1. DFS traversal of each node in the source tree
> > > > 2. For each node in the source tree, create a copy and construct a =
new
> > > >     node
> > > > 3. Traverse the new tree using mas_find() and replace each element
> > > >=20
> > > > If there are a total of n elements in the maple tree, we can conclu=
de
> > > > that there are n/16 leaf nodes. Regarding the second-to-last level,=
 we
> > > > can conclude that there are n/16^2 nodes. The total number of nodes=
 in
> > > > the entire tree is given by the sum of n/16 + n/16^2 + n/16^3 + ...=
 + 1.
> > > > This is a geometric progression with a total of log base 16 of n te=
rms.
> > > > According to the formula for the sum of a geometric progression, th=
e sum
> > > > is (n-1)/15. So, this tree has a total of (n-1)/15 nodes and
> > > > (n-1)/15 - 1 edges.
> > > >=20
> > > > For the operations in the first part of this algorithm, since DFS
> > > > traverses each edge twice, the time complexity would be
> > > > 2*((n-1)/15 - 1).
> > > >=20
> > > > For the second part, each operation involves copying a node and mak=
ing
> > > > necessary modifications. Therefore, the time complexity is
> > > > 16*(n-1)/15.
> > > >=20
> > > > For the third part, we use mas_find() to traverse and replace each
> > > > element, which is essentially similar to the combination of the fir=
st
> > > > and second parts. mas_find() traverses all nodes and within each no=
de,
> > > > it iterates over all elements and performs replacements. The time
> > > > complexity of traversing the nodes is 2*((n-1)/15 - 1), and for all
> > > > nodes, the time complexity of replacing all their elements is
> > > > 16*(n-1)/15.
> > > >=20
> > > > By ignoring all constant factors, each of the three parts of the
> > > > algorithm has a time complexity of O(n). Therefore, this new algori=
thm
> > > > is O(n).
> > >=20
> > > Thanks for the detailed analysis!  I didn't mean to cause so much wor=
k
> > > with this question.  I wanted to know so that future work could rely =
on
> > > this calculation to demonstrate if it is worth implementing without
> > > going through the effort of coding and benchmarking - after all, this
> > > commit message will most likely be examined during that process.
> > >=20
> > > I asked because O(n) vs O(n*log(n)) doesn't seem to fit with your
> > > benchmarking.
> > It may not be well reflected in the benchmarking of fork() because all
> > the aforementioned time complexity analysis is related to the part
> > involving the maple tree, specifically the time complexity of
> > constructing a new maple tree. However, fork() also includes many other
> > behaviors.
>=20
> The forking is allocating VMAs, etc but all a 1-1 mapping per VMA so it
> should be linear, if not near-linear.  There is some setup time involved
> with the mm struct too, but that should become less as more VMAs are
> added per fork.
>=20
> > >=20
> > > >=20
> > > > The exact time complexity of the old algorithm is difficult to anal=
yze.
> > > > I can only provide an upper bound estimation. There are two possibl=
e
> > > > scenarios for each insertion:
> > > >=20
> > > > 1. Appending at the end of a node.
> > > > 2. Splitting nodes multiple times.
> > > >=20
> > > > For the first scenario, the individual operation has a time complex=
ity
> > > > of O(1). As for the second scenario, it involves node splitting. Th=
e
> > > > challenge lies in determining which insertions trigger splits and h=
ow
> > > > many splits occur each time, which is difficult to calculate. In th=
e
> > > > worst-case scenario, each insertion requires splitting the tree's h=
eight
> > > > log(n) times. Assuming every insertion is in the worst-case scenari=
o,
> > > > the time complexity would be n*log(n). However, not every insertion
> > > > requires splitting, and the number of splits each time may not
> > > > necessarily be log(n). Therefore, this is an estimation of the uppe=
r
> > > > bound.
> > >=20
> > > Saying every insert causes a split and adding in n*log(n) is more tha=
n
> > > an over estimation.  At worst there is some n + n/16 * log(n) going o=
n
> > > there.
> > >=20
> > > During the building of a tree, we are in bulk insert mode.  This favo=
urs
> > > balancing the tree to the left to maximize the number of inserts bein=
g
> > > append operations.  The algorithm inserts as many to the left as we c=
an
> > > leaving the minimum number on the right.
> > >=20
> > > We also reduce the number of splits by pushing data to the left whene=
ver
> > > possible, at every level.
> > Yes, but I don't think pushing data would occur when inserting in
> > ascending order in bulk mode because the left nodes are all full, while
> > there are no nodes on the right side. However, I'm not entirely certain
> > about this since I only briefly looked at the implementation of this
> > part.
>=20
> They are not full, the right node has enough entries to have a
> sufficient node, so the left node will have that many spaces for push.
> mab_calc_split():
>         if (unlikely((mas->mas_flags & MA_STATE_BULK))) {                =
                                              =20
>                 *mid_split =3D 0;=20
>                 split =3D b_end - mt_min_slots[bn->type];
>=20
> > >=20
> > >=20
> > > > >=20
> > > > > >=20
> > > > > > As the entire maple tree is duplicated using __mt_dup(), if dup=
_mmap()
> > > > > > fails, there will be a portion of VMAs that have not been dupli=
cated in
> > > > > > the maple tree. This makes it impossible to unmap all VMAs in e=
xit_mmap().
> > > > > > To solve this problem, undo_dup_mmap() is introduced to handle =
the failure
> > > > > > of dup_mmap(). I have carefully tested the failure path and so =
far it
> > > > > > seems there are no issues.
> > > > > >=20
> > > > > > There is a "spawn" in byte-unixbench[1], which can be used to t=
est the
> > > > > > performance of fork(). I modified it slightly to make it work w=
ith
> > > > > > different number of VMAs.
> > > > > >=20
> > > > > > Below are the test results. By default, there are 21 VMAs. The =
first row
> > > > > > shows the number of additional VMAs added on top of the default=
. The last
> > > > > > two rows show the number of fork() calls per ten seconds. The t=
est results
> > > > > > were obtained with CPU binding to avoid scheduler load balancin=
g that
> > > > > > could cause unstable results. There are still some fluctuations=
 in the
> > > > > > test results, but at least they are better than the original pe=
rformance.
> > > > > >=20
> > > > > > Increment of VMAs: 0      100     200     400     800     1600 =
   3200    6400
> > > > > > next-20230921:     112326 75469   54529   34619   20750   11355=
   6115    3183
> > > > > > Apply this:        116505 85971   67121   46080   29722   16665=
   9050    4805
> > > > > >                      +3.72% +13.92% +23.09% +33.11% +43.24% +46=
.76% +48.00% +50.96%
> > >               delta       4179   10502   12592   11461    8972    531=
0   2935    1622
> > >=20
> > > Looking at this data, it is difficult to see what is going on because
> > > there is a doubling of the VMAs per fork per column while the count i=
s
> > > forks per 10 seconds.  So this table is really a logarithmic table wi=
th
> > > increases growing by 10%.  Adding the delta row makes it seem like th=
e
> > > number are not growing apart as I would expect.
> > >=20
> > > If we normalize this to VMAs per second by dividing the forks by 10,
> > > then multiplying by the number of VMAs we get this:
> > >=20
> > > VMA Count:           21       121       221       421       821      =
1621       3221      6421
> > > log(VMA)           1.32      2.00      2.30      2.60      2.90      =
3.20       3.36      3.81
> > > next-20230921: 258349.8  928268.7 1215996.7 1464383.7 1707725.0 18429=
16.5  1420514.5 2044440.9
> > > this:          267961.5 1057443.3 1496798.3 1949184.0 2446120.6 27047=
29.5  2102315.0 3086251.5
> > > delta            9611.7  129174.6  280801.6  484800.3  738395.6  8618=
13.0   681800.5 1041810.6
> > >=20
> > > The first thing that I noticed was that we hit some dip in the number=
s
> > > at 3221.  I first thought that might be something else running on the
> > > host machine, but both runs are affected by around the same percent.
> > >=20
> > > Here, we do see the delta growing apart, but peaking in growth around
> > > 821 VMAs.  Again that 3221 number is out of line.
> > >=20
> > > If we discard 21 and anything above 1621, we still see both lines are
> > > asymptotic curves.  I would expect that the new algorithm would be mo=
re
> > > linear to represent O(n), but there is certainly a curve when graphed
> > > with a normalized X-axis.  The older algorithm, O(n*log(n)) should be
> > > the opposite curve all together, and with a diminishing return, but i=
t
> > > seems the more elements we have, the more operations we can perform i=
n a
> > > second.
> > Thank you for your detailed analysis.
> >=20
> > So, are you expecting the transformed data to be close to a constant
> > value?
>=20
> I would expect it to increase linearly, but it's a curve.  Also, it
> seems that both methods are near the identical curve, including the dip
> at 3221.  I expect the new method to have a different curve, especially
> at the higher numbers where the fork() overhead is much less, but it
> seems they both curve asymptotically.  That is, they seen to be the same
> complexity related to n, but with different constants.
>=20
> > Please note that besides constructing a new maple tree, there are many
> > other operations in fork(). As the number of VMAs increases, the number
> > of fork() calls decreases. Therefore, the overall cost spent on other
> > operations becomes smaller, while the cost spent on duplicating VMAs
> > increases. That's why this data grows with the increase of VMAs. I
> > speculate that if the number of VMAs is large enough to neglect the tim=
e
> > spent on other operations in fork(), this data will approach a constant
> > value.
>=20
> If it were the other parts of fork() causing the non-linear growth, then
> I would expect 800 -> 1600 to increase to +53% instead of +46%, and if
> we were hitting the limit of fork affecting the data, then I would
> expect the delta of VMAs/second to not be so high at the upper 6421 -
> both algorithms have more room to get more performance at least until
> 6421 VMAs/fork.
>=20
> >=20
> > If we want to achieve the expected curve, I think we should simulate th=
e
> > process of constructing the maple tree in user space to avoid the impac=
t
> > of other operations in fork(), just like in the current bench_forking()=
.
> > >=20
> > > Thinking about what is going on here, I cannot come up with a reason
> > > that there would be a curve to the line at all.  If we took more
> > > measurements, I would think the samples would be an ever-increasing l=
ine
> > > with variability for some function of 16 - a saw toothed increasing
> > > line. At least, until an upper limit is reached.  We can see that the
> > > upper limit was still not achieved at 1621 since 6421 is higher for b=
oth
> > > runs, but a curve is evident on both methods, which suggests somethin=
g
> > > else is a significant contributor.
> > >=20
> > > I would think each VMA requires the same amount of work, so a constan=
t.
> > > The allocations would again, be some function that would linearly
> > > increase with the existing method over-estimating by a huge number of
> > > nodes.
> > >=20
> > > I'm not trying to nitpick here, but it is important to be accurate in
> > > the statements because it may alter choices on how to proceed in
> > > improving this performance later.  It may be others looking through
> > > these commit messages to see if something can be improved.
> > Thank you for pointing that out. I will try to describe it more
> > accurately in the commit log and see if I can measure the expected curv=
e
> > in user space.
> > >=20
> > > I also feel like your notes on your algorithm are worth including in =
the
> > > commit because it could prove rather valuable if we revisit forking i=
n
> > > the future.
> > Do you mean that I should write the analysis of the time complexity of
> > the new algorithm in the commit log?
>=20
> Yes, I think it's worth capturing.  What do you think?
>=20
> > >=20
> > > The more I look at this, the more questions I have that I cannot answ=
er.
> > > One thing we can see is that the new method is faster in this
> > > micro-benchmark.
> > Yes. It should be noted that in the field of computer science, if the
> > test results don't align with the expected mathematical calculations,
> > it indicates an error in the calculations. This is because accurate
> > calculations will always be reflected in the test results. =F0=9F=98=82
> > >=20
> > > > > >=20
> > > > > > [1] https://github.com/kdlucas/byte-unixbench/tree/master
> > > > > >=20
> > > > > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > > > > ---
> > > > > >    include/linux/mm.h |  1 +
> > > > > >    kernel/fork.c      | 34 ++++++++++++++++++++----------
> > > > > >    mm/internal.h      |  3 ++-
> > > > > >    mm/memory.c        |  7 ++++---
> > > > > >    mm/mmap.c          | 52 ++++++++++++++++++++++++++++++++++++=
++++++++--
> > > > > >    5 files changed, 80 insertions(+), 17 deletions(-)
> > > > > >=20
> > > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > > index 1f1d0d6b8f20..10c59dc7ffaa 100644
> > > > > > --- a/include/linux/mm.h
> > > > > > +++ b/include/linux/mm.h
> > > > > > @@ -3242,6 +3242,7 @@ extern void unlink_file_vma(struct vm_are=
a_struct *);
> > > > > >    extern struct vm_area_struct *copy_vma(struct vm_area_struct=
 **,
> > > > > >    	unsigned long addr, unsigned long len, pgoff_t pgoff,
> > > > > >    	bool *need_rmap_locks);
> > > > > > +extern void undo_dup_mmap(struct mm_struct *mm, struct vm_area=
_struct *vma_end);
> > > > > >    extern void exit_mmap(struct mm_struct *);
> > > > > >    static inline int check_data_rlimit(unsigned long rlim,
> > > > > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > > > > index 7ae36c2e7290..2f3d83e89fe6 100644
> > > > > > --- a/kernel/fork.c
> > > > > > +++ b/kernel/fork.c
> > > > > > @@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct=
 mm_struct *mm,
> > > > > >    	int retval;
> > > > > >    	unsigned long charge =3D 0;
> > > > > >    	LIST_HEAD(uf);
> > > > > > -	VMA_ITERATOR(old_vmi, oldmm, 0);
> > > > > >    	VMA_ITERATOR(vmi, mm, 0);
> > > > > >    	uprobe_start_dup_mmap();
> > > > > > @@ -678,16 +677,25 @@ static __latent_entropy int dup_mmap(stru=
ct mm_struct *mm,
> > > > > >    		goto out;
> > > > > >    	khugepaged_fork(mm, oldmm);
> > > > > > -	retval =3D vma_iter_bulk_alloc(&vmi, oldmm->map_count);
> > > > > > -	if (retval)
> > > > > > +	/* Use __mt_dup() to efficiently build an identical maple tre=
e. */
> > > > > > +	retval =3D __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
> > > > > > +	if (unlikely(retval))
> > > > > >    		goto out;
> > > > > >    	mt_clear_in_rcu(vmi.mas.tree);
> > > > > > -	for_each_vma(old_vmi, mpnt) {
> > > > > > +	for_each_vma(vmi, mpnt) {
> > > > > >    		struct file *file;
> > > > > >    		vma_start_write(mpnt);
> > > > > >    		if (mpnt->vm_flags & VM_DONTCOPY) {
> > > > > > +			mas_store_gfp(&vmi.mas, NULL, GFP_KERNEL);
> > > > > > +
> > > > > > +			/* If failed, undo all completed duplications. */
> > > > > > +			if (unlikely(mas_is_err(&vmi.mas))) {
> > > > > > +				retval =3D xa_err(vmi.mas.node);
> > > > > > +				goto loop_out;
> > > > > > +			}
> > > > > > +
> > > > > >    			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
> > > > > >    			continue;
> > > > > >    		}
> > > > > > @@ -749,9 +757,11 @@ static __latent_entropy int dup_mmap(struc=
t mm_struct *mm,
> > > > > >    		if (is_vm_hugetlb_page(tmp))
> > > > > >    			hugetlb_dup_vma_private(tmp);
> > > > > > -		/* Link the vma into the MT */
> > > > > > -		if (vma_iter_bulk_store(&vmi, tmp))
> > > > > > -			goto fail_nomem_vmi_store;
> > > > > > +		/*
> > > > > > +		 * Link the vma into the MT. After using __mt_dup(), memory
> > > > > > +		 * allocation is not necessary here, so it cannot fail.
> > > > > > +		 */
> > > > > > +		mas_store(&vmi.mas, tmp);
> > > > > >    		mm->map_count++;
> > > > > >    		if (!(tmp->vm_flags & VM_WIPEONFORK))
> > > > > > @@ -760,15 +770,19 @@ static __latent_entropy int dup_mmap(stru=
ct mm_struct *mm,
> > > > > >    		if (tmp->vm_ops && tmp->vm_ops->open)
> > > > > >    			tmp->vm_ops->open(tmp);
> > > > > > -		if (retval)
> > > > > > +		if (retval) {
> > > > > > +			mpnt =3D vma_next(&vmi);
> > > > > >    			goto loop_out;
> > > > > > +		}
> > > > > >    	}
> > > > > >    	/* a new mm has just been created */
> > > > > >    	retval =3D arch_dup_mmap(oldmm, mm);
> > > > > >    loop_out:
> > > > > >    	vma_iter_free(&vmi);
> > > > > > -	if (!retval)
> > > > > > +	if (likely(!retval))
> > > > > >    		mt_set_in_rcu(vmi.mas.tree);
> > > > > > +	else
> > > > > > +		undo_dup_mmap(mm, mpnt);
> > > > > >    out:
> > > > > >    	mmap_write_unlock(mm);
> > > > > >    	flush_tlb_mm(oldmm);
> > > > > > @@ -778,8 +792,6 @@ static __latent_entropy int dup_mmap(struct=
 mm_struct *mm,
> > > > > >    	uprobe_end_dup_mmap();
> > > > > >    	return retval;
> > > > > > -fail_nomem_vmi_store:
> > > > > > -	unlink_anon_vmas(tmp);
> > > > > >    fail_nomem_anon_vma_fork:
> > > > > >    	mpol_put(vma_policy(tmp));
> > > > > >    fail_nomem_policy:
> > > > > > diff --git a/mm/internal.h b/mm/internal.h
> > > > > > index 7a961d12b088..288ec81770cb 100644
> > > > > > --- a/mm/internal.h
> > > > > > +++ b/mm/internal.h
> > > > > > @@ -111,7 +111,8 @@ void folio_activate(struct folio *folio);
> > > > > >    void free_pgtables(struct mmu_gather *tlb, struct ma_state *=
mas,
> > > > > >    		   struct vm_area_struct *start_vma, unsigned long floor,
> > > > > > -		   unsigned long ceiling, bool mm_wr_locked);
> > > > > > +		   unsigned long ceiling, unsigned long tree_end,
> > > > > > +		   bool mm_wr_locked);
> > > > > >    void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t=
 *pte);
> > > > > >    struct zap_details;
> > > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > > index 983a40f8ee62..1fd66a0d5838 100644
> > > > > > --- a/mm/memory.c
> > > > > > +++ b/mm/memory.c
> > > > > > @@ -362,7 +362,8 @@ void free_pgd_range(struct mmu_gather *tlb,
> > > > > >    void free_pgtables(struct mmu_gather *tlb, struct ma_state *=
mas,
> > > > > >    		   struct vm_area_struct *vma, unsigned long floor,
> > > > > > -		   unsigned long ceiling, bool mm_wr_locked)
> > > > > > +		   unsigned long ceiling, unsigned long tree_end,
> > > > > > +		   bool mm_wr_locked)
> > > > > >    {
> > > > > >    	do {
> > > > > >    		unsigned long addr =3D vma->vm_start;
> > > > > > @@ -372,7 +373,7 @@ void free_pgtables(struct mmu_gather *tlb, =
struct ma_state *mas,
> > > > > >    		 * Note: USER_PGTABLES_CEILING may be passed as ceiling an=
d may
> > > > > >    		 * be 0.  This will underflow and is okay.
> > > > > >    		 */
> > > > > > -		next =3D mas_find(mas, ceiling - 1);
> > > > > > +		next =3D mas_find(mas, tree_end - 1);
> > > > > >    		/*
> > > > > >    		 * Hide vma from rmap and truncate_pagecache before freein=
g
> > > > > > @@ -393,7 +394,7 @@ void free_pgtables(struct mmu_gather *tlb, =
struct ma_state *mas,
> > > > > >    			while (next && next->vm_start <=3D vma->vm_end + PMD_SIZE
> > > > > >    			       && !is_vm_hugetlb_page(next)) {
> > > > > >    				vma =3D next;
> > > > > > -				next =3D mas_find(mas, ceiling - 1);
> > > > > > +				next =3D mas_find(mas, tree_end - 1);
> > > > > >    				if (mm_wr_locked)
> > > > > >    					vma_start_write(vma);
> > > > > >    				unlink_anon_vmas(vma);
> > > > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > > > index 2ad950f773e4..daed3b423124 100644
> > > > > > --- a/mm/mmap.c
> > > > > > +++ b/mm/mmap.c
> > > > > > @@ -2312,7 +2312,7 @@ static void unmap_region(struct mm_struct=
 *mm, struct ma_state *mas,
> > > > > >    	mas_set(mas, mt_start);
> > > > > >    	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_U=
SER_ADDRESS,
> > > > > >    				 next ? next->vm_start : USER_PGTABLES_CEILING,
> > > > > > -				 mm_wr_locked);
> > > > > > +				 tree_end, mm_wr_locked);
> > > > > >    	tlb_finish_mmu(&tlb);
> > > > > >    }
> > > > > > @@ -3178,6 +3178,54 @@ int vm_brk(unsigned long addr, unsigned =
long len)
> > > > > >    }
> > > > > >    EXPORT_SYMBOL(vm_brk);
> > > > > > +void undo_dup_mmap(struct mm_struct *mm, struct vm_area_struct=
 *vma_end)
> > > > > > +{
> > > > > > +	unsigned long tree_end;
> > > > > > +	VMA_ITERATOR(vmi, mm, 0);
> > > > > > +	struct vm_area_struct *vma;
> > > > > > +	unsigned long nr_accounted =3D 0;
> > > > > > +	int count =3D 0;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * vma_end points to the first VMA that has not been duplicat=
ed. We need
> > > > > > +	 * to unmap all VMAs before it.
> > > > > > +	 * If vma_end is NULL, it means that all VMAs in the maple tr=
ee have
> > > > > > +	 * been duplicated, so setting tree_end to 0 will overflow to=
 ULONG_MAX
> > > > > > +	 * when using it.
> > > > > > +	 */
> > > > > > +	if (vma_end) {
> > > > > > +		tree_end =3D vma_end->vm_start;
> > > > > > +		if (tree_end =3D=3D 0)
> > > > > > +			goto destroy;
> > > > > > +	} else
> > > > > > +		tree_end =3D 0;
>=20
> You need to enclose this statement to meet the coding style.  You could
> just set tree_end =3D 0 at the start of the function instead, actually I
> think tree_end =3D USER_PGTABLES_CEILING unless there is a vma_end.
>=20
> > > > > > +
> > > > > > +	vma =3D mas_find(&vmi.mas, tree_end - 1);
>=20
> vma =3D vma_find(&vmi, tree_end);
>=20
> > > > > > +
> > > > > > +	if (vma) {
>=20
> Probably would be cleaner to jump to destroy here too:
> if (!vma)
> 	goto destroy;
>=20
> > > > > > +		arch_unmap(mm, vma->vm_start, tree_end);

One more thing, it seems the maple state that is passed into
unmap_region() needs to point to the _next_ element, or the reset
doesn't work right between the unmap_vmas() and free_pgtables() call:

vma_iter_set(&vmi, vma->vm_end);


> > > > > > +		unmap_region(mm, &vmi.mas, vma, NULL, NULL, 0, tree_end,
> > > > > > +			     tree_end, true);
> > > > >=20
> > > > > next is vma_end, as per your comment above.  Using next =3D vma_e=
nd allows
> > > > > you to avoid adding another argument to free_pgtables().
> > > > Unfortunately, it cannot be done this way. I fell into this trap be=
fore,
> > > > and it caused incomplete page table cleanup. To solve this problem,=
 the
> > > > only solution I can think of right now is to add an additional
> > > > parameter.
> > > >=20
> > > > free_pgtables() will be called in unmap_region() to free the page t=
able,
> > > > like this:
> > > >=20
> > > > free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDR=
ESS,
> > > > 		next ? next->vm_start : USER_PGTABLES_CEILING,
> > > > 		mm_wr_locked);
> > > >=20
> > > > The problem is with 'next'. Our 'vma_end' does not exist in the act=
ual
> > > > mmap because it has not been duplicated and cannot be used as 'next=
'.
> > > > If there is a real 'next', we can use 'next->vm_start' as the ceili=
ng,
> > > > which is not a problem. If there is no 'next' (next is 'vma_end'), =
we
> > > > can only use 'USER_PGTABLES_CEILING' as the ceiling. Using
> > > > 'vma_end->vm_start' as the ceiling will cause the page table not to=
 be
> > > > fully freed, which may be related to alignment in 'free_pgd_range()=
'. To
> > > > solve this problem, we have to introduce 'tree_end', and separating
> > > > 'tree_end' and 'ceiling' can solve this problem.
> > >=20
> > > Can you just use ceiling?  That is, just not pass in next and keep th=
e
> > > code as-is?  This is how exit_mmap() does it and should avoid any
> > > alignment issues.  I assume you tried that and something went wrong a=
s
> > > well?
> > I tried that, but it didn't work either. In free_pgtables(), the
> > following line of code is used to iterate over VMAs:
> > mas_find(mas, ceiling - 1);
> > If next is passed as NULL, ceiling will be 0, resulting in iterating
> > over all the VMAs in the maple tree, including the last portion that wa=
s
> > not duplicated.
>=20
> If vma_end is NULL, it means that all VMAs in the maple tree have been
> duplicated, so shouldn't the correct action in this case be freeing up
> to ceiling?
>=20
> If it isn't null, then vma_end->vm_start should work as the end of the
> area to free.
>=20
> With your mas_find(mas, tree_end - 1), then the vma_end will be avoided,
> but free_pgd_range() will use ceiling anyways:
>=20
> free_pgd_range(tlb, addr, vma->vm_end, floor, next ? next->vm_start : cei=
ling);
>=20
> Passing in vma_end as next to unmap_region() functions in my testing
> without adding arguments to free_pgtables().
>=20
> How are you producing the accounting issue you mention above?  Maybe I
> missed something?
>=20
>=20
> > >=20
> > > >=20
> > > > >=20
> > > > > > +
> > > > > > +		mas_set(&vmi.mas, vma->vm_end);
> vma_iter_set(&vmi, vma->vm_end);
> > > > > > +		do {
> > > > > > +			if (vma->vm_flags & VM_ACCOUNT)
> > > > > > +				nr_accounted +=3D vma_pages(vma);
> > > > > > +			remove_vma(vma, true);
> > > > > > +			count++;
> > > > > > +			cond_resched();
> > > > > > +			vma =3D mas_find(&vmi.mas, tree_end - 1);
> > > > > > +		} while (vma !=3D NULL);
>=20
> You can write this as:
> do { ... } for_each_vma_range(vmi, vma, tree_end);
>=20
> > > > > > +
> > > > > > +		BUG_ON(count !=3D mm->map_count);
> > > > > > +
> > > > > > +		vm_unacct_memory(nr_accounted);
> > > > > > +	}
> > > > > > +
> > > > > > +destroy:
> > > > > > +	__mt_destroy(&mm->mm_mt);
> > > > > > +}
> > > > > > +
> > > > > >    /* Release all mmaps. */
> > > > > >    void exit_mmap(struct mm_struct *mm)
> > > > > >    {
> > > > > > @@ -3217,7 +3265,7 @@ void exit_mmap(struct mm_struct *mm)
> > > > > >    	mt_clear_in_rcu(&mm->mm_mt);
> > > > > >    	mas_set(&mas, vma->vm_end);
> > > > > >    	free_pgtables(&tlb, &mas, vma, FIRST_USER_ADDRESS,
> > > > > > -		      USER_PGTABLES_CEILING, true);
> > > > > > +		      USER_PGTABLES_CEILING, USER_PGTABLES_CEILING, true);
> > > > > >    	tlb_finish_mmu(&tlb);
> > > > > >    	/*
> > > > > > --=20
> > > > > > 2.20.1
> > > > > >=20
> > > > >=20
> > > >=20
> > >=20
