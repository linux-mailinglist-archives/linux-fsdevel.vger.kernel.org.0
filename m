Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0D2679CAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbjAXO4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbjAXOzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:55:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063D186BB;
        Tue, 24 Jan 2023 06:55:53 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OEnV1c012323;
        Tue, 24 Jan 2023 14:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ESoiRzvKE5fe5goJWflj4v6TrbgZuREyCXjA8kWD/M0=;
 b=cKwgCg1YBqa9bwaNgN4x/tF8DMiZ/mdUwlFczFJz/jTHuxG4SvAGjCEmsJIQgeoj9WCL
 G4EeekofdnpJTxNH1OE5U7zDYjkiJ8XTIr5uXO8U6D94cykzlVI95muuPoVx+vtXOAEV
 VSqcMX3bDddH+kIeiLaFvt3D9Ny62cUox6e7Il2I59T8bJuCkp81hV0Zwhs/mSfIKTLc
 Y6ziSXuWCBT+XYNwQjQdg8dsCz0qgcvr29/cAl9AVYlQaTzR7NSJIstimwii1wvgHf5/
 zPfCcbW0O/SWBwj/6hXKoMwpSa+VFTjAsGqHqSlmpRhUqcqaqgu/LV+Nq7gv6EogesRp 3w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88ktwcw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 14:55:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OE4RHv025286;
        Tue, 24 Jan 2023 14:55:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g4h6ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 14:55:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2wwEQktmTVaX/t68SDTA8DgWHwpyzOSmOLhBERs+QD9DdERxvprIWLL1vpBvaFmLUQ4JgkRTRx5F6nfrYJsMQIQRQutNB02ntNOSNyMcz5W0INyBojKQLYANZYTeHHCdAmawhXLtDtxs0YgX/HmDX/FvwHMMnXSXBJgnyShJ/3eye97bA1wfGoxmwJkQVPFN6NygXTnerua41f2fLb8Gfb/eQeoDvO8W2PsVTNcP3dP4Iot+krgezvmT4/rEt2Q+u0tv7nAdkq9nMziRQxj+okYfoZjHOvzbUDSlaZAuxl/G8V2pnJBfxCrH17MUxDUuypIY4edSt+gwCW8gb47zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESoiRzvKE5fe5goJWflj4v6TrbgZuREyCXjA8kWD/M0=;
 b=bF6b/JLwyFTwGv6UJXPei0t7kTC9CTGBClkv+xYM+/hFJeEal6YHLl5in0ijYuEeHzuqzacT43wMC5LywE+F2nIITyT6PnKVJlGShl1O7605/gBZMTMYY2ZTUHyQ4NIyKXYFv6rEEtKFmwDtzEDqiqoYLKUO8bBIdG0FJ91QErzbVAFFqEEwkjYCZD6NXlNREdUnOczPfHXstdv7ZVm+SgGU52z19a+ajfDS5R4owBFId3BqElgGDFrOE02tPhEBKLo1ETKrcV6GXsQFip5DhyBqnL9sxRamf4ikMqYUmtIt/LM/cc6wHfrnTlyUUplT6bASL47cTQla/fHmqjyCSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESoiRzvKE5fe5goJWflj4v6TrbgZuREyCXjA8kWD/M0=;
 b=ho6KTIl54gVXYPxfI4QJ1IUmMF4sSk/z/qU2dm2D7aeFyZVjnDNRVxPHZpZGtWO2IPqsJdmOKy0XIqBxi0OfJXR8feNovi8px1t2bVkNn+PElfj3TdouEk9Pfixw/3cx7Y3Rr5tCHTr7X4h3DwZOwf/tNZt7ahpSxI8myWDcRl0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6230.namprd10.prod.outlook.com (2603:10b6:8:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.17; Tue, 24 Jan 2023 14:55:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6043.009; Tue, 24 Jan 2023
 14:55:34 +0000
Message-ID: <1f02fc92-18e8-3c68-8a31-36b4e4a07efd@oracle.com>
Date:   Tue, 24 Jan 2023 22:55:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 04/34] btrfs: remove the direct I/O read checksum lookup
 optimization
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-5-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230121065031.1139353-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0196.apcprd06.prod.outlook.com (2603:1096:4:1::28)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: b3dd805b-6fdd-4126-845c-08dafe1b0bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZW9Ix6J02dj5MrieCxrUxEZxIkesebK9ownb5DWiUCt2vnPzIk+4NT+KIabLoIZk8Zs3VfcIUxZOVYIKf0Qdd5Z9F6+biToC6SNFIxkguEoDGJuKQPqN5fZakDcYAb3xzQ8bu7zKYOvfMv09TU7oxecnAatRaHv8vfjaRiZHO+6kzLSpaT1DcJvSMbOVHEg6koZiup+aQb0NQKpYuH/4mnHFu5RhwJ1PEHK+MLx2VmB06gNPEkERFdbCXuUshNjRDTAXR38FLWbH/qAhp9trZ9mX9QntNOU3TtLtX2fmMbIlr7ho1Ifz6+wAXGk5LG3qlwdq+CgahThoool6PSsGRZlULkbLpaaNkUl5iLmb5MUEyrJ42Wxe8pjNVyJfd9gVcyEQqOXdVa0GGT9CqkNCrf1VkjyUjJg+Pht+rSV30iknbkDISvFJB9wmqwbL23qzFJ8Hw5HBt6gbN/W6Tg02J74LNpY4aM/eh7tk7u42KmlyPQGDH2s57oJntTB6g9DvvBT70MgulMAkSriryig0rAxpun2nkQ3HwsVGOk7ki2Hig3FX30afjZNu4QT+X157/lenXJRbOQ5qD++1LO/gtHjXi5Qvn9j+xtgS755gwMlOtxk4jY4PBtETqC786xNhfBB6X2sZtTLaOmB9LneZ8FU4WDPqF8L8XsePPGw6B2RvL6rpdBC5NEQhg6BPQ14qQgOHyukiT9uVdSUnpOzoiAHkiiX+PWZOUXreQWugCyw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(36756003)(4326008)(8676002)(66946007)(66556008)(7416002)(5660300002)(66476007)(44832011)(41300700001)(8936002)(83380400001)(6486002)(478600001)(6506007)(53546011)(6512007)(6666004)(186003)(54906003)(316002)(19627235002)(110136005)(86362001)(2616005)(26005)(31696002)(2906002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akRtalhub3JJUVQ2VHU1VGF0d0RkNGdQcW1VTHZ3c2s5SG5YYVM0bzljUTlU?=
 =?utf-8?B?dWtGZTh1WU1RZ3ZUZkFacC9hMjBaRUtIdDU2YmxWT3FGNWg3RC9NZ2VMOWhZ?=
 =?utf-8?B?VU8zV1NMd0xOK2ZBMXFsTXlJVjJTVTFkME9YYUlBWVV3WlZBejV4STNUNjM4?=
 =?utf-8?B?blBXS3YxeTVjWUlRNEFpUDJTN0t2UTdBTGxCMmgxVUNybDhPVm94VmtJbW16?=
 =?utf-8?B?UXNjSnJDcGdNdUxURlNwRE5kLzNiRFphS3ZOSnlqdWl1bjEyQmJFcW8yYXNw?=
 =?utf-8?B?UXVnM1FmMEtOcERHb3hIYkoyL2N6Ui9WY0tIaFdSNWd0azgyajdHUXl5dnhY?=
 =?utf-8?B?aXBNVjlCbmZFV0ZtaHc2VWZ2SUlicFRRQW1vZi9SbjNIam1kY3kwQ0dUYkUx?=
 =?utf-8?B?WnFWYUxycEtPaDNrTndlSUJmOWRkdGU2WUNOTDF1SXdaT0dPK08wOEFxNGNh?=
 =?utf-8?B?eVl4Y2o5N1VXM0VpemZoQ1VJbmdpVkp6MG1iVGVsRjZPUUJXSmQvRExGQzFt?=
 =?utf-8?B?dFZRdklkQmpTR291SXhqdFRGeXh5NGd2cjZvc0dGZHRjajByRktYekdkUzRr?=
 =?utf-8?B?dVgzY2FYenR2eFAyYXdwSHhWWWRPRHJxd3hBdXNTSlhvRnpuazZIZ2laRHNC?=
 =?utf-8?B?QW8zcVR1bUtiR3BQTHZzK3VGbHl1N1VLYWZLc25ZdnhSd3BXamtqODQ0elBw?=
 =?utf-8?B?RWhRaExtaldmUGRsNmtZbDJVbTUzSWxOSVVIMzFaOWNZODkrQ2VMMlZhRHMy?=
 =?utf-8?B?Qnd2ZXpaUkhtWEg4aW9jV2o1cVB1OWxNc2RsTkZ2TTEyUWxMQ0MxVkdHSGE2?=
 =?utf-8?B?K3JtdjZlUDRYRkdVS0RjbGxCaGZweWZSWXRJRGFvZjY3ZUtqRkx4YzRaamhI?=
 =?utf-8?B?TlJRZ2c4SlI5Njg3TXZIblcrYjFZVXUwTmxZVC9JRVVHbGRTUTJzTzNpcWtZ?=
 =?utf-8?B?ZDl6VDNMYWpva3E2b0JvcTZvcTk0UE9UNWY5cHVNTDdJb0E1SFprQ21KR1Nk?=
 =?utf-8?B?dzVyU2U5aHdBMnhUanlKMGgvd2t2OFp0QWJFME03MGpmZUxmOE40dXkvMkF2?=
 =?utf-8?B?N28rZXBzVExDaTBNakNLK29vM2tXTjRkVHB5OGF6WXhpMUsvbHhjUjk1RUlI?=
 =?utf-8?B?UXFJblJ0aTVGV0JjVURmMUx1MlVjbFFVTjNScXh1R0pyVjNCcE0zZmNKcFNZ?=
 =?utf-8?B?ZlpuK3BGV1BFMllzZ2Nya3VHR2Y4YlB5c3lOU0NyV2x3MkROR2creUdpNzdX?=
 =?utf-8?B?YnlyN1JVbDIyV015RjRicFJQcXZQdlR2VzZ1Nm5ocnZHblpMNSt4WThFdWNx?=
 =?utf-8?B?SjJzQWxBYWplMG43SUcrUzZLeEFEOGpqYU9kWDQ1ZHpkY1NWaHlGQ1JlZk9p?=
 =?utf-8?B?YlpuYzVhQTVveUxrRUtxWWlFLzJWRFJkREJ0TmxVZ25YNXpLTDU0NDFJWnNY?=
 =?utf-8?B?Zm9icm9GbEg2dWh6M1BQMzg4NFV4eWM2MjdJQUpxY04wU01iOWNEcmtoNkkv?=
 =?utf-8?B?MWcyZ3VzS0YvUEwrQWNEVlFQT0pVb0RNeVZDZGI3eTZNOFZKYUNSTFFYVjZz?=
 =?utf-8?B?UzVLVnJ2T3hRdkRiK21BdzR2a3Q3TXd6K0xyZmY0U0daNFVaTnNZWUJZd3dp?=
 =?utf-8?B?SUsrMzYyZXM3WjQ0Qkx6VkdQNkxrVmVRK0pWYWpXZXpuRmtMRnpKNGw5c2hG?=
 =?utf-8?B?RlluTEFJOHVmdmtvT1ZCWnh0b2U4UXVtL25iK2Y3WFFsVmN4SSsrYmFnNHlB?=
 =?utf-8?B?SUJqajUyd2FQclNWNytsdDJJbUpYVGFjblR5c24wZVFoeXJNMmFCSnZJaFlp?=
 =?utf-8?B?TzdrZzFtVW8wc3dZM1QyTytDSlJvb0Ntd3lpSWloM0JyUXYxSUJ4cnplelF6?=
 =?utf-8?B?RXlTb1dMeTdkNjJxQjJlM2EyNEZueXRwNEN1eGRVTVMwc09waHFOK2IxU1hO?=
 =?utf-8?B?cFhWQXdoOUNWazZxcVNVckFuVHJmdUk3cTBJTnM2bUl0a0R3SXBEQ0VXRGtj?=
 =?utf-8?B?Zk5SampnbS9HbmxHSXlPVGRPTnlqOW5Ja3I5a2ZaQTFQV2t5R3RtY1pHUW0y?=
 =?utf-8?B?YWdxekFDamxwcXV0SGRCazU1WjRObmx0Z0F2OGIzcXpvNFdCYjJLN1JDQ2xl?=
 =?utf-8?B?WGlHZXY0YmQ2RjVmRkVaY3o2TzYzM1NQUU5NZVhBME5ocGRDU3dXVWViek1p?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OGJHRGVLejhRNWxxTGxmdWZkUGNHUjd5YzhhdTB5WEEyemJFWXdrNjhpaGRV?=
 =?utf-8?B?T3BCempNcGV1UUZwVW1EWEtGMERlbjFFdWR2dnhXQmR5cE9yUFA3M3JTcHN4?=
 =?utf-8?B?RG93TzZwMXo4NjdTcCsxeDJEck1oeXNWeUpha01uZ1drZUo4NTBKWXNSb0hR?=
 =?utf-8?B?eE1WczZocWdRNGgyLzg3alk3dDMrcUozZUMrbTNnYkdSbXBqUHF5M09lZGtW?=
 =?utf-8?B?M3daaXQyb09Bek4zcUVHL2JZRWRjdy9uQThLR1lFMmtTMW5xZ3FtMHlpWDNP?=
 =?utf-8?B?U0lhYXJPSzFkTFQ5WVlROTB5cWRxZUQ2cTVLQys2Ujd4K29EVU9tbnNZT3hk?=
 =?utf-8?B?U0hlblAydXNFYUl0UGJRd2MxYzRtRW5UbTFwWWI0WkFXUURVNm03L0c4RjNa?=
 =?utf-8?B?S1FpaFRsUGJxL2JGRjZ3ZVBnVzd3V0Vya2R3ZWhWVmIvSjViWXQ0eENFTFpz?=
 =?utf-8?B?amtIWXlPTDlWQzJteUJCaUdhWW9SM3JOelA1QjBvU2RzYURiQm5KVmRhYjAx?=
 =?utf-8?B?VEc5RjM0R1hWWmxIckttbHdkYVB3ZExoVThJUGVYTnluNmlKcXNtQkQyRUhw?=
 =?utf-8?B?QXYyWkp5VmtVRzdCWklZeStBS3dDY2hndENEVC94czJIbGdXL24rMERHaS9T?=
 =?utf-8?B?cVNlUjBVS3prNCtTeVUvb3oxaXcrZVZ1QVZmNUFXVUtGSGJ1T2Z1WWxONENx?=
 =?utf-8?B?VGw0bUFoc3ZTbURtNCsvVWpEVVFOZGZLTk5SN05pYUVmNU5tT21aYVVvVFgv?=
 =?utf-8?B?TnFQM1FHeGpQZHdybGxmL3k3V0FLMUQ5R1dUVkR0Z3daZ2ZVdjlVYWNOSXIr?=
 =?utf-8?B?WGVxeVFRZm9PazFjZlJ0RGhmN1dieFVNSVNJWkl4dlZZQVJLZE1HMVd4bXZF?=
 =?utf-8?B?NjlCdkVZeVVQcnkwaGkwRm9nWlI0ZnBMZExsY3JkYUVQbXp0anJPRm9ka2pV?=
 =?utf-8?B?VkZJSUlpUUQ5T3NBMm1xcEFFdmFmUjhVdW9JSWJYYWJSMFRhYnJ2VEdTeVVi?=
 =?utf-8?B?UnhoMElhTHhmMGMzdkFSbWpvWUd2UmQwQ20vMFNHc0dLaS84RzRGTnVIUTg1?=
 =?utf-8?B?TVY5ZUUvTXhIL25yRC9EbHh2ejViZWU2SzhhdXh4aGhYZ1E2WE11ZWRMU2lx?=
 =?utf-8?B?Q0lXcy91U1ZtYS9pTkw3eDJYb1VBcmRNa00rSlhsd1FXKytqbnB3Sk9sWWZx?=
 =?utf-8?B?bkErb0hwekVTM3RFdEtMQ1pWcGJrekxYQStDTHhGZjRoOXg3eU1GQngvM1VD?=
 =?utf-8?Q?UUg+bUr1Q6qps1o?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3dd805b-6fdd-4126-845c-08dafe1b0bc2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 14:55:34.6058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eICpZad5+qhfzLXOZW0DlzMHtIUb1Zqs1vg7rR9Dbq8tVbGBpNE5Fb3gk3I8QCIrMko85X0DZwoZWyAXZRZv6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240135
X-Proofpoint-GUID: AIk87E0R6l84d_ISiyR5bj65AOze8006
X-Proofpoint-ORIG-GUID: AIk87E0R6l84d_ISiyR5bj65AOze8006
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/01/2023 14:50, Christoph Hellwig wrote:
> To prepare for pending changes drop the optimization to only look up
> csums once per bio that is submitted from the iomap layer.  In the
> short run this does cause additional lookups for fragmented direct
> reads, but later in the series, the bio based lookup will be used on
> the entire bio submitted from iomap, restoring the old behavior
> in common code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


I was curious about the commit message.
I ran fio to test the performance before and after the change.
The results were similar.

fio --group_reporting=1 --directory /mnt/test --name dioread --direct=1 
--size=1g --rw=read  --runtime=60 --iodepth=1024 --nrfiles=16 --numjobs=16

before this patch
READ: bw=8208KiB/s (8405kB/s), 8208KiB/s-8208KiB/s (8405kB/s-8405kB/s), 
io=481MiB (504MB), run=60017-60017msec

after this patch
READ: bw=8353KiB/s (8554kB/s), 8353KiB/s-8353KiB/s (8554kB/s-8554kB/s), 
io=490MiB (513MB), run=60013-60013msec
