Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448856F0F21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 01:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344335AbjD0XiK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 19:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344283AbjD0XiI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:38:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617DB40C8;
        Thu, 27 Apr 2023 16:37:34 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RKPTj2015612;
        Thu, 27 Apr 2023 23:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=oZTyTBvyHrlX0MhfsXt1FDkK8RcryI/p2Su0A9ZteVU=;
 b=B2mfZCSZeN+ooZXL7kA1MoGyB4f1HRRKfFIbiNxBJX23/cR0111aJxwnZRaC2ZiEiX/w
 /n9GtrAFbuex/svUMZdFaDseiRwnUxL+cyG97YP/Y6YprzlZleIerrJZUJF/Nmu91KFI
 KbXwQBJxd5VzQVhsQqQj5ZdEYLq7IdEzm/QAV1IBvp4H5lKB23U7guhDjVkr95pLAAu9
 e6xbDZkYHTOr/vpV54xgw0fTHHbcvucAt9CcwWZVz9wnF5FtZnlV8+dLy9f4+WqhZgbL
 7R0UJq0gRbCG6kLeDbe99HzuAiLgcw3Nya3We3JIJLcSUlem3CDq7mINWptSu6XpaqYf rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q484uw53d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 23:37:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33RNBAkY024855;
        Thu, 27 Apr 2023 23:37:10 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461ga6ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 23:37:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efGpX2jzLxOLGuFMBVquMusc+gozYVau2kWTBTs2YXxUxehvl+iWGZV85KtJD5xh5xihjzPBJiTlPG7ax9iGohqMs2RG8sT47z4qqecSZiKAT2A4oklfxFp13LIHyijaZEL4PM4i5s9C6O09thDx9kZQDwfWV5URC9cz6KbidgpakmF+TkGYFMnZi0ylyCcyXPMm7KXHXWAjpN4Cegf241MZJpSIdxyq3PXImB7DoG3QcyLhiSWDHop6e3eruAWzxkoBVv53Xj7kftr9g/E7LhDc74Laj0oVkQmHMaIcyLq4/G02965FZYu8eqMZdJEYIq8LcJ6hKz4JUhRF7C9Cmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZTyTBvyHrlX0MhfsXt1FDkK8RcryI/p2Su0A9ZteVU=;
 b=kzDI+lzvHGsuv/AU5HGlJagqKLEKtqCCuHYEczOJxh3Szbj3/KejzyupybSt6lrUKsZ1Yjz+ePIJiybxUVoU+jfLU088rTGxU6KT6DNsBmqQ+IBUYhXOsyMKK7hMfH55NWvAhO4zaRB3Y8QSE51dEJE22VQwtWeE3rgwePepQ+9D42B4MShZP967LMAPVKmVqp87L7Jyxxs0uSWYvgiwa63Yx9J5B+vafQSMB6sG2Gl0YhwsFK3vGzzmYqyqPO+OjgKzkHIlVVI9CcTBSnWkwg86zaTNXQSZij6T/ydjKn6K0piwhypf1WI04qHrRGKFEgOSAWhTJ4hTMEgxZk1JzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZTyTBvyHrlX0MhfsXt1FDkK8RcryI/p2Su0A9ZteVU=;
 b=nJ+WA1GvPigkQNDQw6++lU6Og/F1pTPOKZiHaobeMUODbqW825FuIaKPH5G6speG2+wnYRGe+/6HvNFXExebC8lUkQVwScPIAZqYJusRkvHyajJNpcV+imVwtdUVj6eUc75X9OdA3+tuQKN1AYJJ4oLCmVGLyrsRzjXN/RMTRvg=
Received: from CO1PR10MB4418.namprd10.prod.outlook.com (2603:10b6:303:94::9)
 by PH0PR10MB6982.namprd10.prod.outlook.com (2603:10b6:510:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Thu, 27 Apr
 2023 23:37:07 +0000
Received: from CO1PR10MB4418.namprd10.prod.outlook.com
 ([fe80::97b3:818c:4f87:7b29]) by CO1PR10MB4418.namprd10.prod.outlook.com
 ([fe80::97b3:818c:4f87:7b29%6]) with mapi id 15.20.6319.034; Thu, 27 Apr 2023
 23:37:07 +0000
Message-ID: <a3c1bef3-4226-7c24-905a-d58bd67b89f1@oracle.com>
Date:   Thu, 27 Apr 2023 16:36:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] dax: enable dax fault handler to report
 VM_FAULT_HWPOISON
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, willy@infradead.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230406230127.716716-1-jane.chu@oracle.com>
 <644aeadcba13b_2028294c9@dwillia2-xfh.jf.intel.com.notmuch>
From:   Jane Chu <jane.chu@oracle.com>
In-Reply-To: <644aeadcba13b_2028294c9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0123.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::8) To CO1PR10MB4418.namprd10.prod.outlook.com
 (2603:10b6:303:94::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4418:EE_|PH0PR10MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b09f9b-9afd-44ef-2bb0-08db47784c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1K6h7SIzmjlkpesuxGmXmjuxzZJAA5ELxBMWHARW4DZjpdPR9qCt4GGirWzuCirJxQCQjrkOmG5QhMR0hH+vnEA0HLG5V5zSewuBqqjCLnrdEtThuk8MkNsIUVZ9/88DWZ4NjMDWQM2CkRkYnBvrhBn2YzzYkp4NzD21ytMEhDx1uxVOVkQ5fPT+XQIMQDaaJ4g2en4//roqGADJc2vEyjOg3ZCdZOi1Za8Ix+f+pUepghDf9KIZgbbJagQvvku775ZaaDodEGY/Cf1souVp3n56djUEiOFP+ZECmAmDgwy+OlNBdD6QWiLBaXS7RC5OCEpL1+nRAR9JXf1G9w4oiLb98BjVs4y2cH7R4/3iRV8GR+rps81AleVy1sZaLtRC3iRyCTVvITONsVsPXd2XzjXiPrXiCzRsfl7KfJoCzXU3J8ict2tfoZyyQuQN5uhsbnOFmySbTgICs/KuXoPrT5DGCgNJe2a5GRZI2xpDXMQ6AWrNgx8Q3YxzIuzdpWkpfE2sDDKDxepk5W6bz/o0oUxpCOsjzXunQcCJiRiPc+EHKRrXreiG+5WPRUCXLIY29GSzyyuz+Fvv0kqLDfEtFrGeWgkkNreiTkqoN6dTIAlc9NELp6kMXpE/QDNLO4kE3+Go8RzI+MrcWdDh1t+Kj0MjW25CRFlk1P1srs5ypgg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4418.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199021)(478600001)(6666004)(83380400001)(36756003)(53546011)(186003)(6506007)(2616005)(26005)(6512007)(38100700002)(31696002)(921005)(86362001)(6486002)(41300700001)(316002)(66476007)(66946007)(31686004)(2906002)(7416002)(44832011)(66556008)(8936002)(66899021)(5660300002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFRHVzdITCtxWEhydjA1ZmZGa1o5dmdrcnNYKzdLNFRXQVQ0S2szS3ZOajNk?=
 =?utf-8?B?THNIU3R2Mi9vU3RiZGFHSFpwOVJiRUdOdEIzeG5vUWpOdGxvM2V2TG1nRERG?=
 =?utf-8?B?QU5kMG8ySzliRGNyRHhxd2swc2RYVE43ZGZlNVRKUTRDRlpjNGxENkVYaGxO?=
 =?utf-8?B?TTF4VWRzelB6NFdHVEFLOEpZTzhoMGRzT2E0OEd1MFI0WjBDZnl1MVZrb0xK?=
 =?utf-8?B?LzJubVkwMGVMN2lvS3FwV0Zoc0hCQW92UTNGTXI1SWtIekVGS0w5cG1IdGl6?=
 =?utf-8?B?ejdSaVpxeDZMNEFTTVNyUkNZUXpKeUMyZWYrQmRDdVF2TU4rQ1g4cW5YUGlZ?=
 =?utf-8?B?N1ZrWnVuUDFvMCtPNnZ0ZDQxenN5THZpcThBZXFrQUdiTG9GK3NSSkNjZ0dK?=
 =?utf-8?B?SDUxcXlJaUJLMHNpSHVBZEs0SWpVemg2YU03YWd4WGlPMUFwS21GTUxGaWtu?=
 =?utf-8?B?RmlRNDlNM0JZVkFFc2JVTW1kdldqR1gzUlhMM2xaalRiZFBkK3p4QnVXMEY2?=
 =?utf-8?B?a2NPOWJSbUl3Vk9tQXVNQ1BPVU5PUHJTd3hXVmpHaXdad0Juem01UHd4cG5C?=
 =?utf-8?B?dXJnR1Fady90SEw2UFlqVGxJZDRudDVlWit3K3RhYkJTZVpLWWhYR3pSdFFD?=
 =?utf-8?B?Nm9xb1VYUTNpdTEvdW1CbHpqOVVxcWJ4TWVJNWxrTGJJRUdWNFpoMGxVTTFF?=
 =?utf-8?B?OUhsUTF5RW1SR2pxTjNQbnV6QWFjV05BWTdWK1FVQ2FIRVhnUHRwbllGS3Vw?=
 =?utf-8?B?d3JjMzdPYWJwZjFZNVFUTThzczhUdkhCL1NRb01aQlFlU1cwalJkTC9uYXpC?=
 =?utf-8?B?a3RLZ3lTU0F5Kzk2WTJEbHdzUDY5SzVZdEdVT0pCZ1V2OVRSZW80c08wN05P?=
 =?utf-8?B?NVhnL2R3K3ZqSHRMeWh6UWJEK2FMZTVUSmZNK0xyb295TWlMaE16V2JRWHd4?=
 =?utf-8?B?Sk43V3EwNGdWQm5CZkRTZFl6UVdUak1NMGJNTC9Eb0NMVkxEeUc4R0syL0Ny?=
 =?utf-8?B?eVRtWVg1MGtoY2lrYVFNVklJbFdLSFJGNWw5aW1jUkhGbU4zVEs4ZzUvR2VB?=
 =?utf-8?B?akNDcDZ4Zit0bThkc1NRSHZiWXFBNm43N3k0UjhlV051NEJVV1d0R01CVkg1?=
 =?utf-8?B?a3ZDZWVyTnBmem5IT3UxdzVmTjViMFRscVJQaDdIQTYrWnNoS295YmwrczFR?=
 =?utf-8?B?eEdibEhNRTQxbnJ0REgvdmt5ZVhsNEFoaXZQWVI0bExWOW91R3RMWEp5UkNs?=
 =?utf-8?B?M1cwWmJOVUl4WEtoKytvV0xhcHdudFVPcXNHdW9EbC9rYnR6WXh5UnVXdUI0?=
 =?utf-8?B?TnpPUWcyL3dEbkVpU1R5bDFwL2t5cDlUeU8rcDEyVVpYSHc1RXV3NS9pd0pr?=
 =?utf-8?B?bi9wNDJiTytNTnNhRkZrYWVBeTc2NWlzVG95MnlObitsaERYUWFxV0VPalIw?=
 =?utf-8?B?K25lVm9OUnZ4MTNIVEZhR21rbkpoeXZ0UkhPbHFnM0V0Uno0djJmMCtDYng5?=
 =?utf-8?B?WkdiTDZrQkkxRlUzbVpHSTZtVFlFbjFRUGN5SDA5V1Z0bFh0VkozYmErSy9Y?=
 =?utf-8?B?cnJ6QkFtUTBHYzJ0RlY3dXgvc1I3aUc0dmxHTlA0cEIyK2JkdGlRWkxvNGt3?=
 =?utf-8?B?ZHBYdlFOUHI4RzhDSDkybTE5SndvNXU0eFBjREpBUlN2R3paeGROMldjbjdh?=
 =?utf-8?B?czZWT0d4NG9hMVlmak12Sk16TUliMERkcHU1TTV4dVAzeTUyL3BqdkFWSXBz?=
 =?utf-8?B?SkpsaTNLUnJpdDFqU3lRaGZ5MDFsZlJGZ1owMDhlcFZjRDM4ZFFTd0UrUlZZ?=
 =?utf-8?B?WkdWMU1xSi83SWVweXhKYU05QndKR3ZMcmRCbUM5bi93ZnNNQkM2aHErcFc0?=
 =?utf-8?B?eTZGMDVwU2VjTzJJQVdUUnpmeVBGWnRIc2ErNFQ5K29MTEtDcjZKVURxckQ3?=
 =?utf-8?B?OTk0VVl4SWtYb1BMa0ViMlk3Mlp5OW1lWU1rVnIxZElQUDdlKzNlVVhlZndQ?=
 =?utf-8?B?VXUxeGFwY051YjM0M0dKTGgvQklaSFpLOVZVVW82bXNBTnhDRFFWLzdSemxh?=
 =?utf-8?B?My9Lcmt5UU5Cc3hSYlBxOUo4RGd5TGh5ZGVvVVp3RjdLZkpoSmpHbkQ1aVlY?=
 =?utf-8?Q?K0tuy6MBHtaUdw26KRqXeot43?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WlZvTHYyRkkyZUplUTFyck9JQWVIbi9HUGVzNkxQTzdSZ29VZFRJU1hIYkk2?=
 =?utf-8?B?bks5K2pYK2tEUlozZmNNbWpQR2FxdzJFaDJ0ekM2TEx3VEpncVpqTkMydG5a?=
 =?utf-8?B?Mk5zL1BKbWExRnJPSEFGT3FUTHd6c2lRVm9wMm84YjBHNzY0eFRvVjBDN1oz?=
 =?utf-8?B?OGVlcjVIalVURnoyc2RhWkVqMlBZUUJpL2RYS0Nub05BZmorUzNiRkU5bm9B?=
 =?utf-8?B?S2F6SnpnNkhSK1JTb3VoNStNN3dLOGRxRUJzSWoyQlZ0YzFzVnFDejhRSkMy?=
 =?utf-8?B?RGZLOFpGdlBLRTBVVDBpci9VVDlEVmpLL1B4czNpYjVKKzhwK2I4T3BMZy9h?=
 =?utf-8?B?OUI0cStWM1FVWjBsZC9nT3JjU0p6RWRrOHI2eHpPNi9vSENjcGx6aTdsY3cy?=
 =?utf-8?B?cXp2YlBGcjlXMUI4Wkc4dkdoeU1JU0M3RjVqYVJQR216WS9uWWIvMEJraUQ1?=
 =?utf-8?B?SmU3bVJFa2pXS1ZhTFJsTGw5VWhzQ09HMURqV2pXQ1g5SUJ3dFhjUlpVTElq?=
 =?utf-8?B?VEhFOVFhWm9ycTM3MVYxTDE3MXIzODg2VDVFT1FRNnU1cGZxdnlxdERxbldZ?=
 =?utf-8?B?UnVaUHM2bnhnbGRCL1Z5a3lGWGluQWo3LzZFWFZwa1FSWGo2N25USGFXaTRM?=
 =?utf-8?B?dksvajdvYnUwSjVEWHlGRE95RmNKRW95RjJwODVrRGFrY1VJSldvOVFzaTQ3?=
 =?utf-8?B?TktHTm56d2kwYThuN2ZuVHQvd2ZZZkRPalRHMmVDWTRoVzd3VVVFVUJ3b1Qr?=
 =?utf-8?B?emorTUlnOVpiNUpFLzM3ektva3dlNzhyQmRRSlVHclhMaitqVVpkYTRMNXVo?=
 =?utf-8?B?UlJMRUdnTTVzZWd3dXFjZWxQVHhVdXFLY2VQTUZUaFdHdFRFTGkzb1U3RkZC?=
 =?utf-8?B?bW00bGVFREsxb0Vad3diVU9LakdQT2pJNFFYclhLNGU4TXpCNkFFZUtxM2xz?=
 =?utf-8?B?bXZqRFFUZzNRanUweUdreGJBR0dXY25mTVIvNmtIZkRXcUFiOUJhRmEvc1Vy?=
 =?utf-8?B?M0ZCUmJhTGZBQU41ZC8vTzhxWmVlYWlIa2EwM29QUDZNSHJUSjlJaTJlekRF?=
 =?utf-8?B?YkVGZHMwWmVtcFIxZ3Zoc3pqcTV3K05qR05yamZkNlovOGNLZ2ZOcW5DV05k?=
 =?utf-8?B?bGFESjVHeDFCUXJxaGZaV2lNajlKelNxck15UFVpQlRWdngzdVNRNVFwYkE2?=
 =?utf-8?B?OHFjYVRIUVc1R3VDSXV2YjNOcXJWQlJZR2Y3NGV3ZzJ3NDNLTkVkYWJJUXly?=
 =?utf-8?B?NENQTTlKL1B4NFcwT2VKeTgwK0VEdlNBVE5ScmhMVUpMWGVEdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b09f9b-9afd-44ef-2bb0-08db47784c92
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4418.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 23:37:07.6812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZdz6SpgshWUyWLXSJddphkgRN2T0MQK6dihqNT4VKGDWoAaBAhOSLc+jGtYUL01WFo99AiQjK/BxrhxZp+6Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_09,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270208
X-Proofpoint-GUID: cNEJ8XTvEt0XEK9z8-MmdKsn9JpegQtW
X-Proofpoint-ORIG-GUID: cNEJ8XTvEt0XEK9z8-MmdKsn9JpegQtW
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Dan,

On 4/27/2023 2:36 PM, Dan Williams wrote:
> Jane Chu wrote:
>> When dax fault handler fails to provision the fault page due to
>> hwpoison, it returns VM_FAULT_SIGBUS which lead to a sigbus delivered
>> to userspace with .si_code BUS_ADRERR.  Channel dax backend driver's
>> detection on hwpoison to the filesystem to provide the precise reason
>> for the fault.
> 
> It's not yet clear to me by this description why this is an improvement
> or will not cause other confusion. In this case the reason for the
> SIGBUS is because the driver wants to prevent access to poison, not that
> the CPU consumed poison. Can you clarify what is lost by *not* making
> this change?

Elsewhere when hwpoison is detected by page fault handler and helpers as 
the direct cause to failure, VM_FAULT_HWPOISON or 
VM_FAULT_HWPOISON_LARGE is flagged to ensure accurate SIGBUS payload is 
produced, such as wp_page_copy() in COW case, do_swap_page() from 
handle_pte_fault(), hugetlb_fault() in hugetlb page fault case where the 
huge fault size would be indicated in the payload.

But dax fault has been an exception in that the SIGBUS payload does not 
indicate poison, nor fault size.  I don't see why it should be though,
recall an internal user expressing confusion regarding the different 
SIGBUS payloads.

> 
>>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>> ---
>>   drivers/nvdimm/pmem.c | 2 +-
>>   fs/dax.c              | 2 +-
>>   include/linux/mm.h    | 2 ++
>>   3 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
>> index ceea55f621cc..46e094e56159 100644
>> --- a/drivers/nvdimm/pmem.c
>> +++ b/drivers/nvdimm/pmem.c
>> @@ -260,7 +260,7 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
>>   		long actual_nr;
>>   
>>   		if (mode != DAX_RECOVERY_WRITE)
>> -			return -EIO;
>> +			return -EHWPOISON;
>>   
>>   		/*
>>   		 * Set the recovery stride is set to kernel page size because
>> diff --git a/fs/dax.c b/fs/dax.c
>> index 3e457a16c7d1..c93191cd4802 100644
>> --- a/fs/dax.c
>> +++ b/fs/dax.c
>> @@ -1456,7 +1456,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>>   
>>   		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
>>   				DAX_ACCESS, &kaddr, NULL);
>> -		if (map_len == -EIO && iov_iter_rw(iter) == WRITE) {
>> +		if (map_len == -EHWPOISON && iov_iter_rw(iter) == WRITE) {
>>   			map_len = dax_direct_access(dax_dev, pgoff,
>>   					PHYS_PFN(size), DAX_RECOVERY_WRITE,
>>   					&kaddr, NULL);
> 
> This change results in EHWPOISON leaking to usersapce in the case of
> read(2), that's not a return code that block I/O applications have ever
> had to contend with before. Just as badblocks cause EIO to be returned,
> so should poisoned cachelines for pmem.

The read(2) man page (https://man.archlinux.org/man/read.2) says
"On error, -1 is returned, and errno is set to indicate the error. In 
this case, it is left unspecified whether the file position (if any) 
changes."

If read(2) users haven't dealt with EHWPOISON before, they may discover 
that with pmem backed dax file, it's possible.

Thanks!
-jane




