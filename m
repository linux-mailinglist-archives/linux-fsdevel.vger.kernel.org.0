Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB938769CFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 18:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjGaQma (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 12:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjGaQm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:42:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CA61981;
        Mon, 31 Jul 2023 09:42:26 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDTakQ001772;
        Mon, 31 Jul 2023 16:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=xMmEIkVl7ccTXsBReGtYZSXeoRCa3wipYv7zMa4UwJQ=;
 b=x2e0tBk2ISzNFwY5BrRPjcEg2pEUOIEp40we07UsjOS4GquDpc3d6j652srTdscsDn3F
 lG01XaIafOr+oWSSvIgi5Mm2itlFjv+cpIPEuy4rCSiwpUoJaOtCSlzmxGaJ8LfQSGsW
 97zDyQLskcICaojXg9j/FNSx+ijVh7JfrsgQ8aY7dH7vF8I6vzoYlofbQCGJaxL1H4XD
 xrQPPACZFFwTLpko/CQNVKFASqwK6hovBFpohSFo+zLbKGmQzx7DsXSp5IrSoXFy3trd
 4HloQ6FxETkOJYcb1kDe1PrPun4/K12BQOEE9eU3DBOm3LBlrQCWWqZ0gl2JuHRPmCZd Cg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spc32cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 16:41:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VGBwLP000653;
        Mon, 31 Jul 2023 16:41:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7avj6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 16:41:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqpzB7QPw6hPz2tqYC210Me6JRFlrxvhcjmDcs45AOPn7+7szNOwq8BUTZWBxyHk6u8PvA6qQzN0v//1720jTvfHS8SwQ4cSBkyNGn6NvF1zAxYJYl55euUHCIuzGFU9EbUlvjG3VFaWC48FZmR/pXLkHVB2m7IdhD2mLKn0UaVtcc4J/7gvoLa1tDkt5l3V/FvE6eExV5RJNPMCEGhktlfCy778w1AF8J0RFRARiUwGf1qom1/y0TDPQ20ckUsacm4SZbLiszSdaFJbt7P35whGhmF3n7i8TmrYdDdjV5swowS9I6nUdJ8EiDi5yN8p6abFfjSkvFIyLE+WyBTRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMmEIkVl7ccTXsBReGtYZSXeoRCa3wipYv7zMa4UwJQ=;
 b=aOJFDyR6ZerFAvzNaVyzCr8JgOukabwU+LZ4xmhe6yPXEt5VCebWyRmby5TpHLrl3PCDSBOW+kGOWNr3z416PqXMD2jgRNO/lL+EqVBX6rfxYNffb2e0FvDJVKSSYRyAfXdX1R1Kuz45weoXPpCecUlv7fKhVC4HGQ7A8eJLeNZLBY8b5AnciFdY6Ayv2dD9fWTcqKsx//ZOknKrsO15bL11eSEfnBtKPe3DNMVMd3+Ui8ucKQH1+np2MzV4anukVK1dmqkS4v4HhBlT9Cz6zP10UuJqhIjyEj/vnRHMsInwZ6n6LDpVrZt7cb4OsndZb9CR+bjbjnDHWhNe8Gq11A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMmEIkVl7ccTXsBReGtYZSXeoRCa3wipYv7zMa4UwJQ=;
 b=QDrc3yO7jwOtVkRVcN56JJWeTuInxozuRtRSPX8SL4LWYxhtutuml8BJQu223VdueX6BtKMsXEJPkd7ptu0wvWhNxtM/qhn4bC/tTs+KzRtVABvv1N5ic0odAsMar1ZPSWE0Bmt0xoflqP3UsyB9NdW+8YcxXXrP4QVUP3gp2NI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4144.namprd10.prod.outlook.com (2603:10b6:208:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 16:41:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 16:41:24 +0000
Date:   Mon, 31 Jul 2023 12:41:20 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     linux-doc@vger.kernel.org, linux-mm@kvack.org, avagin@gmail.com,
        npiggin@gmail.com, mathieu.desnoyers@efficios.com,
        peterz@infradead.org, michael.christie@oracle.com,
        surenb@google.com, brauner@kernel.org, willy@infradead.org,
        corbet@lwn.net, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] maple_tree: Add test for mt_dup()
Message-ID: <20230731164120.3xfyoynxh5b6mja2@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, avagin@gmail.com, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, peterz@infradead.org,
        michael.christie@oracle.com, surenb@google.com, brauner@kernel.org,
        willy@infradead.org, corbet@lwn.net, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-6-zhangpeng.00@bytedance.com>
 <20230726160607.eoobd4dyvryfb25a@revolver>
 <248b946a-f42f-6b59-147c-c7dbbe03ef0d@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <248b946a-f42f-6b59-147c-c7dbbe03ef0d@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0034.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MN2PR10MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3b7b3e-da61-4098-ff38-08db91e4fa13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3JrB/kvDWoe+9aigMGWcF2NvXd3/3IZ5eE2S0MIjyGVPADcvCrM7iXrNawZLxtr+yM++Pnw67cjmWECiLtutE1d/9G6A0cs1wr4b51YYZ6OblEf75p/8aShamwILmTuOSlIu5VOPDIiT4EwIkM/o9TMjP7OGNEsKyX1XmNdempUPQ59aNqo8qhXubCiEbhr5NtC3GHUNC9JLJ/s58gUSFIpbJF3JJXXOyPTK2QZijQ9mrpsqI1vKok0BqQNkma7KXf9+OeRba/1h1Yx6pr72cZykcYWTg1GlgLeDNm6jIJeB1fIDLxaMLv8tkNZUCi/Fjw935NQ+I4q7m9t2ncWN3Lj2hx/WDerit/yiAsdRSyeNai5oZ2XBp/sOo7dx363w51XPKRwuAL7sBvTf1qNI6NHPsOjDRQr56Laz/ZKOgt8h9yEwiPU2YwucuBbhMZp5heI4V7xyGHXMBX7d1Mx81yG1xcW+Fc80TSt9p25gFhYs+zynHdxGQKb+YggfeB2/IesOovkAUgPUnL7ee2lGUbu1HY2eczawgkHmEK/1FsAE22h9xB3DhQuNven9B6F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(5660300002)(2906002)(66946007)(66556008)(6916009)(66476007)(4326008)(7416002)(41300700001)(316002)(6486002)(6666004)(8936002)(6506007)(1076003)(26005)(8676002)(186003)(83380400001)(33716001)(478600001)(38100700002)(9686003)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVp5R2tRRkwrdUQ5RFpZbnJmN2ZzbElxaXFmOUZoQXF2eG9RMWRoZm45UjZo?=
 =?utf-8?B?K2gzdmxTd2kxbkJKMXIxTmtlNWlTdFZoRmVyazF5emRPdjZWV25zYU44NGdk?=
 =?utf-8?B?azkySDg4RlFjRytKazN3cGlTVzQ3Y25pNmthd2ZGZXJyYmV1TlpEeng3aENu?=
 =?utf-8?B?b1BwUXhFSHBrUTNSd2xVckY0MjQxTDZMUHo0dVphVFRlQSthaDVnSzRta2hC?=
 =?utf-8?B?WGNHbzFtR1FvMFAvVlorZnA5bjd1V2RMTmFaUEw2VDdwRlRUbXhBSzdUVlln?=
 =?utf-8?B?WWJQVW41d0trd3NFWkdIelJVZXcxRi9qWUZOVDNLRjV5a1JLT3VQcnBZOUFV?=
 =?utf-8?B?bGhaZllzMCtCRlRuRjNqMWNCdSt6ZXhIMXdCak1ZVXFBanZEYVB6Y20xdGE2?=
 =?utf-8?B?YTFtMlpTVzltcjh0MXhLdWkwRzdMUmpvR1BkNHAxSjEwZEZaajM5b2c2clZC?=
 =?utf-8?B?WGpTMkFGVmNrcVYzbVFzWjhxanNET0lzbVplTGdDOFVyaHQwUDkrRU5QcWVU?=
 =?utf-8?B?alFLR0lMTFRGSVFQMGNpaVVlVW1jOTVobElkNHB6YkdRSjluNHhZVy9Bajds?=
 =?utf-8?B?V1J6VVJoQW9vei9ER25OL2hDQjdFa0gyenBGV1VqZExIR1MxcE1YbU5EYXBx?=
 =?utf-8?B?NDlqa2g4K3FDSFk3Wk81MW9zNjVkcUZOS3plVWd3aXcrTXRBOG8yNnhyK2g5?=
 =?utf-8?B?NldnWmR5MVcrSWEycnhZQ29GNTZDZHhjTWVrKytsRHMzNFR3eW1iQ2ptUFhM?=
 =?utf-8?B?TDk0R0Q2WHBVRnlvVEVZVHpKTXpDNE1JTVBzZVJoOWV4QnJvYjhhYlFkRGZ0?=
 =?utf-8?B?RmhVM3hOSUlBbWZuamthUTZuM1hYVTNMMm9sa2d2Y3QxSWp6d1QvbzhhVkpz?=
 =?utf-8?B?T0tuNDVLTkZnZzBSQ1NFbW01aWFvMmNjRCtCMTBZK3l2cnZwNDlIemlyaVNO?=
 =?utf-8?B?aU13aWFkT29LcVhJcnZPMHhIejhWOUtIMzZBUTlIMElpVnNNZGFKVTJiTWVN?=
 =?utf-8?B?aFdwdXU0R09MUkdGVWNXSXErd3VYd0lEcG82endpbjlNcGg5TEErNXZxeTFX?=
 =?utf-8?B?cFNzRjFaa1BRemxNZ0ZWM0tYTUR0Z0NmdENoeWhoczJLM0pIUmFNTkN2VCtE?=
 =?utf-8?B?OUFkTFpPQU1VZUc4WWlmRzl5OXRUSlRTc215ek1UVUNkeERPWmFIQ2xGaWwx?=
 =?utf-8?B?VVpmbjVoSnc4eFVsZjNxZFE5UzZYcG9WNW43cW1lNm4zVzlVdzc5eDFxdTRj?=
 =?utf-8?B?NzN6cDIwbEpKQU1jSWs1R0h2dFVrcXJPRjZzdEJSc3hNbDVDSDErRmtXbGdM?=
 =?utf-8?B?Z3lHSXhnT2MzN2lCTHc1QU5aVFQxZnJ3Tlg3SzI2TElIQ2lDYnpmajZFSzd5?=
 =?utf-8?B?L0V6WWN6bVp6RHdEUWowNlg4NlFVaFQ0ZmpvT3pTZERoZFlIQyt1eVhua1NJ?=
 =?utf-8?B?Zkd6ZHpvTjhGYzJaTGFhOHV2QktjWElZNGticEVpTDY5OUJDdzFSN0VrbDht?=
 =?utf-8?B?RUw5S3FSRm1Ua0ZzdnFLKzJaZnRUYjBRVUY1MUFzS0R3VWNGeWpBV0RlTHpS?=
 =?utf-8?B?TDlvOUxNMVJ4VFNBdlZYL3dtb1N2S25mQXdDbThrMEU4b0pzSXQ2bFhwYTd5?=
 =?utf-8?B?UWczOXZTdkl1dktSbVUxVXovc1hPUm9lZmx1eTNOSnFEY2hsNFpPS1JtUUh6?=
 =?utf-8?B?UFFSRExHTk9WbXpUWi80dkdKUlpyUFdzMGNCR1lyY21taHNjM29HeGQ0RVMz?=
 =?utf-8?B?d0I2RlBYdTZLbTlVSFA4ZHE5MEx2a1ZmSWN6c1kvRGxkVjVJNHhJS0dvZmFZ?=
 =?utf-8?B?NU9CcHMxOXpyemZ0Q0pud0tpMk9ZOGlwaFU2TFRIUDYzY3E4bDAzS3pnVVk0?=
 =?utf-8?B?Y2YyaFM2Ny9ZUnhPY0dBcWltZTAvaDEzMmUrYzlLSUYrb2lEMDBPSHNmVUxh?=
 =?utf-8?B?V0RaNHROZWNKTVZaZURvd2JudEpza3hyQ3BvRVV0VVozU3h3RXVvWWFIam5D?=
 =?utf-8?B?SjJ4NUdxb2ROaDJXL2ZBMXVxM3dXVGx1KzNvOUp1TFUwMjNIMzk5ZXoxYTNW?=
 =?utf-8?B?V3ZZUDNiR1BqblNseURQT2hVbFluMllPckZrbVRsZGRpVGJPSm1PZXBQZ1g4?=
 =?utf-8?B?U1YwLzZjaTFHRURGSDdXanhTWEkrYnhQTGQ4cTNYT3ZWaDhxVDRMMlRSUVNV?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L3UrUi95bHBVR3BLTFo5WFR1VTNwRmtTQm1QR0xiZjNqb0xzalhtTjc3TDVU?=
 =?utf-8?B?MkUyaVRpTk05VFF5UjNxMmdHY1FyenNpbVpiZjhRSEZyK3Y0Mko3K0lKMXhj?=
 =?utf-8?B?L3NDNlFhS1hhdU1CTVIrRm5GcTRxOFdTZ3BZYW5XNmFTZk9wUVRocDBhUEtj?=
 =?utf-8?B?S2w1MmVqQUtFYlFKNlRQZ21iZEMwRU1IVU1HTjJGQ1dtYnZxQjVLUk9XSnlW?=
 =?utf-8?B?eGY5ZGgwMUxacnRkUUs2MVpNVmhjODZWZmhWd3dyL2NqZzVXamdLUGxvZDRG?=
 =?utf-8?B?OEgwUEoxRGgvcndqWDhKTXRpRUlsY2drM3BIMWFRUGcvdkxxRXk1ZUdnRmhE?=
 =?utf-8?B?THNwZUpOU3c2b2dRSHN0SHdsSWJ3VVpSM2dsb1JWdHZ6TnR0ZmRYMWxiZURZ?=
 =?utf-8?B?ZVFtNVlLZ0twWXVkR09GdFlmUGVlV2VwWmpjZGQ1cndEZkF2b3AxYVZ1M3VV?=
 =?utf-8?B?MzFZOHZCa0lTM010REdkMWVFTW5qa1Z2TWtiMFlkV1F0em5FbXA1cUJhVnFY?=
 =?utf-8?B?a0VXbTJ3NFlBNmtzek5pZ0FobnppTDRZZk1xUG1JUWliZjc2clprWFA0VlJQ?=
 =?utf-8?B?QnVzZWpOR2NJNURvdlBlQ0QrdHdDMUhpUG45QmNvQkw2eER2K1ZZcGVycnhI?=
 =?utf-8?B?VGlySmVxOFYwRmVsWjhnclhtWENYaCtia3J3cVVYSmdNSVFQeG1Yd0tNZmk5?=
 =?utf-8?B?VnZuaXdpUElYeHJiRWtOOHp4ZUF5RVZoZ1V2RXJuK1BjL2NyZ0tzbHdLL3Bi?=
 =?utf-8?B?ek9yL0daSlQ1Nk91Q1N0ZkIxMFN0VHZaU1I3VDZKdUhhRmVydUpmNkxld2tI?=
 =?utf-8?B?K2VHb2htR2xQTU02blhRbWtMTmtmYVVxVGNVaXlycXB1bTk2ajNlaDg1K0Nt?=
 =?utf-8?B?cjdZem0xdUhwMk5tS1RGUzh6VVNVd2NHRzRka1RGdjJ1NFhOUHRlRVhXTVd2?=
 =?utf-8?B?RXE5WUtqRFhSSVhRTjVQQkVUWmgzSzAzTnJ2S1NiNkpVY1QwTXZRejc2dS85?=
 =?utf-8?B?RmdlMXNVTkZxUDczK2RyWjlIMDlxRFNTZTd5c3RxTXpqM2FBd21vNnlPamIx?=
 =?utf-8?B?QzRWWmg2dlBzQnUyaW5NZE5MeHpxb21vZ3VBWkEyTkZZdG43ZWREcWNyS1E0?=
 =?utf-8?B?clUrUEVKQ2pwU3gzak1zRnpPUk5mdFlRaGcveDdYUHNPMGhCWW4vWG1sZnpV?=
 =?utf-8?B?Z1VQQXdXUjJjNU1BTERFaHJzWTNaMm5BYm55SEZBVSsrTXlYNm9MZWxmZDhn?=
 =?utf-8?B?SHNvRGVvOEdieTh1QzZrRzU0N01ySDhnR1ZFY0VVa0FrVTJ3di9Jalk3OTNy?=
 =?utf-8?B?Mm1aa01CVFVrK01tbmtkMStFZmNEVG5EK0NjZTkxbWFZSzNWK1AxZ0tEVzZS?=
 =?utf-8?B?cWZ0TGFBS0tFT3Y1TFF0NXdvNWE5dzUzZmJSVmpFUUZiQTMyNnZQNGZOWHMz?=
 =?utf-8?Q?bchItO2p?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3b7b3e-da61-4098-ff38-08db91e4fa13
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 16:41:23.9366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOzmSw0ocACmr4x/Q18YkzEwyBdrdIv9XCQ7U9bpjXduO5WOwpwAkuvOGGGGsugsIClkUnx6rrhDWvf55hUGPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_09,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310150
X-Proofpoint-ORIG-GUID: 1uQhGy2lvIoCUabvoNCroPkdGDomhVNJ
X-Proofpoint-GUID: 1uQhGy2lvIoCUabvoNCroPkdGDomhVNJ
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230731 08:32]:
>=20
>=20
> =E5=9C=A8 2023/7/27 00:06, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
> > > Add test for mt_dup().
> > >=20
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > ---
> > >   tools/testing/radix-tree/maple.c | 202 ++++++++++++++++++++++++++++=
+++
> > >   1 file changed, 202 insertions(+)
> > >=20
> > > diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-t=
ree/maple.c
> > > index e5da1cad70ba..3052e899e5df 100644
> > > --- a/tools/testing/radix-tree/maple.c
> > > +++ b/tools/testing/radix-tree/maple.c
> > > @@ -35857,6 +35857,204 @@ static noinline void __init check_locky(str=
uct maple_tree *mt)
> > >   	mt_clear_in_rcu(mt);
> > >   }
> > > +/*
> > > + * Compare two nodes and return 0 if they are the same, non-zero oth=
erwise.
> > > + */
> > > +static int __init compare_node(struct maple_enode *enode_a,
> > > +			       struct maple_enode *enode_b)
> > > +{
> > > +	struct maple_node *node_a, *node_b;
> > > +	struct maple_node a, b;
> > > +	void **slots_a, **slots_b; /* Do not use the rcu tag. */
> > > +	enum maple_type type;
> > > +	int i;
> > > +
> > > +	if (((unsigned long)enode_a & MAPLE_NODE_MASK) !=3D
> > > +	    ((unsigned long)enode_b & MAPLE_NODE_MASK)) {
> > > +		pr_err("The lower 8 bits of enode are different.\n");
> > > +		return -1;
> > > +	}
> > > +
> > > +	type =3D mte_node_type(enode_a);
> > > +	node_a =3D mte_to_node(enode_a);
> > > +	node_b =3D mte_to_node(enode_b);
> > > +	a =3D *node_a;
> > > +	b =3D *node_b;
> > > +
> > > +	/* Do not compare addresses. */
> > > +	if (ma_is_root(node_a) || ma_is_root(node_b)) {
> > > +		a.parent =3D (struct maple_pnode *)((unsigned long)a.parent &
> > > +						  MA_ROOT_PARENT);
> > > +		b.parent =3D (struct maple_pnode *)((unsigned long)b.parent &
> > > +						  MA_ROOT_PARENT);
> > > +	} else {
> > > +		a.parent =3D (struct maple_pnode *)((unsigned long)a.parent &
> > > +						  MAPLE_NODE_MASK);
> > > +		b.parent =3D (struct maple_pnode *)((unsigned long)b.parent &
> > > +						  MAPLE_NODE_MASK);
> > > +	}
> > > +
> > > +	if (a.parent !=3D b.parent) {
> > > +		pr_err("The lower 8 bits of parents are different. %p %p\n",
> > > +			a.parent, b.parent);
> > > +		return -1;
> > > +	}
> > > +
> > > +	/*
> > > +	 * If it is a leaf node, the slots do not contain the node address,=
 and
> > > +	 * no special processing of slots is required.
> > > +	 */
> > > +	if (ma_is_leaf(type))
> > > +		goto cmp;
> > > +
> > > +	slots_a =3D ma_slots(&a, type);
> > > +	slots_b =3D ma_slots(&b, type);
> > > +
> > > +	for (i =3D 0; i < mt_slots[type]; i++) {
> > > +		if (!slots_a[i] && !slots_b[i])
> > > +			break;
> > > +
> > > +		if (!slots_a[i] || !slots_b[i]) {
> > > +			pr_err("The number of slots is different.\n");
> > > +			return -1;
> > > +		}
> > > +
> > > +		/* Do not compare addresses in slots. */
> > > +		((unsigned long *)slots_a)[i] &=3D MAPLE_NODE_MASK;
> > > +		((unsigned long *)slots_b)[i] &=3D MAPLE_NODE_MASK;
> > > +	}
> > > +
> > > +cmp:
> > > +	/*
> > > +	 * Compare all contents of two nodes, including parent (except addr=
ess),
> > > +	 * slots (except address), pivots, gaps and metadata.
> > > +	 */
> > > +	return memcmp(&a, &b, sizeof(struct maple_node));
> > > +}
> > > +
> > > +/*
> > > + * Compare two trees and return 0 if they are the same, non-zero oth=
erwise.
> > > + */
> > > +static int __init compare_tree(struct maple_tree *mt_a, struct maple=
_tree *mt_b)
> > > +{
> > > +	MA_STATE(mas_a, mt_a, 0, 0);
> > > +	MA_STATE(mas_b, mt_b, 0, 0);
> > > +
> > > +	if (mt_a->ma_flags !=3D mt_b->ma_flags) {
> > > +		pr_err("The flags of the two trees are different.\n");
> > > +		return -1;
> > > +	}
> > > +
> > > +	mas_dfs_preorder(&mas_a);
> > > +	mas_dfs_preorder(&mas_b);
> > > +
> > > +	if (mas_is_ptr(&mas_a) || mas_is_ptr(&mas_b)) {
> > > +		if (!(mas_is_ptr(&mas_a) && mas_is_ptr(&mas_b))) {
> > > +			pr_err("One is MAS_ROOT and the other is not.\n");
> > > +			return -1;
> > > +		}
> > > +		return 0;
> > > +	}
> > > +
> > > +	while (!mas_is_none(&mas_a) || !mas_is_none(&mas_b)) {
> > > +
> > > +		if (mas_is_none(&mas_a) || mas_is_none(&mas_b)) {
> > > +			pr_err("One is MAS_NONE and the other is not.\n");
> > > +			return -1;
> > > +		}
> > > +
> > > +		if (mas_a.min !=3D mas_b.min ||
> > > +		    mas_a.max !=3D mas_b.max) {
> > > +			pr_err("mas->min, mas->max do not match.\n");
> > > +			return -1;
> > > +		}
> > > +
> > > +		if (compare_node(mas_a.node, mas_b.node)) {
> > > +			pr_err("The contents of nodes %p and %p are different.\n",
> > > +			       mas_a.node, mas_b.node);
> > > +			mt_dump(mt_a, mt_dump_dec);
> > > +			mt_dump(mt_b, mt_dump_dec);
> > > +			return -1;
> > > +		}
> > > +
> > > +		mas_dfs_preorder(&mas_a);
> > > +		mas_dfs_preorder(&mas_b);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static noinline void __init check_mt_dup(struct maple_tree *mt)
> > > +{
> > > +	DEFINE_MTREE(new);
> > > +	int i, j, ret, count =3D 0;
> > > +
> > > +	/* stored in the root pointer*/
> > > +	mt_init_flags(&tree, 0);
> > > +	mtree_store_range(&tree, 0, 0, xa_mk_value(0), GFP_KERNEL);
> > > +	mt_dup(&tree, &new, GFP_KERNEL);
> > > +	mt_validate(&new);
> > > +	if (compare_tree(&tree, &new))
> > > +		MT_BUG_ON(&new, 1);
> > > +
> > > +	mtree_destroy(&tree);
> > > +	mtree_destroy(&new);
> > > +
> > > +	for (i =3D 0; i < 1000; i +=3D 3) {
> > > +		if (i & 1)
> > > +			mt_init_flags(&tree, 0);
> > > +		else
> > > +			mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
> > > +
> > > +		for (j =3D 0; j < i; j++) {
> > > +			mtree_store_range(&tree, j * 10, j * 10 + 5,
> > > +					  xa_mk_value(j), GFP_KERNEL);
> > > +		}
> >=20
> > Storing in this way is probably not checking a full tree.  I think it's
> > important to check the full tree/full nodes since you have changes to
> > detect the metadata.
> I probably won't change the way I check metadata.

What I am tell you is that you haven't tested your new code for the
metadata of full nodes with this testcase, or have I missed something?
If it's not tested here, are there other testscases that cover the new
code?

>But is there a way to
> construct a full tree? All I can think of is to write new code to
> construct a full tree.

Normally, what I do, is create a tree in a loop like you have done above
and then store entries over a portion of existing ranges to fill out the
nodes until they are full.  check_ranges() in lib/test_maple_tree.c
might be of help.

> >=20
> > > +
> > > +		ret =3D mt_dup(&tree, &new, GFP_KERNEL);
> > > +		MT_BUG_ON(&new, ret !=3D 0);
> > > +		mt_validate(&new);
> > > +		if (compare_tree(&tree, &new))
> > > +			MT_BUG_ON(&new, 1);
> > > +
> > > +		mtree_destroy(&tree);
> > > +		mtree_destroy(&new);
> > > +	}
> > > +
> > > +	/* Test memory allocation failed. */
> > > +	for (i =3D 0; i < 1000; i +=3D 3) {
> > > +		if (i & 1)
> > > +			mt_init_flags(&tree, 0);
> > > +		else
> > > +			mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
> > > +
> > > +		for (j =3D 0; j < i; j++) {
> > > +			mtree_store_range(&tree, j * 10, j * 10 + 5,
> > > +					  xa_mk_value(j), GFP_KERNEL);
> > > +		}
> > > +
> > > +		mt_set_non_kernel(50);
> >=20
> > It may be worth while allowing more/less than 50 allocations.
> Actually I have used other values before. I haven't thought of a good
> value yet, probably a random number in a suitable range would be nice
> too.

random numbers are difficult to recreate so it might be best to limit
that to the userspace tools/testing/radix-tree/maple.c tests and print
the random number for reproducibility.

>=20
> >=20
> > > +		ret =3D mt_dup(&tree, &new, GFP_NOWAIT);
> > > +		mt_set_non_kernel(0);
> > > +		if (ret !=3D 0) {
> > > +			MT_BUG_ON(&new, ret !=3D -ENOMEM);
> > > +			count++;
> > > +			mtree_destroy(&tree);
> > > +			continue;
> > > +		}
> > > +
> > > +		mt_validate(&new);
> > > +		if (compare_tree(&tree, &new))
> > > +			MT_BUG_ON(&new, 1);
> > > +
> > > +		mtree_destroy(&tree);
> > > +		mtree_destroy(&new);
> > > +	}
> > > +
> > > +	/* pr_info("mt_dup() fail %d times\n", count); */
> > > +	BUG_ON(!count);
> > > +}
> > > +
> > >   extern void test_kmem_cache_bulk(void);
> > >   void farmer_tests(void)
> > > @@ -35904,6 +36102,10 @@ void farmer_tests(void)
> > >   	check_null_expand(&tree);
> > >   	mtree_destroy(&tree);
> > > +	mt_init_flags(&tree, 0);
> > > +	check_mt_dup(&tree);
> > > +	mtree_destroy(&tree);
> > > +
> > >   	/* RCU testing */
> > >   	mt_init_flags(&tree, 0);
> > >   	check_erase_testset(&tree);
> > > --=20
> > > 2.20.1
> > >=20
> > >=20
