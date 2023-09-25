Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB477AD23A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 09:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjIYHq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 03:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjIYHqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:46:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF3110A;
        Mon, 25 Sep 2023 00:45:34 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P74tj9008523;
        Mon, 25 Sep 2023 07:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=snRx72EsvumGjXBK3rPyN3WdjyfZf5DH45HPE2GCY7c=;
 b=A2mACsBOKucrdhfPLwZI9m/jEZ+tyfe2KOy4m7hpMn56iniH/sjl2X9h/ScWpTl0x0GA
 oPjY/oI1sUSzzNdn55QUj/f/YVpd7DZP1VkxMBmunrwupZseFAfYEx17tCJ0Ow/eSF88
 ufME5FrXLxiYn2iAtcdYs00EbemWPpsfpgh47w3lkbueQAmytRQ125E4kz6uHwMKrLjH
 O6GlGxZlzdUfIm+ylGcpN7UaeynaLc/s7xYKuBgXob+PrQjNoRi6jDo4VpK9m8WZw6L9
 4yepObK0CvbITcdcRyzS74qaC3dzIMmIf0IqZXi3+FCGg0vEgJ8AGrfOSrlATeXISIrD Ow== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxbu0k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 07:44:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38P6IiAG018016;
        Mon, 25 Sep 2023 07:44:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfa5chq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 07:44:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSbQ178eeYTBdU9b9mXU49eccK9/roKOQpL7U4sC6J0AP/0vf7eVzReZ+KsnPdxdbSWxG5RvWE3Vf5N/5yUH+7NoG3zTQLrk614JX6DtorA7SO1LAWyglU5XrjDQYVmbngx8luwl5pMdTN3vk3y5X/SL0pc23zdCKUkwTkRBH1rnC2TpmhqRSjxTqBqP/xoGBGZrMA1EHkWlh5unvo8Ox15hNKiSD7ytTOnEWcVuZSwkW3eeOUFw+ULrGTBUfgL15GoJJL6izFonlBK8o3r13gBs05m4deSF3QC3TKRk/D0H3BUyuL+y9I3B9xmXU799rLM69lePek2WlFgC7OJzug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snRx72EsvumGjXBK3rPyN3WdjyfZf5DH45HPE2GCY7c=;
 b=l/aUzAGpCSU2Gtqgtb9vIZeQgAnGgK2WomVomPGzWuq7lnroYsIsdKZ4xBll9T4SXSLoFglH/6XNcUm5nA0dRI72+6GYk35Bt7YANxeO6pmvv1StZrMsr1LvGZOFfIHoi0s45mpvr/qw4Th/AM9BicTzp5IcbF+h/Kt4EtU3ZYy1RLWY3uwR7oDSC9IGSojO809/chMpkFjKJmXm2jqEPFqa+ECUH5GJjkGfrN5K3NZtjJSlblEXz0bu/seiO0Gw+PVPrc8xgX4JbasgDVta3DlZAd3MRt5kjkYKr6/q3vwg2hBXaG3zvFt777M0/PBxv1Mga+j6GUUfTbbv+OY6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snRx72EsvumGjXBK3rPyN3WdjyfZf5DH45HPE2GCY7c=;
 b=w6u2OfoujIh1aQOMKF16xaFcpy53Su6Icxq2vGAWPlAS6rAGRHKA/cM6gP3JGQF0fHPxX3te2CUBxOadqx3U4LYbrMEJRHa5KKJ/6kQ3fXKX7VV9lIqR6CLJW0S08mt9dnt0bOwjJ6JE1pZ/XeLOrZZ32bRv6SZuDU1/MAo+QWM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4388.namprd10.prod.outlook.com (2603:10b6:a03:212::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 07:44:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 07:44:43 +0000
Date:   Mon, 25 Sep 2023 03:44:39 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] maple_tree: Add test for mtree_dup()
Message-ID: <20230925074439.4tq6kyeivdfesgkr@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
 <20230830125654.21257-4-zhangpeng.00@bytedance.com>
 <20230907201353.jv6bojekvamvdzaj@revolver>
 <65fbae1b-6253-8a37-2adb-e9c5612ff8e3@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <65fbae1b-6253-8a37-2adb-e9c5612ff8e3@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0432.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BY5PR10MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ce9589-0478-42ef-2be8-08dbbd9b4818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ue2IFg2tjnz4E4vdqrd+lYPkWz80ncJnyoDiVg5tfN8uvvdRVO/WE7SwY41vWW0BjJuPDvZb3wkFw4TTq7smGuIovDHa6wsrHY36/DU6j9PsM06T7YFfBSlQ0wdSnWavEYQs9iz7plzMg6YaOTiAefjv3SnTkUmNr4jyv33q7Qum/lOpvKeAyQb/m+0DbJP14auLOvzqGBzUdBa6RZ6OkIWoDYKVoR9KheNVulZGb2ydO0iEbkr0Sld+TT0c9q0QnReSNM7Q8ayOKxRFUZ++7hPIEfgaIQowlhMuaHxsgAYo/WmjVlCIk6fJOcTlgcGrwRZ15uGEJYSBulwjXX1EwQsoIMSg0oWzw6cB42UPI82SZdNEaxQiGa5J+ElnR/dC1mqrTBoL/OmLYlP3fbsmriddwKHKb95FGMn4rjmE84DfDrbUAEm0RNCZp6uo+nu9j6dz1P+IKCNNESuU5Ib8Myfh5H/kQbfL1Qm8Xm5r3JYqHw7E0PLdeBwH0U36DnpkJSEHJuQA7hFQe3InTQ11Ln+lfnXI06nGWat2oALAdDGrcj+SzOs64BPYDNKnLFWc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39850400004)(136003)(376002)(346002)(366004)(396003)(230922051799003)(451199024)(1800799009)(186009)(8936002)(4326008)(8676002)(26005)(30864003)(2906002)(478600001)(316002)(66476007)(7416002)(41300700001)(6916009)(66556008)(66946007)(5660300002)(6486002)(6666004)(6506007)(9686003)(6512007)(1076003)(33716001)(83380400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnV3QWRNbWR3bmoxQlBRS25pOE03eEhEblBrcWt4cDE0WVMyNmJSN1lEbTdN?=
 =?utf-8?B?bFZsQWI1bXhWMnNua2RhTWhIT2FBYVZjbGhUTitmSnlIcUhqWWNvM01sMU9n?=
 =?utf-8?B?Nkk3S3VodXhzamx1ZVdZQjNxUzlUUWgxOS9jRE9PREZNbnZURkJBQnB3ZGFL?=
 =?utf-8?B?QnVnYVN2Qzg1YlVrcWdvbS91RHpxTG92ekJYMHpkMEcxcEd2TUJRS1hReldk?=
 =?utf-8?B?ME1GdkIxbGErc0I5YWF2Mm9lY2p4ZXJQOXQzMWN6U0xlWWtFVFlVaFZZbHp5?=
 =?utf-8?B?RkRER1plRnBKcW05MXNQS01qRTAzZXRPQS9rM1RyTVp5Wi95VjZ1VmpLRlF1?=
 =?utf-8?B?NmJyWW9JaUMxQWlkY2MvNDJ3eHJlOHloQThSM29iZCtBV1ZLNU0yck5hK0dp?=
 =?utf-8?B?STBMcVZsVFZLdndpTVRPSWhSdS83SnQ0aUdMS0Nvck9McGd5QUJvdlpaWHk3?=
 =?utf-8?B?dXdDUkhycmJ3RHc1UGFHK3VVVEhTM25mVXRQcW5yYU1yb0tsQmwyOGljSnRp?=
 =?utf-8?B?aFJpZnpOMERJVGswdzFWSTd2TFQ3VVphRTBtaUlGS0Q5Qlo2aElCN2dwRUl4?=
 =?utf-8?B?UXY0SGRGNkkvYkQ0Q1ZlR25uYTBVdXBpZE93eDN3WUZMYUtNLzFneFVEdFZE?=
 =?utf-8?B?N2g1OUE5b3Q5OGFDYWs3MTdHVGxYeTQvYlM2aUpocDlFeWl6S0JQZXFpN084?=
 =?utf-8?B?R2YxK2Z3ZkJkZy9QaW9MU0hmdkJycWJJMjNMZFY2ckZHRjdORDV5WVhmMkE2?=
 =?utf-8?B?TnF0REtYQ29oY0VSeFl6MHYreHp0VjNuRThLK3BCQnhvR1lXNVhGNnU3SVZW?=
 =?utf-8?B?eEwyMVY0bWhmOWxxZTZOR21GNGlWRWRseEFsRXEzRnhycTFhcEM4UUJEWmp3?=
 =?utf-8?B?cmJqTkN3dDBhUWpCb0lqcVRlb2Q0K2FDckZFNU4rM3JHLzUyYzNaa0IvSlly?=
 =?utf-8?B?M3ZrWkl6QjJ3NVFCZ3Q5bFFBYUVndU15WUFHcFBqdnRWTWNQYmRFMTJ1ek80?=
 =?utf-8?B?Z2U5Y0F5ZE80MWJrNEhIMnVpT3Z0L0lWL240bmh3TEtaN00zWUwvM3lRZ1A1?=
 =?utf-8?B?NHllVEZWSDFZbkJ3c2loeU5RWFZsb3RzTDUrQmZUdVhpNFBLcFhHNW9RU1Rr?=
 =?utf-8?B?dHhLb1dmSFRhMTlwY2h0eUQ1SW53K2R5bVI1ZmVFaXJ6WXFvMkVLZWRmTVpQ?=
 =?utf-8?B?WU5sSURsZ0Q0dXdSQnhxV2F2VFR4aC8yU2FYeEd4TXZTelJCV0RYaUxIb01P?=
 =?utf-8?B?NUJwRy9EM0NWS3I1L1M0a3R6aWN0MkhqWUg5R0N6aFEzeHpWZHl4L0lMckZU?=
 =?utf-8?B?T0xjOW1GZDFGVG9IMUpZZU9pelZMekJJV1liMk0zWk05MkVoZm1YSHZ0Y2VR?=
 =?utf-8?B?Qm1lK3B5WlppQkdsTGFtcDloQ0JucEtVSEp0Wm42TXZoSUlxRFdZUldQZWdz?=
 =?utf-8?B?ZW51WTQzNm91cE1wSVIxNUNrSHpBeXFDUmdXUnpxd1hQdTB0WW1INm1xRGY0?=
 =?utf-8?B?dE5qYVhZb1hjZjBoV1ZHOHk2SW5RVWpQYkNGbktRYSt3VExWTGtPbXk1RDBB?=
 =?utf-8?B?Z2VHS0wxM0F6V3piSk90OE8xZjZWbk5XZGFDa0h5dzBDNytzTlJ5SWw1dmt6?=
 =?utf-8?B?dUd2bndNN2lLWWpoWXJvVE9LYmd4MUI3eE1LeU81a2JNQ1c0ejgveWd2QW1h?=
 =?utf-8?B?YmxFOFFTdHk0K0h4VzBlSThCR0pjVzVxV1BSNm9RR2c0RWRxZFZNZVRrN3ZV?=
 =?utf-8?B?dFFLeEtwV1RESTduMXk1MU1GR1pTRFZhbjhiSHovbmpNUm0wd0ttcGVkN0pY?=
 =?utf-8?B?U1FDMTMyVWEvTnhIY096Z1QwSlBmWThWYWdSTzZCTklGak5qNGtYaG1rL3JZ?=
 =?utf-8?B?Nlk3NjFFeXk5M082QzBXTXVXSDltb0NCeW9HdXZUK2ZqK295Wm5FYm1hZzdi?=
 =?utf-8?B?UWxwK2JTMlo5TXkzNXhSRVR6NkdyOVRnVW52NEtqZGpndWF5UytLMGZqTmwx?=
 =?utf-8?B?U2g2RVo4TG5WOHRSY295VlJwYkZOejV0RzdzR0g3MFVUREZOZHB1bVJ5cHI5?=
 =?utf-8?B?ZzFWNVpsYSt6bWVydUVKOUI2Q2s3Q0IxdlBSMFpJd1dkN2pVM2dNY3dvZ1Bu?=
 =?utf-8?Q?LYUN1MGydrNbY1taCknV+YCfB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eER1QVpmZEtZcDF0Z1UzckszRUVzdWFFQXZmR21sbWw4bjNURVVjWE5oQkov?=
 =?utf-8?B?Ui9PdVNrazdsODIvN092S0VwU2lmdUViYk9Gam1YQmlmNjRwcUJ3RjFpMm9C?=
 =?utf-8?B?L3cwb1lYaGExOTZqVllJUHNJZCtWTDJlT1ZaU2JvRWRFRHY1YlpwakJaOVd0?=
 =?utf-8?B?am94Rm84enZlTVhTNDdoZTMwOVhzV244L0V0cEVqSUtGL3RCV1FjL2VkTHNE?=
 =?utf-8?B?WVZQa0pMc3p4NmgzWjVBem44dkNUQmE1V25MQk1wdmVCeFcwdHNaYjBSR2dl?=
 =?utf-8?B?NUZ6QU5WSENzbjltTDdneVEvVFYySWJqTEd2alROUjVaYUdUSkFxdFdGNG1W?=
 =?utf-8?B?LzB2Nlk2VHo3WGhleTVUSmFQVHlWZmdscllEQ2g5WStQaHhuN1JFNnZEeThH?=
 =?utf-8?B?V3hrYmNaZU1PWHlYeU12aUZScU5qbjNQbDFCVDM0MUNOSm9nQUlRWExJU0pF?=
 =?utf-8?B?RXBqMEJQQlYwM3VOeDdVUzVVb09Qa1hVTnFyYXRkVVBUZlhZdEt2dmdFd3Zx?=
 =?utf-8?B?QW9RNjdOU0w0dS9kdmpKR3gveDFHVmhIVldoblpzTXRJejFRN0g5emVUNVpl?=
 =?utf-8?B?MThIMHBkdVpzU0kxOWsrRHN5S0o5MENJVTdmeDVJUnlXSGdEQWw1cWFoQXh3?=
 =?utf-8?B?NnVPMzJrdG8vREJDdHFwcGJPMndLZUxMOUVsdGQrMjNxb2NHR0xXYkV3TEQ3?=
 =?utf-8?B?R1VnTzNPR1ZadGNZK1BIMlNaTm5VUVZIdnRzV242ZVFvV3BFYW9qd0diOVg5?=
 =?utf-8?B?dGdtdjFJN3NJYUdySE9zZjhqNjFvaUJlVGdTRGxEMzUyWm96aHFFSjN6ZFZu?=
 =?utf-8?B?aU5wWjVSOHU1S0NsQUtDUzdhMDFXdjBRYjZ3dTlLcERrQkRTV21vQzZkeWJ2?=
 =?utf-8?B?b3ZqUzhmZ1JsanB1UjE5WVkvZEJkOHA1bUJBTmNYUVZ6R3d2MytpMktjV1Rt?=
 =?utf-8?B?dzQzaEc2TUliZEhkcjRjR3BMc2l6ODZzbHJQTUNNZ2VLT1lEWFJJdlZSL3ZS?=
 =?utf-8?B?Yk9TeGtCOWxka0l2aTFXc2JORURmNU5kSXYxRTBud1hlRnFKTmRRZysvTDI2?=
 =?utf-8?B?S21UaW13cGpwd1R0eTkxWDJiQlhOS1FCRkRsUmpzRUVCelYzdzFSVkk4MHU0?=
 =?utf-8?B?QllYdlBJUW1JSFlEQmFaUXFDMXVoc2RRckVabGZFZVBoUVhPaEhhdTZpV3hE?=
 =?utf-8?B?ZS9mWUtoMUJFMjRUVEthTlhPSDRaVFhIaFFIWEYwb3JVbkdMNnhXbzFEbktL?=
 =?utf-8?B?UWRUTS9Wd1pIUWFrM2NNRnpyRzZzSWJMZVM3bWZsbVpMSTIxZDVkRyt0Umtz?=
 =?utf-8?B?REo2LzdXeURjeUhJczRDWFFoN0FZUFhyWnl2cUtUazZxeTZJbzRSVE9MQ3JO?=
 =?utf-8?B?cUFuMEgyYVI0RlZ3U0MwQ1hoajRyYU14RXVhY2dqYXV5UHNkT2Y4TXNVM1RB?=
 =?utf-8?Q?XM+oC56p?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ce9589-0478-42ef-2be8-08dbbd9b4818
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 07:44:43.1973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9gaPsqu34cTPFytT6sK6eZk8KsyDekpJt8ITI8KBSd6vNvjLMWU9HwNrXoFvlv+tvAvRQeZSbihjqVTp2g7uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4388
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_04,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250054
X-Proofpoint-GUID: zYElsHPLe0bAxzwMj05dbPJV6U_NjIED
X-Proofpoint-ORIG-GUID: zYElsHPLe0bAxzwMj05dbPJV6U_NjIED
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230925 00:06]:
>=20
>=20
> =E5=9C=A8 2023/9/8 04:13, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230830 08:57]:
> > > Add test for mtree_dup().
> >=20
> > Please add a better description of what tests are included.
> >=20
> > >=20
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > ---
> > >   tools/testing/radix-tree/maple.c | 344 ++++++++++++++++++++++++++++=
+++
> > >   1 file changed, 344 insertions(+)
> > >=20
> > > diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-t=
ree/maple.c
> > > index e5da1cad70ba..38455916331e 100644
> > > --- a/tools/testing/radix-tree/maple.c
> > > +++ b/tools/testing/radix-tree/maple.c
> >=20
> > Why not lib/test_maple_tree.c?
> >=20
> > If they are included there then they will be built into the test module=
.
> > I try to include any tests that I can in the test module, within reason=
.
> >=20
> >=20
> > > @@ -35857,6 +35857,346 @@ static noinline void __init check_locky(str=
uct maple_tree *mt)
> > >   	mt_clear_in_rcu(mt);
> > >   }
> > > +/*
> > > + * Compare two nodes and return 0 if they are the same, non-zero oth=
erwise.
> >=20
> > The slots can be different, right?  That seems worth mentioning here.
> > It's also worth mentioning this is destructive.
> I compared the type information in the slots, but the addresses cannot
> be compared because they are different.

Yes, but that is not what the comment says, it states that it will
return 0 if they are the same.  It doesn't check the memory addresses or
the parent.  I don't expect it to, but your comment is misleading.

> >=20
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
> > > +static __init void mas_subtree_max_range(struct ma_state *mas)
> > > +{
> > > +	unsigned long limit =3D mas->max;
> > > +	MA_STATE(newmas, mas->tree, 0, 0);
> > > +	void *entry;
> > > +
> > > +	mas_for_each(mas, entry, limit) {
> > > +		if (mas->last - mas->index >=3D
> > > +		    newmas.last - newmas.index) {
> > > +			newmas =3D *mas;
> > > +		}
> > > +	}
> > > +
> > > +	*mas =3D newmas;
> > > +}
> > > +
> > > +/*
> > > + * build_full_tree() - Build a full tree.
> > > + * @mt: The tree to build.
> > > + * @flags: Use @flags to build the tree.
> > > + * @height: The height of the tree to build.
> > > + *
> > > + * Build a tree with full leaf nodes and internal nodes. Note that t=
he height
> > > + * should not exceed 3, otherwise it will take a long time to build.
> > > + * Return: zero if the build is successful, non-zero if it fails.
> > > + */
> > > +static __init int build_full_tree(struct maple_tree *mt, unsigned in=
t flags,
> > > +		int height)
> > > +{
> > > +	MA_STATE(mas, mt, 0, 0);
> > > +	unsigned long step;
> > > +	int ret =3D 0, cnt =3D 1;
> > > +	enum maple_type type;
> > > +
> > > +	mt_init_flags(mt, flags);
> > > +	mtree_insert_range(mt, 0, ULONG_MAX, xa_mk_value(5), GFP_KERNEL);
> > > +
> > > +	mtree_lock(mt);
> > > +
> > > +	while (1) {
> > > +		mas_set(&mas, 0);
> > > +		if (mt_height(mt) < height) {
> > > +			mas.max =3D ULONG_MAX;
> > > +			goto store;
> > > +		}
> > > +
> > > +		while (1) {
> > > +			mas_dfs_preorder(&mas);
> > > +			if (mas_is_none(&mas))
> > > +				goto unlock;
> > > +
> > > +			type =3D mte_node_type(mas.node);
> > > +			if (mas_data_end(&mas) + 1 < mt_slots[type]) {
> > > +				mas_set(&mas, mas.min);
> > > +				goto store;
> > > +			}
> > > +		}
> > > +store:
> > > +		mas_subtree_max_range(&mas);
> > > +		step =3D mas.last - mas.index;
> > > +		if (step < 1) {
> > > +			ret =3D -1;
> > > +			goto unlock;
> > > +		}
> > > +
> > > +		step /=3D 2;
> > > +		mas.last =3D mas.index + step;
> > > +		mas_store_gfp(&mas, xa_mk_value(5),
> > > +				GFP_KERNEL);
> > > +		++cnt;
> > > +	}
> > > +unlock:
> > > +	mtree_unlock(mt);
> > > +
> > > +	MT_BUG_ON(mt, mt_height(mt) !=3D height);
> > > +	/* pr_info("height:%u number of elements:%d\n", mt_height(mt), cnt)=
; */
> > > +	return ret;
> > > +}
> > > +
> > > +static noinline void __init check_mtree_dup(struct maple_tree *mt)
> > > +{
> > > +	DEFINE_MTREE(new);
> > > +	int i, j, ret, count =3D 0;
> > > +	unsigned int rand_seed =3D 17, rand;
> > > +
> > > +	/* store a value at [0, 0] */
> > > +	mt_init_flags(&tree, 0);
> > > +	mtree_store_range(&tree, 0, 0, xa_mk_value(0), GFP_KERNEL);
> > > +	ret =3D mtree_dup(&tree, &new, GFP_KERNEL);
> > > +	MT_BUG_ON(&new, ret);
> > > +	mt_validate(&new);
> > > +	if (compare_tree(&tree, &new))
> > > +		MT_BUG_ON(&new, 1);
> > > +
> > > +	mtree_destroy(&tree);
> > > +	mtree_destroy(&new);
> > > +
> > > +	/* The two trees have different attributes. */
> > > +	mt_init_flags(&tree, 0);
> > > +	mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
> > > +	ret =3D mtree_dup(&tree, &new, GFP_KERNEL);
> > > +	MT_BUG_ON(&new, ret !=3D -EINVAL);
> > > +	mtree_destroy(&tree);
> > > +	mtree_destroy(&new);
> > > +
> > > +	/* The new tree is not empty */
> > > +	mt_init_flags(&tree, 0);
> > > +	mt_init_flags(&new, 0);
> > > +	mtree_store(&new, 5, xa_mk_value(5), GFP_KERNEL);
> > > +	ret =3D mtree_dup(&tree, &new, GFP_KERNEL);
> > > +	MT_BUG_ON(&new, ret !=3D -EINVAL);
> > > +	mtree_destroy(&tree);
> > > +	mtree_destroy(&new);
> > > +
> > > +	/* Test for duplicating full trees. */
> > > +	for (i =3D 1; i <=3D 3; i++) {
> > > +		ret =3D build_full_tree(&tree, 0, i);
> > > +		MT_BUG_ON(&tree, ret);
> > > +		mt_init_flags(&new, 0);
> > > +
> > > +		ret =3D mtree_dup(&tree, &new, GFP_KERNEL);
> > > +		MT_BUG_ON(&new, ret);
> > > +		mt_validate(&new);
> > > +		if (compare_tree(&tree, &new))
> > > +			MT_BUG_ON(&new, 1);
> > > +
> > > +		mtree_destroy(&tree);
> > > +		mtree_destroy(&new);
> > > +	}
> > > +
> > > +	for (i =3D 1; i <=3D 3; i++) {
> > > +		ret =3D build_full_tree(&tree, MT_FLAGS_ALLOC_RANGE, i);
> > > +		MT_BUG_ON(&tree, ret);
> > > +		mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
> > > +
> > > +		ret =3D mtree_dup(&tree, &new, GFP_KERNEL);
> > > +		MT_BUG_ON(&new, ret);
> > > +		mt_validate(&new);
> > > +		if (compare_tree(&tree, &new))
> > > +			MT_BUG_ON(&new, 1);
> > > +
> > > +		mtree_destroy(&tree);
> > > +		mtree_destroy(&new);
> > > +	}
> > > +
> > > +	/* Test for normal duplicating. */
> > > +	for (i =3D 0; i < 1000; i +=3D 3) {
> > > +		if (i & 1) {
> > > +			mt_init_flags(&tree, 0);
> > > +			mt_init_flags(&new, 0);
> > > +		} else {
> > > +			mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
> > > +			mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
> > > +		}
> > > +
> > > +		for (j =3D 0; j < i; j++) {
> > > +			mtree_store_range(&tree, j * 10, j * 10 + 5,
> > > +					  xa_mk_value(j), GFP_KERNEL);
> > > +		}
> > > +
> > > +		ret =3D mtree_dup(&tree, &new, GFP_KERNEL);
> > > +		MT_BUG_ON(&new, ret);
> > > +		mt_validate(&new);
> > > +		if (compare_tree(&tree, &new))
> > > +			MT_BUG_ON(&new, 1);
> > > +
> > > +		mtree_destroy(&tree);
> > > +		mtree_destroy(&new);
> > > +	}
> > > +
> > > +	/* Test memory allocation failed. */
> >=20
> > It might be worth while having specific allocations fail.  At a leaf
> > node, intermediate nodes, first node come to mind.
> Memory allocation is only possible in non-leaf nodes. It is impossible
> to fail in leaf nodes.

I understand that's your intent and probably what happens today - but
it'd be good to have testing for that, if not for this code then for
future potential changes.

> >=20
> > > +	for (i =3D 0; i < 1000; i +=3D 3) {
> > > +		if (i & 1) {
> > > +			mt_init_flags(&tree, 0);
> > > +			mt_init_flags(&new, 0);
> > > +		} else {
> > > +			mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
> > > +			mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
> > > +		}
> > > +
> > > +		for (j =3D 0; j < i; j++) {
> > > +			mtree_store_range(&tree, j * 10, j * 10 + 5,
> > > +					  xa_mk_value(j), GFP_KERNEL);
> > > +		}
> > > +		/*
> > > +		 * The rand() library function is not used, so we can generate
> > > +		 * the same random numbers on any platform.
> > > +		 */
> > > +		rand_seed =3D rand_seed * 1103515245 + 12345;
> > > +		rand =3D rand_seed / 65536 % 128;
> > > +		mt_set_non_kernel(rand);
> > > +
> > > +		ret =3D mtree_dup(&tree, &new, GFP_NOWAIT);
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
> > > +	/* pr_info("mtree_dup() fail %d times\n", count); */
> > > +	BUG_ON(!count);
> > > +}
> > > +
> > >   extern void test_kmem_cache_bulk(void);
> > >   void farmer_tests(void)
> > > @@ -35904,6 +36244,10 @@ void farmer_tests(void)
> > >   	check_null_expand(&tree);
> > >   	mtree_destroy(&tree);
> > > +	mt_init_flags(&tree, 0);
> > > +	check_mtree_dup(&tree);
> > > +	mtree_destroy(&tree);
> > > +
> > >   	/* RCU testing */
> > >   	mt_init_flags(&tree, 0);
> > >   	check_erase_testset(&tree);
> > > --=20
> > > 2.20.1
> > >=20
