Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B802A6FF3CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 16:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbjEKOP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 10:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238186AbjEKOP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 10:15:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D85DDB1;
        Thu, 11 May 2023 07:15:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BDwwLC027079;
        Thu, 11 May 2023 14:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=By/DaJErkEslB9LAMa4QWUN4ypA+0K9nJyrxf06BNxA=;
 b=y3GrcubuVB6y9Cz0Vo8xqmXTnAKg6LmqqI5MIhmIIr3K1oNwEQEmMk/u8boDdSiQRH+F
 hABpwzpYCH6IozcLTjPyeID1KKIedDibqVJbcAVorMT4TKU5zviPSRbCt8xh305n0P6f
 VRwMmE7TI22LAS5pkjGj3U1aI+YMYwcHubTim/C0NX6ZvsAVzlsV2MP2ItmV/Fs6WxiD
 V/dRgxiqLuY1Vyhzs4iuHLnR7TDHDULxq+EM847KZMuFoqbqGpW8Rv4uQWlBKNpc+Wv2
 Knc1qfTKWQjo0ZkVBKvMtUWFP6vjxsefkhXGpkdv9fcq15mZkyJGNiOUEvPHrKP/O04c Lg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77g7bta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 14:13:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34BDCelF011546;
        Thu, 11 May 2023 14:13:54 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf813g2p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 14:13:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyARP9+drh9mv7mqYWFdssQ2C9DRlkubx+W55H4/+tgCaNIBnAbHiGdb4+FSGtwaRQ7Sk5zlhPbk27usauyMZ4IiEzsw49Qjpif75cjLvn2ZpcpDp0NRQxepuYgAbI1atisOhGa/WuoDhbA1YA54wADpWK25XYl8Ai+y58bA19Bn4xs1KPnAcgznvhNEzE6lhsZBEyrISAMf/T6NX/4zuwgzt2qVVzEvbKzFelU4loOSHwP7PrvYNAEMY+h61VT3horjbkwLE0NscFldvuC1/aR2FKYM6CMAso5F1yZzc/E0PbRRRzf99SMHIyR4WAF9w1KXQbSACwnke+80gg/iPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=By/DaJErkEslB9LAMa4QWUN4ypA+0K9nJyrxf06BNxA=;
 b=OANG6EeecKewhTsZxgSn8C8iiRxp32hFkjY9NiqP4tVmLPqE2DwqmbR5di1NtqvqAySP5LDe3j2p8VOmOIJ7o0dqCt1KwGY6zXmqvs83FVK2MfqHi/HxZbaleMC8eMvKK6EDovkuCb3AJOMb1Nwa0651wIqCzv9eea4UAnaqnLqKleGNomuUy8cXxl7/Y4Tenm3SGyjHkpu6uvyokOlwuWEppWkpuE8o+5KvlNyeLr9s1jQycpoPO7BGtK69ndQTSaonQ8tkaaefm9qtsu03+agv2w+n7H4NfHgzXA7NBDfz5O6gBXiTRSJshAQ1ba6MQ7ddNNX1QKLaU1V5wp4kkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=By/DaJErkEslB9LAMa4QWUN4ypA+0K9nJyrxf06BNxA=;
 b=dQFzrUyi1qa7twqqbbqXnD2OC3DvjjWcr0WcWF4joEmrtdHcT1lf7sks9500THzoBXjij/F3o71efssIhnlR9eKU+/elH5TTAKfrhSWsIbyaFnV50+k6e8YSmYjsOuaNIbR4qjqaxN6ydJG34VwlPmZxG+IHxt58dDQdQJd3C9Q=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4405.namprd10.prod.outlook.com (2603:10b6:510:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Thu, 11 May
 2023 14:13:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%6]) with mapi id 15.20.6387.020; Thu, 11 May 2023
 14:13:52 +0000
Message-ID: <2bab0cae-d249-376f-1a5d-bd4fa4c95309@oracle.com>
Date:   Thu, 11 May 2023 22:12:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
 <20230505133810.GO6373@twin.jikos.cz>
 <9839c86a-10e9-9c3c-0ddb-fc8011717221@oracle.com>
 <7eaf251e-2369-1a07-a81f-87e4da8b6780@gmx.com>
 <20230511115150.GX32559@suse.cz>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230511115150.GX32559@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b52c8dc-2fe2-4c74-fa95-08db5229f262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4RWykIohsYvMvTi5hEjSaeNAl+VD4MlG1ZOUZMdMnO6kdTogjYFNqMBH4ol1AnWW1qYLocRDWQNQrM3NWw5HrZf5TlFTT/K/ppYBn5ewGiikjXjAYsI/cqt81goCjgU4OQ/DcYAdH43puysdzFKEykvcYyM1qYWaHNHVZoOGjJQEO66cvuNVSupf6eoziKdlqXtvGzIDKoxEGIO57PcKsrdz++57sWGywhmTg1WgUvXhteRsrK3yif01nYJYLPevG0vHsVc0LfzW5CbS7j/0BgWN63U92MtJR0BAwpB5GFWGcrOZ3FevsVQon4UIBt2vK4AIYdJwRWfjspB5AvVTHsFF85VsJyOFNEwIQ99R7shKBiAWb3z9+OkHie5eGKDDAgyFtnsUM4OZbtfkeSkInVgoiT/ND3bC1p3mpYmtmDDpRj1SvJx/iB0L8Ie1znCr7/UE/AtRIx3ulCOPh80sWYZL6eu4UEN7wp0MBnn1vczstiFwuAmwPI2RD1sc7Ni1RrMbSTl+YnH6CGkgrI/E4ozfghrGQkyZiPl6p9rR35dU8cwe0jliEosuCvk/xCA49uKJgLZNcAC8oEpUEs7R5nKbTzf42UTQjwl3JLUWFCr1vPtWjzmmt5a0c5Zfmlmy9cP2GHzJwK45gbCDo961fA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(31686004)(66946007)(66556008)(6916009)(4326008)(66476007)(478600001)(6486002)(316002)(36756003)(86362001)(31696002)(83380400001)(6506007)(186003)(26005)(53546011)(6512007)(2616005)(41300700001)(5660300002)(8676002)(44832011)(7416002)(8936002)(2906002)(6666004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czkydXcvQjkvUlhLNHFmWWVCL2I4a1RvTjc2NWFPelJlbVdyQkJ0MjMwNHE2?=
 =?utf-8?B?VUdPNDhQVTFrWEluUk1hd2RDbUFLZ3VmZTFLakNpcVRISDFGK3EyQ21ZRUc0?=
 =?utf-8?B?M2k3WmMwVko5aVBib3RncEowOVUzVmYxTkhTdmtFQnJ5dmN0TyswNHhTOHE1?=
 =?utf-8?B?bHQzQ3JKN21YZ2U1SFZuZkxmUStkK0RFZWJMdjVuajB3RXA1YXJKdFdmbk95?=
 =?utf-8?B?dExvZU0vNUhWUXFMbVM1Y1ZkMDQwUXhBV05SRk41dWZyc1JPRmVLZitsRmZD?=
 =?utf-8?B?UXNqeW83cldMRnV0RFhSNUtaSmQrRzJnY0RZYmdXTzJBK1BoMWhhZUpLUGI2?=
 =?utf-8?B?WTJtMzFHUmpPR0RCQ055emF1eGJrVG9XWmxIMkRWUkd4T09wZGl0b3dzNVBP?=
 =?utf-8?B?K0J4dlV2akhuVVFkcVNpc3J2cjBEWlVzb0ordHpQOU4zR1MySUxTZnZFYW92?=
 =?utf-8?B?Y0FPbjZ4c0JnUlA0VzZsTnlTM25VVlJxOWZXd1hIVlJzbklraFhJTy95UURv?=
 =?utf-8?B?Z0VvMG5jS1ZZSmEwaXA0SXFtT09uNUtiT29aTHdrMG9rYkRFVWpwTFk4RTFo?=
 =?utf-8?B?UXB2UzdCUi9ZemdGdExqanNmZVhseEsyL1pxVHNtd0JmdlNzeEYwMjdHS2pp?=
 =?utf-8?B?ZXFoeGcvcFR0bHlPQUd5djhDaWd4dUdaekpaMHdld3l4cEJuREl0aHNMempL?=
 =?utf-8?B?dUlMQzR0ZVU0UmJlaXhLTmNFVjJXaFFYbHdvT0xHQUFSSGV2eW9KQnE3ajEx?=
 =?utf-8?B?eEswdmliQ21BS3I5YU5IclptWGZpa2ptYTRqL1ROZm0zT2pFV1JkRkszNHRk?=
 =?utf-8?B?Q2lsZnZNRnpycDd1dDlxTVh1OTl2d2luT01CeEczM1NPUGdDd2c2M0ozZUIy?=
 =?utf-8?B?V3hpSWtMRnYwcnJqcjAvMklDTi9RTjJMK2lyUWc3UlZFOTcxUmtyb3FxUHRu?=
 =?utf-8?B?R09rZ2ZMeGhOaDJhYU9GMjN5UUhicU9jT3h1d0QvbFNFcGw5eHNDeEFFZUlx?=
 =?utf-8?B?ZktWUXVhQ1pEdDFWNmNCRzN3MWJZeDZTK2luNktzT0lweEFLWWtjZU84WGlr?=
 =?utf-8?B?SVRUZGJNd3RwSlladlZZR1YreUJaRXV2S2xhVy9LK0dSZUFFdjhyVmVDWDNq?=
 =?utf-8?B?MzRTQmVNalIwYWhWWDg0ZE91SDl4WEZpUzlQd25ONEpvWmZtQ1JaRENacHY2?=
 =?utf-8?B?UmlaMk1RT0hHbEdzUEdQUXAxZmpHWGwwdmp3VFNYbEphQUhjQk9RMGh3WnVj?=
 =?utf-8?B?aTh2ZytUcThndlYvcStPa1dMTXp4bnBPODViak1kYjhKM0h5N0VBSUFrV2VI?=
 =?utf-8?B?bC9TWlZ2MDJVSjZiaG83Zk1nY2JmMFJZeXFDYTNXTmE0TVFpMEZsZWQrbXdD?=
 =?utf-8?B?WHFJekovczV4bkpuNjRpT0J0TEVsd3lITkN2bTRnUnNSQ2RGNGtyS1FJblhY?=
 =?utf-8?B?Zit6M1ZUV0VCTGdTOFpHeXZmWkhnV2tCOFB2SElxcVJuYzZjOS82cGdzejdj?=
 =?utf-8?B?Qm9wd3dZS0FqV3A0eUdESlRBMzlXSmZTTk5NcXV2VmZybkJyUytsSE9JYjN5?=
 =?utf-8?B?V3B0SzFVK2kxZHVZQWJjTkpRRU5udUk1bVoyVW1nTFQwekhoTWhCM2gzR09P?=
 =?utf-8?B?TTZqdTAzT2NPeVRGMmxmUXZ0ME8yYytVZFR2QWJSV3FYNEhLemVOTUozY2h6?=
 =?utf-8?B?amJVRGs0OW5sdEkzc25ZV2g2SjM2QkZmcUZLVUpPZ2NyRUF1OUd0M2NoV1pq?=
 =?utf-8?B?RWh4Z1J4cjJFemowbkRqejJBSEY3WHhSSkN1YlZhZC9qUE8wQldrR0t5WGhE?=
 =?utf-8?B?Z245NlBmQXZlN2I4UUNnbzRGN2pzS3FzY25hSERaK0lsYU1SMnVyeHNlQ0k2?=
 =?utf-8?B?SHE3ZlpNK0VWSG5YTWVCTExEQmNtK1hLOGJBT20wQnpQTHlSZzJMN2pYMi91?=
 =?utf-8?B?dDlJcmhsclFRY1Z0VlJxZTlFUDN6TnFralpFcE9nd3k2MW0waENZUFRva1NH?=
 =?utf-8?B?QTVaU2owaE9DKzM2UlN4T09DSEZWcE52UWhjZDQzeE9jSmxvZGRqQmRmaUpB?=
 =?utf-8?B?L1hDWTJmVUpTTTAzZHVRcW02VjI1K2htRU5Lcno3akhJUFVSY1RtQU5xMHgr?=
 =?utf-8?Q?rkf2NUpGVrliMbtYwp1/CRpLz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Mmlvb255b2dheloycTFURGFvbU5xQmJJZnZWSGxWVXlrN1A4VHU0L2ZsRWZk?=
 =?utf-8?B?QUFhODF0MU5BZkVxVDRoWGZydDQ4RFExWmo1cE1paUM4MkQzYlduY1Z5MVBa?=
 =?utf-8?B?MmpLK0hFcU9uN011K01uQjFUK3hOcmtxZTBCenpzbk5lcEg2aVo0SHFpQjRm?=
 =?utf-8?B?L2JMaUVXL1NWNjMyeXF3NnJISWdWQk5JQWRkWGoydE00SWZ4S3NVUUtqNmZz?=
 =?utf-8?B?cDY2bG8yZS9uM2l0R3R0R1lPQlBDTXd6QTJQamxlOVlLNVVFT1kwdHFBNW8w?=
 =?utf-8?B?VGZDRzRZZmk5SGxWMnVKdDIvTlorSGt2ekNTODFHU2xBb3VITDJXZEd4eTYz?=
 =?utf-8?B?blY0QXl5STNMbURvbFlrUnZsSTBLMVlQbnF4MGJjZG5iaFBhdFNhZWNmMlZK?=
 =?utf-8?B?U1lhendtbmlGRUZ6YzhnY1ZERlRmTHBwT1h0d1d0ZEdxUjdrTk9KeVdmaDBW?=
 =?utf-8?B?SFplaFQ4ajcwMFJrNTc4NGhQNXYxTVVwV2ZEM05XQmNsQmR1UzV6S3BPTVJG?=
 =?utf-8?B?YkNPWUxDbXYzYVlsYmhvK1JpKy9zcVpnYjlUV0lpdFo2MHZmOEMycDh3QkE1?=
 =?utf-8?B?Y1Y5eGxNU2NlTkxiWTBSRE0zMGpQbVZqb3lwSGRUZ3VHcFlaZUMwaEhaY1Vv?=
 =?utf-8?B?dnVNbEtaOHFkRis2WTBLaGExdmJLRWxGUVoxckw3OW5ycUZWaDFpZ25LSERX?=
 =?utf-8?B?ZTF3NzVaTHc5bERSVHBQN2tGbmtFM3RuSjl5cG5GRldkY281ZDc0c21KUVlO?=
 =?utf-8?B?azVQZ2NsOFFYTDVGT3hCaGdNVUVqTWN6NjlYa3RlZlhSMFNxRUdWR0tGZkw2?=
 =?utf-8?B?cmtJSzRDei85Uk1jTkxhQU9rS1UvcWVRTDJXbElBVHBPaU5MclVHYXduR0NR?=
 =?utf-8?B?bXN6Wm5XSTM0NFV3ZGF0bGU0NEd1V09vLzNxQnZPdkN0ZDQrN0FqQ1Npajg1?=
 =?utf-8?B?cTk0OHE1dHlvM1Z4KzBoc3ZGQ1FKNFJtUWltTnM5R1VkQWJqcVIwNGxJT2JV?=
 =?utf-8?B?cFJ2N1kreVJHSDE0V1J3R21mams4aTkwV0NuMmJzTzlWQllUUGtlTWxMSEZ4?=
 =?utf-8?B?ellidHBDWW9KYTlPd0EzU1lUZTBGcUxKY0FJOFVZWXRGblB3T2RxcXltMnRW?=
 =?utf-8?B?R0dab1BqQnByejFTNVFJVnFnNGkzUm03VVNkZkpoQXBCd3ZiYkVxK2h0UUtK?=
 =?utf-8?B?OS85eEtGRFRnVU9qZHAzazE2UTRtK0dKOFdURnViWllLMmgwMG5Dd0NWM3RC?=
 =?utf-8?B?RE9kQ3lNRmNMQ2NCbnoyQWJBWW1oaDgzdzBveFpzODR5OWFsbnp6blBNOW1t?=
 =?utf-8?B?bkpxU2xBTGFPWkhPRVpyUDBoZzRCRmxNQ3RZWU9vZThRNkpWTzFaTFc0d1lP?=
 =?utf-8?Q?fSqnJHcLp9tAYoexl8qH7odtY4dENEHg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b52c8dc-2fe2-4c74-fa95-08db5229f262
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 14:13:52.1096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4btCmFlPMrRo8f9RseW45Tlo7ohIlsQUOzdj33B8rzvGVO7OOkA+yEkQaaDwXsaL4bS7w2tBha0pZMSWkky4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4405
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110123
X-Proofpoint-GUID: CNti9T7QL6NmgyZu6kDxGuNRoNRXXpxb
X-Proofpoint-ORIG-GUID: CNti9T7QL6NmgyZu6kDxGuNRoNRXXpxb
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/5/23 19:51, David Sterba wrote:
> On Mon, May 08, 2023 at 07:50:55PM +0800, Qu Wenruo wrote:
>> On 2023/5/8 19:27, Anand Jain wrote:
>>> On 05/05/2023 21:38, David Sterba wrote:
>>>> On Fri, May 05, 2023 at 03:21:35PM +0800, Qu Wenruo wrote:
>>>>> On 2023/5/5 01:07, Guilherme G. Piccoli wrote:
>>>> This is actually a good point, we can do that already. As a conterpart
>>>> to 5f58d783fd7823 ("btrfs: free device in btrfs_close_devices for a
>>>> single device filesystem") that drops single device from the list,
>>>> single fs devices wouldn't be added to the list but some checks could be
>>>> still done like superblock validation for eventual error reporting.
>>>
>>> Something similar occurred to me earlier. However, even for a single
>>> device, we need to perform the scan because there may be an unfinished
>>> replace target from a previous reboot, or a sprout Btrfs filesystem may
>>> have a single seed device. If we were to make an exception for replace
>>> targets and seed devices, it would only complicate the scan logic, which
>>> goes against our attempt to simplify it.
>>
>> If we go SINGLE_DEV compat_ro flags, then no such problem at all, we can
>> easily reject any multi-dev features from such SINGLE_DEV fs.
> 

For a single device, if we remove device replacement and seeding for a
specific flag, scanning is unnecessary.

> With the scanning complications that Anand mentions the compat_ro flag
> might make more sense, with all the limitations but allowing a safe use
> of the duplicated UUIDs.
> 
> The flag would have to be set at mkfs time or by btrfsune on an
> unmounted filesystem. Doing that on a mounted filesystem is possible too
> but brings problems with updating the state of scanned device,
> potentially ongoing operations like dev-replace and more.

Setting the flag at mkfs time is preferable, in my opinion. We could
still support the btrfstune method and/or online method later.

While we are here, I'm taking the opportunity to consolidate the
scattered metadata UUID checking, which has been a long-standing
goal of mine to clean up. This will make adding multi-UUID support
cleaner. If you have any ideas, please share.

Thanks, Anand
