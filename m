Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB447B645E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 10:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjJCIhr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 04:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjJCIhq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:37:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0571991;
        Tue,  3 Oct 2023 01:37:43 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3930iS1M027733;
        Tue, 3 Oct 2023 08:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ngt/nM9fNttBLatsBNaoYgrb677nlxAlM80nVIPwgps=;
 b=jEl2OGzjMT+8J8zCT3gUe8ZOpLLh1/ay/QSMUTBeLI0gDeuDymOO/yUreIRkp5AutxGJ
 iFUW9FeQISHWXK1kSEk+v5rvH+nY9R4blolnfaV0uzRGKkFJ+hICuhUebZm79eoCuFJf
 PBM4m4WgOT7A/780kCW1thDBQL6BL8/2H5iOhO4B9qLyq/XV0uGF2CmA5WlH8jkjPP/G
 ZwAYyzm504UPpXB7G4anmn87aZogqPubZKRIcER2OUTsKBqeC7MCOGF6J0hnEMc5TQFR
 OpoCBq3Qhim6TYSeS1Tt1JI/IGiyo0THN8kDAK39DHhno2gWUJ+f90tJRdUC2BbsajAO kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9uc567-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 08:37:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3937uL52005918;
        Tue, 3 Oct 2023 08:37:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea45p6wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 08:37:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOY/gU4mlMNbz5033LLBB3wTKZkzpM+waeLCn3q7eKi+WC/lEj+EJBUJw4Srw9SquzmqC/efiwUsck6a75WYXgpkRTJ1U5L/DTKq5g5Sx6D95ULLsxXsmefYMq5GY1lWQtvSuZ7u4C85oarJZw/85H6NfJ0RiAvX5AE+fC7r97i4dc6W0rqZZErLCUwCssDP/C8cZjVm0MCiEe82himVQtOOYDTiPLLRPhYisCeOG68SOTtBjZYvwBhGFXEChgMLqpSQiYctjlQM7IhgP/rkt32BumDhzscYM3XQjfpqvNdgCCiKaAIdpuUNG8RcBjuDfU58zRk23mMmvFUTJDkcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngt/nM9fNttBLatsBNaoYgrb677nlxAlM80nVIPwgps=;
 b=f3DNnJvPOm/8cMf2APUPSSHBJPgZxCgpzm949q7p1ygEKKcjbxfKSL0F9LNhyZAbcbaVpB7HQbqcXL9XMXOqixvoRN2wFAR3UwNW5wu429JOKeEWBNIdVJQBpH39hblJEWaIvX8wqkaWOvS7H0WJQy7d4QxiN5GgmskWIDWYHNMApWNWDHYXXSnBhY8ev8vIkkJSdsZXRNOSSDbYxaUBbxvqCjufHOlz7pwQsypdhpOsYlOo3X/uUDyTtaUPmdvbgJKKGvqgUrS9DxCYIB5oDh3huyqStSsTw0bjYNxCXYBz84rkvbfk5yuusvKc8jsNUc0wQsClcEwdxxbi6cX3gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngt/nM9fNttBLatsBNaoYgrb677nlxAlM80nVIPwgps=;
 b=k+o2tKKiXnhSmg5MfPXG4ED8Du11JFXW+PLvUc3C04aW8yi2HHM+cjejCBS5VDYTPC+dovWplAg6TanoCuVvyiPjP2yuYkHNsp0+7XEdrWL05FdOPvwTJFap1sOsEIyvatrYE8HyvZ/Lmom8A01fVHLpt+UHJp1CSr0Zl5EUN18=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5753.namprd10.prod.outlook.com (2603:10b6:510:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Tue, 3 Oct
 2023 08:37:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 08:37:16 +0000
Message-ID: <1adeff8e-e2fe-7dc3-283e-4979f9bd6adc@oracle.com>
Date:   Tue, 3 Oct 2023 09:37:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
 <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0154.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 9512fd83-66db-4c96-9ff3-08dbc3ebf318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yg/2bWPQmPN6ci+2Kptxz2i4ziQKcWWPibuThDlPnkvpskFXYyMcFgc2zgSaQgBChEJGDhroIYeZt+1f4NS9GEBew1MFK/XckRp3LJhlhzehWdbbRwDPGfAeVy0znt5nqwecEu+ZJE+3XG+Dk73ilZYUtVeLVLf9bMdZzyUhR3YlADzXGb586VxB0+cske5ZhyRAhXz5Ug580/VWyaEBCtgJjj5k2N4hkjshVv1YhhL3ss1na3Rzfz7nt6ZNn5npJ0lsuaKZ4ugyM4PKmFyLPLxb6QA+DI+Itq/8y9RXxQVJ5KNEQyWRPqK3fhiKy5cAQcQRvBRnmfL/FCpzfzGBfnsMqGC/642+/tdCjiFIednlK3rQHdGdprTBKNFfMOBOULj8Sj2nWvi3a4wWXV06ThXn+L9MOsxi0sRtU/HJzVggSXKZ/8rhHZq9D42367utcgzNFdZgXfe8y2ZYE/Tw0PaQp6e8M9qbhxYcH+IyZrWhYux4HlIOePEbBnjtjIIWW/sMKC+JCz426S5khGFfO/+nj0fPt5e3r7twrgFrkjTbBoEMyEDeqR56d5m1Fyh0tgkeDZvYhiqoR31oH8+wtSi9C3+grrjEJLi3D2SpAhB1GMeU0Cpc/MnPuLlE89PvI5mUpL85XMmpcUVZTa7hmlTKX3Mkknxy4lfaI9sNn2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(136003)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6666004)(53546011)(6486002)(6506007)(36916002)(478600001)(83380400001)(2616005)(6512007)(26005)(7416002)(2906002)(41300700001)(66556008)(5660300002)(8676002)(8936002)(4326008)(66476007)(316002)(66946007)(36756003)(38100700002)(31696002)(86362001)(921005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1ZlM3lTdmpCU1FhZkJaS2RwNXB6dldXYjhObXp5ZG5tNFhZQXhWRVFRdEZ3?=
 =?utf-8?B?MW4rR1NOVHRkYnFCTEV5aUpOUk1FeUVoMTEyUjFHT3Q4K0hqRFNMbXJmNjhv?=
 =?utf-8?B?aWNjVm52L0tTei9ERmxTTFVCYkhDRmhGdjZyVEV5NGRYSXNKZVp6djJVR3dF?=
 =?utf-8?B?dzlseTg3N2Z4UkNuMm1xUG9xbkhjRzh1NVIxNUk5UmtYLzlzVlVNeEptTGdr?=
 =?utf-8?B?SzQ4U21ZV1BFVkZSS29NTmZIWDFiSHlhZzJCb0I3OXZvVWJSd1NocUU1VzJX?=
 =?utf-8?B?WEZGOXM1WXhQZTBkamluYUhObUJPczliZ05rSUhld3hrNTVpL1dDQ3lpcmxT?=
 =?utf-8?B?WUlBRDg3TU5oNjY3Vjl5bmlYQTFvanZ0Zmx0QjlVb2tENmV2KzFrZnpLdmgy?=
 =?utf-8?B?OFpwR2xrdUZ2b2VZbDhSQnpLSzErUXR3SlJpQnhWcnpCUm5nTXM5VUJZVXpr?=
 =?utf-8?B?aU9RM1dUU2EzMnpBNVF0L1lQVG9wQ2l2d0JhTVhCSTkwZW80emh6ZUptelNv?=
 =?utf-8?B?K2pnMVdna0pMdk91MEdUcUtWLzkrVkZCRHdOeTkveW5iby9NTERrTUdyQzNO?=
 =?utf-8?B?Z1o4U2lxb21YS2REdTdWTllsa0ZDdldaRUQzQXE0T2c5VzFidGhxeTNyV1pI?=
 =?utf-8?B?TjBPRUQ4RHArcFkzZE1qQUhkOXB1T0xNTG5KQnp0WHZJWUpvaG4zb2JBVGJh?=
 =?utf-8?B?Z2JGQzUyZXRUQUl2TCtPandTWEp2a0VTMWRudnlxZHgydHNIb1A0Q2lvOHht?=
 =?utf-8?B?dkQySjk4YU43ZnB6Yk51cHlCRVdjZ0IyV001Q0ErNlpSSnlXMlZRQ0hnRTNS?=
 =?utf-8?B?c0RrbVQ3QXl3bEI4QzM3ZStjNXp3dHdFbzFObSsyZ1lqdVN0OHB1V0NZOFVt?=
 =?utf-8?B?MzN4RGxYTEdYTXUyLzlQNmx0di91UUE5ZDZWZlQzZTRyeHhaVjNDckRXVDhi?=
 =?utf-8?B?NWlQanRDa1NTNCszS0dDOVpHQ0h1bjFoeGV6aHRYbU9EbkhEcHhLNGUyeFZX?=
 =?utf-8?B?RnowQ1BTU1lRSExPdjFvbU80dnFDallwZFYvQzVOd0ZJSW5jVXUyQVQvdkEy?=
 =?utf-8?B?TFhaRDh0ZnNmSkFZVnJTM28zZnVmVFJPM3ozRk5sc1lMRE5NVDRnVHdqNW5H?=
 =?utf-8?B?ZkNocTJORWZXbFZJdkw3WGtlcmhyZ0F6cGsxNmlxa2xIbnZkVWNjQk8yZVp5?=
 =?utf-8?B?dHZOU0VWUWlwZTR6MW8zb2hZRElQcHVIUEh4RXNBcytuczgvQm1zd1hLSXJE?=
 =?utf-8?B?ZDhFOWU1MVdPK3pIZnRmdnViRGtKOUluQnVNa0VUajlROHIvL1ZuSXk3Ni9T?=
 =?utf-8?B?SUF4elo5VEVLaTVxT3VWR3JRL09iOWJBWEgvdEp1V2tCZkNmTWhNWEtRdlZI?=
 =?utf-8?B?RUptYlYvU0premxpQS93NUVKUDJja3NtK2oyMjZnRFY3VE1sOEN3NDdCWUo3?=
 =?utf-8?B?S2JMUGhjM29VUnYxWVB2U2VyNVBST0pOdmtwU1pLelhOeFN5KzhrQWc0OVVB?=
 =?utf-8?B?b3lmWms2VnJZZ0JmLzl5N1pPOHlEOEZHdnltWFFXaVRqb0pLK3ZIZHdKaVNS?=
 =?utf-8?B?M3UzdStzU2ZXTVRDbGJ5TnN5SDFoVGNHZnRYTDNyOE1HQ0djN2UrUFg0YlN0?=
 =?utf-8?B?bm5aMGZNUHpiV0N0ekl6M2lzT2lKRW9ZMnFNQXJPVlFNTXdPeXBtMzBzaVhW?=
 =?utf-8?B?d2RZSDl5amY1eXlnNGtGNlI0cC9ITjQ4bEtKVkNDSy8ycE9VNXJTUFozQkJ5?=
 =?utf-8?B?TEQ2dnJDeUJWbCtydUxHbWdWdm1WYzNTdWxlb2VualQ4VjRKMGsxR3g1WkVZ?=
 =?utf-8?B?dFQ2Q1ZiU01pWkEvditTeHZOZ2R0eWNsN21WK2xudERZVUtaM2VlZDl1bXd1?=
 =?utf-8?B?S29LT0k4UUdxdElCb1FFTjJ6TVBZcWdoem5wa0Njb0F5VnNOMlRHOGFwLy92?=
 =?utf-8?B?M3VVdFFDdjRMWW1TQzJJWU1ERTNpMVlPcHdzK2tkR2t2d3RnUURtRndiWjh6?=
 =?utf-8?B?NytUN2hoQStYcFFHbmJidzRCWXVtWm5HNldwbE9Hd1hBNXJpL2tOTmM4K3FI?=
 =?utf-8?B?N2pFTHlNZGltd1h5ZGgxdXpnakJ5RHNiRWNLY0g1VEhoSk1uQmRKSlVERjE5?=
 =?utf-8?Q?uJ3BjB0WVptyYShnAOPQ6XzqG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N2xXZDZQM1ZkanN4NVBqK0VkK2JibUNzTEVtOFYxSGhDTmU1RkFCRHBGVWhW?=
 =?utf-8?B?VitjYlZOa2J3V1NXRDhXemxEUG45VTR5c2xOUGpxTGJDR2VKTXVmRnFRUTVO?=
 =?utf-8?B?QkM5UzdOeURWVnZhdlFpeXBhUUNsclVaR2lSOXA4Z2UwOU9SOTBOYWMxL2ow?=
 =?utf-8?B?ZCtpV0FwajhoSSsvUWg4NGp0Z2h5Y3hnY0RXWnhTRW44U2kwZVRyMGJxTnFZ?=
 =?utf-8?B?RXByWVZTL0F1QkZOZDB5YTVmVzkvTUhIUXZpVnhXZjBKei9Fb3hWckJ1OWRw?=
 =?utf-8?B?bUZqVC91clBIa3p2ZmNnenZkcDkvcGlCT2xXQUVhdDBBQlFRRjZTZC9lVlUy?=
 =?utf-8?B?SHFIa3J3SEhFd0Y1YkNYLzhRblkrZEZUdmlNYjVTMTNjR3Q0Z0poQndnM09X?=
 =?utf-8?B?RHdRaW5pY2pmZkloK1l5M3REK0tOVkxMSXF5a2xrL1BNUGY5U2hTcmhzd0VC?=
 =?utf-8?B?OCtTRVVNbGdCUEJwaGJYZkpvNGhKYkZGTkhoSmFYSy9xeTJWUU82akFnM0xY?=
 =?utf-8?B?cXUzc3NVL0hQSytYaHhEREJNdThiMnh5V0FNZlB5Zk85R0VzTXF3MkNpdHpW?=
 =?utf-8?B?WnB1NVgzVm90cHVOaFRhWjVJaU41WHV2bVdxTm9nVVcvN0xJbXd1RDdGQmdQ?=
 =?utf-8?B?bHJtYldQTE1Zd2NtNThGOEwrK01DWEZoUXJSeS9GR05ZN0VncVNIV2JtcjRz?=
 =?utf-8?B?azJ3TjR1ZlYzWXcvVVZnNzk5c0EyY3pnQ0Y3VU1DQ1JMWmVMbmlnbnZxZldB?=
 =?utf-8?B?RTdRVlBDaTE3dE1XcDJTd1hkOWk3SGVNK2RkWk5yTkpENFEyWTNqNmVmR2lu?=
 =?utf-8?B?bFlHQ0hUNkF5b0ZWU0pvbXBVTUNtUzhaVFByTGpzczd3eGpBUmxiK1l3eFpi?=
 =?utf-8?B?dEM4eWpSWmF0MjRwa2FZT2hwZTNlZ3EwRFl0ZndwSEwvbXFxWTBCODNMVDll?=
 =?utf-8?B?VTdwRk1YVkhZcURpclhibWYySmJLS2xYNGh3OWVDc3JNRFkvdGgwRHl4Wmcx?=
 =?utf-8?B?dGtBZ3FRa0FIQjBGdDd0cWE4Q3FYS2xxTGVZNGJESFcrS2VyMG5SY3dkOXhs?=
 =?utf-8?B?c3ovOVNKUlViWTBpMW9XVEVGSFdWTmV6amw3Z3JmeGQ1U1daWjk5TVcrcHNE?=
 =?utf-8?B?aGxoTmg0M0VSc2NQZkxXZWtxMHlGSmdjUk9FWkYvYjh3WGF5c1RpUzI3cmt2?=
 =?utf-8?B?Tm1IOHl5VVVWSk96eVVUUmUxdndvWnEzYldVbVlEeExuaXNveGMweXF1Vjh2?=
 =?utf-8?B?TENVS0t3dnB2SWVrTXdQYmVNL3BwZVBzYk5BM2grL053N1d3R1F1U2ZiVitk?=
 =?utf-8?B?SHJGRzF1eXFEU0pXcXRwR0J0NkRkZEZWZER3Ky9Nb1E5d3BNMjRMeUpaTDNy?=
 =?utf-8?B?clFaWS9IUFg4blNubGJlUHdCK3FoVEczRUhQeVNzNXVhLzBVc0s1anRTbXAr?=
 =?utf-8?B?bmVYU0Y1NEVBcGlHNjZvelh2bDROOTl0d2l0SWN2VDZzV2l4RXZPZ0pJaGQw?=
 =?utf-8?Q?mk67MI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9512fd83-66db-4c96-9ff3-08dbc3ebf318
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 08:37:16.8612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3pKRlXExUuLSIeGDvq0tCwoR2GC08PnNcFQHm8npvXaCXiUXIJ82rJrJxWeSjcS3wH3GFj+Es8Cghk9GvDbaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_06,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030056
X-Proofpoint-ORIG-GUID: AxHjBfNKNzbUwfUpGeJbjCwQV4nRijQj
X-Proofpoint-GUID: AxHjBfNKNzbUwfUpGeJbjCwQV4nRijQj
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/10/2023 20:12, Bart Van Assche wrote:
>>  > +    if (!is_power_of_2(iov_iter_count(iter)))
>>  > +        return false;
>>
>> This rule comes from FS block alignment and NVMe atomic boundary.
>>
>> FSes (XFS) have discontiguous extents. We need to ensure that an 
>> atomic write does not cross discontiguous extents. To do this we 
>> ensure extent length and alignment and limit 
>> atomic_write_unit_max_bytes to that.
>>
>> For NVMe, an atomic write boundary is a boundary in LBA space which an 
>> atomic write should not cross. We limit atomic_write_unit_max_bytes 
>> such that it is evenly divisible into this atomic write boundary.
>>
>> To ensure that the write does not cross these alignment boundaries we 
>> say that it must be naturally aligned and a power-of-2 in length.
>>
>> We may be able to relax this rule but I am not sure it buys us 
>> anything - typically we want to be writing a 64KB block aligned to 
>> 64KB, for example.
> 
> It seems to me that the requirement is_power_of_2(iov_iter_count(iter))
> is necessary for some filesystems but not for all filesystems. 
> Restrictions that are specific to a single filesystem (XFS) should not 
> occur in code that is intended to be used by all filesystems 
> (blkdev_atomic_write_valid()).

I don't think that is_power_of_2(write length) is specific to XFS. It is 
just a simple mathematical method to ensure we obey length and alignment 
requirement always.

Furthermore, if ext4 wants to support atomic writes, for example, then 
it will probably base that on bigalloc. And bigalloc is power-of-2 based.

As for the rules, current proposal is:
- atomic_write_unit_min and atomic_write_unit_max are power-of-2
- write needs to be at a naturally aligned file offset
- write length needs to be a power-of-2 between atomic_write_unit_min 
and atomic_write_unit_max, inclusive

Those could be relaxed to:
- atomic_write_unit_min and atomic_write_unit_max are power-of-2
- write length needs to be a multiple of atomic_write_unit_min and a max 
of atomic_write_unit_max
- write needs to be at an offset aligned to atomic_write_unit_min
- write cannot cross atomic_write_unit_max boundary within the file

Are the relaxed rules better? I don't think so, and I don't like "write 
cannot cross atomic_write_unit_max boundary" in terms of wording.

Thanks,
John
