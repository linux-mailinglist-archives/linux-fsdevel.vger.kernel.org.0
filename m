Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4F378101C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 18:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378540AbjHRQRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 12:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378560AbjHRQQn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:16:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1763C21;
        Fri, 18 Aug 2023 09:16:41 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IEl66w002534;
        Fri, 18 Aug 2023 16:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=A6tXYQ8Exso5wScw7GAzyHi6jmYyUZec3vQsV3YCtLw=;
 b=yB69uScIQmiTrJQUuYha7383qWCd5ToIrD7kUNP8ET1yi5kXSb7SJ+mAkdVcDwwff03g
 adzz+vEdYRYYtdkTb38L9Sn/sE4fZQ0C8Vl4ldvXqMWzQvfqcceFCf2lDlhzpFjZmUk2
 u+qP9QyQuWuCpoeovhdsyfZ24StkMWsbiGSJSA/ww2SZiAvHCnHG5jdSVGweh64JY7+u
 Y5CYNKbKzREUP1REDci8QREmH/8k/Af1Kg6F9E9ZoEMwiQT/jcjonmmP4lv0LtKmK4hW
 zU8LVLS612/QBU/3xHERM3vDWl9CyvsnkkiQjrnqbEPH4oLWV2SbqM+yyRlADjNrFSwr ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwvbga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 16:16:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37IFoU9P027391;
        Fri, 18 Aug 2023 16:15:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1waqnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 16:15:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUJ5gmm4ju1MYhsNm2c/hhei+QjuoMMkbcKrD+zDS/JrTSNDqk+OnCW3LaG22dq5pujtLoS0GHnqWrDQLGtr3Ss7SO30oxof+dLBvfcTOTpPalXmfMF1EgGX+D+DHquJs4n6dn2CepupMvhbmlAULkHXpeRAyB1NV7d07NbDvYeAZO9q1GvvgTXFT9XbC9RoGKiWv1QaZbdUHGkbhbx139bF8RTyeZgjGEKlOMld6u3e+Tw2LKm70ybPzQ/XIgQxM1pFK8cQxNoAYhs/h1Q1sROHpayJHh77JSL1Pp/1Yw+8sv0WaLoSTfQkBREycfamhmdOrvocFuhl3mm15tvhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6tXYQ8Exso5wScw7GAzyHi6jmYyUZec3vQsV3YCtLw=;
 b=O+akRp3gUUBCfJdJVi6l9OidF9jVOyfzlkODl5Xtz12yrB1DTLgDOLdygdYhLLFMasT0DpHWkBvhjXZuwo2vBZzPWactZs1+iDowbO6gtUDdViK2i3Xx84ANLLJrNscgS9Hg4M+JC8tPRIaldY6qEMOJhLgeMPVc2o84YPnBMaymaCFUfJRComN2NagjcF/OwTsWDPrvFI1wRnUT+TeiIpJwv4iaX72ZjbSBNyoAV9TV72xuk5lzddgE5XlH0c5RD09WY9/xuTTuRSh4QsOf0RyYCKnxQzzQGHBRU1j7OgxOoEIPb/3DHR7NPtQlhutyrduiHMLR5E7LZGJ/c6V0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6tXYQ8Exso5wScw7GAzyHi6jmYyUZec3vQsV3YCtLw=;
 b=ZkYseqO01maUqMnldfAuFEFD+tDbnODiMb1qve2D71QjeFCT0riRnFxzj09pJ4YMEXTb53p82tCYRJyR4M034ENcPlSWMpzgWTN3v0rSu/TzcHzn+RaojrI1MggGLaoH6ZWphiL2QrMlEi0/A5bBKTkm7xrj0UFtbpyneihJvhU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB7218.namprd10.prod.outlook.com (2603:10b6:930:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 16:15:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 16:15:55 +0000
Date:   Fri, 18 Aug 2023 12:15:51 -0400
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
Message-ID: <20230818161551.z25u7txhsvlq6juh@revolver>
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
 <20230816174017.4imcdnktvyoqcxw6@revolver>
 <51cc7e0c-2fb3-1c40-4cd2-bad15737d616@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <51cc7e0c-2fb3-1c40-4cd2-bad15737d616@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BLAPR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:208:329::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: 803fcc88-f7df-4c52-4cd7-08dba0066666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +CYrxL5Y8i7aOYYi9MqmZJAXyvyb0t6Th5TKqgCJtUmIsniBy+MskwjyNfkoiHoB+qIzkbVjoEWKobqi4hX4VDOHXEn8VrT8cDDo8AkL4KMae8oMZr+4SUKehK8xJsdDdg+xZbg54YyM6f57qC/c8JPMC8dItkmLLo1KUkPPZNji67xcj3Ym65JmMIAjr4tltSTy5joRt9pPi2+01YUpd6BF4E5zIJSOY8zCsJE6+x6bkjYu4dvpbCPFQ4/mlLapzbcjCfGFAfd+kLy5gTqPYs/gOTGsk3P2aIz8/u74HzzWeOp/MrJwjEcU8QyZj2cORIy/Glcy1w5Tu7yi4mJR+R9hoa0xI+yjnHF/5zp/0VZoU+22akXXTeem74c5hQSWKzGtNhHxjkmbaIPw6pdBW7mbSsffCdPzsT1DWELzN533ThWaJRSoZ4N2WkQaLsFg+lSzBvfkC7qu7cGyzMwqX+bnGYp8ERcZKhPZnW3Z/QialSzRPe/JJBHLFs+qhxGpcl0uRvgvv0tLsmUqhh41yCSNbaDYwWQ1ivGdZOlwY2HLdTYy6zimI38JrGmbhrTk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(396003)(376002)(346002)(136003)(1800799009)(186009)(451199024)(83380400001)(7416002)(2906002)(478600001)(6506007)(66946007)(66476007)(6486002)(316002)(6916009)(6666004)(66556008)(5660300002)(6512007)(9686003)(4326008)(8936002)(41300700001)(8676002)(26005)(1076003)(86362001)(38100700002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3lldW1ZZTEvVFZqU0FpeDFibW9YWSt3M1g3SkN0RzJHL2NMWUJZOGY4eUFw?=
 =?utf-8?B?cXRLQlgySjdtaEtqQjQ2Sk50TExVd0hRZkhPUTIvRmV1Vk9aL2FMK2thVWVx?=
 =?utf-8?B?c3ZaVTN3NDNRcWlnVUFKSm5FRWRpNjVjNlAyZ0tjY0QxNUJSeVU5SmlsMXNJ?=
 =?utf-8?B?WWl5c1NjbUp3UnV1ZmNzWDlkNk0ycWdLaDNYZ0Z5UHA2Q0owMjRNYjhONWI0?=
 =?utf-8?B?dGxnOGdzUDdDQ0dTMnl5TWNBOEIzNnZHNzloSHlzdUtSUERCZXBIekdsbi9W?=
 =?utf-8?B?QUVlT2VzQ1ZNYVcwKzQvWE5LcVdYcmppWWplbjl2alJhbGtwekhmS0l5cktw?=
 =?utf-8?B?VEhUTm1NOUtGa2s4cHQrWW9CdEpFd0tMYXhseXIxM2FWbnFJREg5ZlBwODAw?=
 =?utf-8?B?Mys2RXhCMG1IN2RIQVZFbkt0NFM4aFB4N0lMVmZtYXlSaHRxTUNVdUVtUURS?=
 =?utf-8?B?WnM1L0xyeWxPcVVVbFhsL0NGUWpmOHV2bjdpUzF6T25pMEhkV3FJbXg4TEkw?=
 =?utf-8?B?bSsvamY0eVJJWEpoNXUyeU9XeVd6c0laU0owSUFkelJKNkoyZS9EMnN2ZHps?=
 =?utf-8?B?VUowU1FFVzV0RHNiOElGcmFJaHM5U2FkVlFPOE4zN3BOYWpxODhFeGJZdGNm?=
 =?utf-8?B?cHpkSlQrTS9jYjZrTVRjL3ozRFVoWmV4bTU5dUtMRGRpbDdIWTFKMUxJZkRX?=
 =?utf-8?B?Sm1PQVBUN3RkSktSdC9VUkxpdFdaWXZTdy80S2MvTHFhK0ZhV3M4cEwwTEhU?=
 =?utf-8?B?TFdaeExjcmh3cHFvakJLVFNxWXlld2FNLzNmVUJ5dFIyNFhyYjhRRG53QkhT?=
 =?utf-8?B?TTBTYnhVZGZQQTNhQTQ1ZHZ2U0FtakJVSDNmeVd0V0JjcFc0RnVIWlZvOVd0?=
 =?utf-8?B?cjhOWFdja0Nub3FJakhsdThzN0FrL3plOEpqR1FoVFlZdHovbzNhYVVnNGdN?=
 =?utf-8?B?NFhLNVRUNVpBRkd3UDVmSFdlekRVNzlPbUtkWUNuS3g2Y2plVm92aTJKcWo3?=
 =?utf-8?B?WVJwMEI0L0JDZ29OTHU0R05tZDVKcWVqZm1EY2E4bkxoOVZSMmtEeWVJOEhy?=
 =?utf-8?B?YThMVnhyRnhFUUpGTWhnTTJaclRsTXJEMVdJU0hUV2o0YVg5SmtMQ1lZYWxZ?=
 =?utf-8?B?a0hpSjRNQkVzb2RQbnVMQUdKK0RzTnJFQjBRR1JlaklrcEREVEFYemNMbHJK?=
 =?utf-8?B?N0c4aWh2K0lVeDlBbXRYTkFtdmhkVllkbkJ0UTA1dmt2YmJZN1I4RWx4Rlg0?=
 =?utf-8?B?emhBY2QwVGNQdzVqUDU2ZU5BMzZKMU5TM2pIOWRlckF1UXZoM3FtSW1ReWNp?=
 =?utf-8?B?TXNyc3UrR0dZR0tESEF2cXA1Ujkrd0k1R05XVVlIcEtvVGlydG5qYjVyTDk1?=
 =?utf-8?B?b0dlRFYwYlBnTytIWitRQVZWSGJmSU45ZVo0NmhjaHpnZzFxbW44MERiMU9W?=
 =?utf-8?B?Q1BiRXZsT1RJc291bTdSanRDaytWY0VXRE1aVnVzWjl6OTlHdXE5WHBMN2lH?=
 =?utf-8?B?SkpHMndkTXl3ckxsY3JFWllMVTZQMUwvSUJLa1Ezb2FsZXQzbGFBN0Eya2hC?=
 =?utf-8?B?RGF0WjN2WTJ2eHpPWUozbXNCR2U0dDlvTUZBT0toL25SVGtxbFVsNmxsRkZ0?=
 =?utf-8?B?T3JORHlya1hTQzdXNmNrUU5MczAyOHFEdXRIcm1UODVHZys4a0ZnUVpKNzIx?=
 =?utf-8?B?N1ppUUpBUUZFcTdZd2xVTFVyVVdXdzIzS0RQUGl6ai80OGx3K25Bakt3Wmdy?=
 =?utf-8?B?Qy9JeFNSTWZVb0xLUHlDRWF2MjJ1MzQzYzZST2krNG5PNkRyTkdtaW9PcDZl?=
 =?utf-8?B?K2N4b0RkakpmQUhqVjBJSHE1RXNRWEp2Y1RpNms2VWZUUm1Zd3FQd3RBdDBT?=
 =?utf-8?B?T2dyV1JZaDU4RHJ5SDh2NTRyS2s0ejdLcTVTS1FnNHM3akVRbUpqc01xOFVy?=
 =?utf-8?B?aXB4blRPWVZ6WDlLWU8yekFSWXVPcGcvSWpsVXk0MXNYbklXbWlWWEVkbGJF?=
 =?utf-8?B?TkNHbGhJQ3VZVkhnSk5lR3lhNlZaMnViVTB6RVdKeElucjdVUEREckJiWEd1?=
 =?utf-8?B?YTdiY0RjL1IvOTBDL1hzRElWcTFHZ1E5UlFYMFk4QzVLQXk5THRiZ3g0TCtC?=
 =?utf-8?Q?4JD00CFIdTbIhRFd7KkMnHGiY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SDhWbkxZMEF5aHV5S1JCemw1OE44RzNxMGw0ZG1DUllZRDRQcFp5dnN0SmRz?=
 =?utf-8?B?K0F2SE1zSXRQT1BjemNuNlhhL2kwK1BSRitOYis5VFoycGV1Q1dGZXM0SjI2?=
 =?utf-8?B?bVQzYTVHNExZcXFpL2RLb2NFeko3NWRhbmFEd2hBMjc4QXN2NkROTFE0eEZ3?=
 =?utf-8?B?ZllHWVRQUXZSTWJuemhtb3k2eTFkMU1GQnB0bWNDYnVUMDROeUd1WXRqS05O?=
 =?utf-8?B?VVF3cElQRS9CQTdYb0xVNTI4T3VwZ2VER0t0MFEvTHZna0lLMGNrWk5Xa0Fk?=
 =?utf-8?B?b3RaT2YyM0E3dHlldGZiQUpObkdSQld0cHdtdU1iQWJxVlZsNDZsQ0hENGQ1?=
 =?utf-8?B?TTlSSlFZRUQ2cHlBNEZmNkgwb1ZyZXBRamNLYnpKSDBSVWZXSGxDc3hYNmlC?=
 =?utf-8?B?djJad1dqRWJUZitlY25OS1JpUHp4SUdmd09aTHRJT0JaMDdqS0EwaXVKMVVD?=
 =?utf-8?B?MHFhL3dHWTRLZ0dMS3NTVVBqQWw2czZJelJ3cWRJV1g3U3dTcmQ5czh2TWR1?=
 =?utf-8?B?TGN3akErRklIdExvTlhobmRFYTc2Z2ZwUmVPcVY5T2k0b09QNHdVd3pTNFRw?=
 =?utf-8?B?WS9yTEdGa3p1NXJtMENUdjVyemQ5TXY3emQ2QzBHYzhwOGRaWm5NbVcwbkRw?=
 =?utf-8?B?cVZwUjNOd21ieXUzTGhrWGRPb2JuV3h4bktNWE5xTnVYZnRHV2oxamdIeUNo?=
 =?utf-8?B?dTNIUkF0bWJ3VG9WNkZrMkRpVENmeDc4Q2JObW9LVDhOOEowTWhjMFFYZVAx?=
 =?utf-8?B?K0xKSXd0NHlFa0llYmdZTGlZd3p2dWZpTGwzVDNPVHFrLzFZRklCTDBEcENk?=
 =?utf-8?B?RWNRdU05Wjlvcm1UeHJ2cHRWU0pUajdXSDU5US9HTWd1MFgzWG5zdytIN0RC?=
 =?utf-8?B?ZnY4ZUdtb1A4Qm5ReVV3VU9YWmRobGsvTzlpb3oxNHlKbEMyVHFtM1NhYUl4?=
 =?utf-8?B?VjZCamNBZUljMFdPSW5Ca0tmc3dMQjF5YzVkVzJhb1JzZU1aSDYvdzJDWi84?=
 =?utf-8?B?aUZNbXA5eG5uV1hMYkNhZmdGSm4xWVA4bXFFS2ZKaDh6eXdrWFFXejdwSldC?=
 =?utf-8?B?Y0djS2FUb0RuUUk0UWtQWW44WUN5YUliL1JSNDJadWVONjgzM0NRbTd3YXpR?=
 =?utf-8?B?YUVyK1hxdG9wZDRtcnRRK0VYYlIyRHU4b3NJdzllVzhNMmIxczlNeWs5amty?=
 =?utf-8?B?dEhKd0ZLaDlNUENBYStSVUVPdVRmT0FFb2E2NkYvSWpSQ2dqbnY5OUNPMTZX?=
 =?utf-8?B?VnJxcTZMRnZVZGlxS3ZrZ0g4VWd6RW1tbjE1MTZhMVdveU1hUkRGUm1KSFJY?=
 =?utf-8?B?VVVvb05oTm9DUXUvdTNYSkdCbkpmc3M2QWdIY2x3U2J4M1ZaRExOZzE0Tis1?=
 =?utf-8?B?TGRRUE1DV3pnTnZwaVk2dmVyTTRYMWdIazRhbHhjVThsNmtnbTliaHRENUhD?=
 =?utf-8?Q?Rfnb+GGE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803fcc88-f7df-4c52-4cd7-08dba0066666
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 16:15:55.2459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IH8lkb0fzcT9Dw8WDOpCfSwTLBtxQy5L6WayUc2ltdzw2XVbdSmKz8dsXVNErOmrdGtNqrD9IAD3z2qyg84TLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_20,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=694 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308180149
X-Proofpoint-ORIG-GUID: 0qa76hPghFbFhO0g2C-V8dATx_DO3gNA
X-Proofpoint-GUID: 0qa76hPghFbFhO0g2C-V8dATx_DO3gNA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230818 05:40]:
>=20
>=20
> =E5=9C=A8 2023/8/17 01:40, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230816 09:11]:
> > >=20
> > >=20
> > > =E5=9C=A8 2023/8/1 00:48, Liam R. Howlett =E5=86=99=E9=81=93:
> > > > * Peng Zhang <zhangpeng.00@bytedance.com> [230731 08:39]:
> > > > >=20
> > > > >=20
> > > > > =E5=9C=A8 2023/7/27 00:08, Liam R. Howlett =E5=86=99=E9=81=93:
> > > > > > * Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
> > > > > > > If mas has located a specific entry, it may be need to replac=
e this
> > > > > > > entry, so introduce mas_replace_entry() to do this. mas_repla=
ce_entry()
> > > > > > > will be more efficient than mas_store*() because it doesn't d=
o many
> > > > > > > unnecessary checks.
> > > > > > >=20
> > > > > > > This function should be inline, but more functions need to be=
 moved to
> > > > > > > the header file, so I didn't do it for the time being.
> > > > > >=20
> > > > > > I am really nervous having no checks here.  I get that this cou=
ld be
> > > > > > used for duplicating the tree more efficiently, but having a fu=
nction
> > > > > > that just swaps a value in is very dangerous - especially since=
 it is
> > > > > > decoupled from the tree duplication code.
> > > > > I've thought about this, and I feel like this is something the us=
er
> > > > > should be guaranteed. If the user is not sure whether to use it,
> > > > > mas_store() can be used instead.
> > > >=20
> > > > Documentation often isn't up to date and even more rarely read.
> > > > mas_replace_entry() does not give a hint of a requirement for a spe=
cific
> > > > state to the mas.  This is not acceptable.
> > > >=20
> > > > The description of the function also doesn't say anything about a
> > > > requirement of the maple state, just that it replaces an already
> > > > existing entry.  You have to read the notes to find out that 'mas m=
ust
> > > > already locate an existing entry'.
> > > >=20
> > > > > And we should provide this interface
> > > > > because it has better performance.
> > > >=20
> > > > How much better is the performance?  There's always a trade off but
> > > > without numbers, this is hard to justify.
> > > I have implemented a new version of this pachset, and I will post it
> > > soon.
> > >=20
> > > I tested the benefits of mas_replace_entry() in userspace.
> > > The test code is attached at the end.
> > >=20
> > > Run three times:
> > > mas_replace_entry(): 2.7613050s 2.7120030s 2.7274200s
> > > mas_store():         3.8451260s 3.8113200s 3.9334160s
> >=20
> > This runtime is too short, we should increase the number of elements or
> > loops until it is over 10 seconds.  This will make the setup time
> > and other variances less significant and we can use the command run tim=
e
> > as a rough estimate of performance. IIRC 134 was picked for a rough
> > estimate of an average task size so maybe increase the loops.
> I changed nr_entries to 1000, and the measured numbers are as follows:
> mas_replace_entry():	20.0375820s
> mas_store():		28.6175720s
> It can be seen that mas_store() is still nearly 40% slower.

To be clear, I didn't doubt your numbers or want you to rerun the
benchmark.  I was just saying we should increase the loops now that the
tree is faster.  It should allow for you to not need to use clock count
to see benefits - although they will always be more accurate.

Thanks,
Liam
