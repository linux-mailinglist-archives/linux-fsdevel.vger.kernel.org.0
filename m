Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119B66F39E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 23:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjEAVmU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 17:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjEAVmS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 17:42:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA77110F1;
        Mon,  1 May 2023 14:42:16 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341LOcBT007311;
        Mon, 1 May 2023 21:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=oIqIKkV+mXN+M+KlVC9soascZOdeXUNT3GbUh7j2yUQ=;
 b=ZtSqL/rwysSUc+Z/iLkf3oDc7pxGVmdX2sEAStDgCl6NqrrrDV6w6xaD3sPhLGO1OPr/
 B5q7cIyiqukZAayPRHfBKdjM1iett9hWg0vPe5vfOv0G6ED9RdHNL+RmLtob/UbARkQ+
 VFAiLU1VWuUU4CmIjQFE06kIIwFIQDk6y0Ie6suOUNpuv8BU1gorPHEs6YyTAEUIV8Iw
 /AFPjfEiOO6AXiQpVMmdy6dHsY1Bn+F5Q7VDl33ngLilOw5O3o7WgWaA6116rToRAALw
 PovPCpKBYcdpGcVUTYf/JEQONKceB/AmdFZA/X/VUaYcFBOIJJJ+xizEsGjoQ1m75rVR 3Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5fkase-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 21:34:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 341KvSnE002397;
        Mon, 1 May 2023 21:34:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spb5yu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 21:34:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieS3/qLEp45A5eZ4zZ4DEJitNcRZLUywWzL00wmZ3VmTRSwaXXMRpyk2IJnFBH8mQZXaf0+afmqIlDZ4q5j7gWOslGQ69zEiXoidl0a5AdyYYalQIcJItX0YORaevCS/d/kZWMFURJ15TPIQ3W77gy0AFcqAfIpH48LuXIc3VqRxnxEw1PSeJGn7Xwt2ZpyceurqbhqAORFlhkYexOLHt7NfitqB07hs7QF/mFm4P/cnhzYMmbZWnAwKGNhdL6b2uKDlOOS6bpsfZl2nEnG+MgpZJQ3+qWCnBQD//FjzJh3uK35UDVuaSypFrW2myPkR163+nRERXXJs4GUNLWqFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIqIKkV+mXN+M+KlVC9soascZOdeXUNT3GbUh7j2yUQ=;
 b=UF2+Ps/Lx3pgdWcshWpqAIISXQ7DbDfVSKLJkttU9+0vBiteMCwFgDgdBaBqzliGLYLEYvw/YqEiqmLiHsbkTKwWVQo6w3fRDquGVaVczjyR4jYhkJE8Nj4FfWWR9d/hR1GGxDrmvwrhVTbfiYcc90bOL0bnWlJNOVnrtVKEY9y+VXfWhYcaDVZQCyuMenud6VBYBe6dQfYvXMbbkPzCUt3B8Cd8QApir1IaXJFbxN/cyHLWp1p+YQ7MTuABJ7g0qFKvj3zCIPhMCF4aLR42Wp2oSuWlfT1qw3e9Jc4iHAjL+97YGQ5u90lH10Z9Lu0jxYSgYi32Jt95E4uMfQLFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIqIKkV+mXN+M+KlVC9soascZOdeXUNT3GbUh7j2yUQ=;
 b=O5/4W4m0+Ggf3f9QnQbNsrn47d3ukIq8xn4AWf41WmwLfiY2ER1pcdMMDq64i8YnftfqlCibrhbqXKb9i2PPvLgy8mASCBkznJQCgdM8RguKEw1UBVnmUr68J3MO+8D+i2e3mEpdmEpciNkeNiYMLjctZevJFDXTk0csKsO6RUo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4294.namprd10.prod.outlook.com (2603:10b6:610:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 21:33:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 21:33:58 +0000
Date:   Mon, 1 May 2023 17:33:49 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        willy@infradead.org, corbet@lwn.net, void@manifault.com,
        peterz@infradead.org, juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Noralf =?utf-8?B?VHLDr8K/wr1ubmVz?= <noralf@tronnes.org>
Subject: Re: [PATCH 01/40] lib/string_helpers: Drop space in
 string_get_size's output
Message-ID: <20230501213349.bvbf6i72eepcd56m@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mgorman@suse.de, willy@infradead.org,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
        dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
        keescook@chromium.org, ndesaulniers@google.com,
        gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
        elver@google.com, dvyukov@google.com, shakeelb@google.com,
        songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
        minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Noralf =?utf-8?B?VHLDr8K/wr1ubmVz?= <noralf@tronnes.org>
References: <20230501165450.15352-1-surenb@google.com>
 <20230501165450.15352-2-surenb@google.com>
 <ouuidemyregstrijempvhv357ggp4tgnv6cijhasnungsovokm@jkgvyuyw2fti>
 <ZFAUj+Q+hP7cWs4w@moria.home.lan>
 <CAHp75VeJ_a6j3uweLN5-woSQUtN5u36c2gkoiXhnJa1HXJdoyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHp75VeJ_a6j3uweLN5-woSQUtN5u36c2gkoiXhnJa1HXJdoyQ@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH2PR10MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: 09397e23-aff0-4b3f-96a9-08db4a8bc57a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94ahiiDAzmUW4VzF0dHmA5kCHDmvhp791Gc8U/ISV/33d8DfVoyHQuONpy9HjUqyNHaNztp3ewHY4vzI0cSxKijqm2l+iIt7nwh+xi/J6lKiCWrcc3ZEzXbB3fNs0TIuAg50Far0b8FGRiAb7px54BkySfwUcaP8kFqoW6T1X54mlM8S5hyVicOafoHP10w1leals3HbTF30sX1UUMYFpA1fyyGmn8yCq3d75n+JVnBMTd6bwXQMnobYmNVNxJ54Ya9O2MGOSaBejEgNLh5NDs8AEV00CVZI+Jukv1p90vTMyMzbfu/ZmxfynzF/zX1aiGnbEEQywXekE0J4I0Sf7gynIYsLcJMIq6Iy2R2pyN5UgKgDl6b85l6nyi2br411vdTBdgZbUCsfBAlB35jdmsRrOtUzU/ClpSRi+tBQhV9KGIWsMZYMW+2mvH5Mpa8tZU1FAyXbBu8NeoY6TzHIWUnPgXmlYB1hFD7nCpOvPDh7X+7+Pzqnp7vSz8arc4SeFfMzibyZ0hkGxYQ8TFjk/+VxA51WUUXy6NVyzSkapWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(86362001)(6666004)(6486002)(966005)(53546011)(1076003)(26005)(6512007)(6506007)(9686003)(186003)(33716001)(38100700002)(5660300002)(7416002)(7336002)(7366002)(8936002)(8676002)(2906002)(478600001)(7406005)(66556008)(66946007)(66476007)(41300700001)(316002)(6916009)(4326008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkNTdVRvTHNVbHpEdTB1SU10dTh5Und5SkRoamNvTVdzbEdNamw3d3NiVFgy?=
 =?utf-8?B?dmFiZDlRTkVCQ3JyT2pjemdrTlBvOHpOWnE3QjdXUmxPWVJXVjYrdlYrYXJn?=
 =?utf-8?B?Z3FJOTFUWUFkZFhxcEtxc044cnNLVkZFN1N1Ny9mZDdtb21ZU1VXQUkvT21M?=
 =?utf-8?B?aXQ2Z1FMNUlUMGoxUVBMTFdnczJrTU03VHROZVZxMlRiUWpZWmlzL0x0R0lH?=
 =?utf-8?B?VVJHNXdjODVVRktUL01RdlhaUHJrTHViSGxNaVRmTE1ISjJ5Yy9lMXZqUjRE?=
 =?utf-8?B?cTV6Y1I0Z2lFU3FTb0R1UnJod2M4QkowdFMrKzVvcTRkNEJPQVdKeW52eGRB?=
 =?utf-8?B?Rk5PenlBWCswZTEzNkpNcEE0bEJjM2R4NzhTanJwUWdDS1E2UWZGWlprSU9T?=
 =?utf-8?B?cnhYd0VsU0NHM2duSTN1RG9EV1ZjN24yMTJYL0V0eVE2VXlXb1BXckhyZEt1?=
 =?utf-8?B?K2Y5ejQ1T25JL0UxcnhqWW94Qk9HYkVUTDZjSVQ4WWRRVTZ3aGFRZUlaNkxG?=
 =?utf-8?B?d0R4V1JXNjkyVmtVaDBjVE0vazgrQ1k4QlFxOVFid0pHN1JIUjZIQ2JYYnVZ?=
 =?utf-8?B?SVh2UHBsZHZQcTdoR2RRRjdTaTgzQUo1bEdFNmtldWxha0UwQ0JVV1A0L2NO?=
 =?utf-8?B?VlNyNVpsMGlrSnZXRTVKTWpzaWcvUHQ2cHk3eFgvcHp0dERyQnlWem00RDg2?=
 =?utf-8?B?eEVpcUNreEltd2R4WU1Gc0FDbjgvL1pyNjVubTB6OURkY2tvWFhFQUpwQ0Uz?=
 =?utf-8?B?OUlqcmlwQStmOUVOV1gwOWN6T0dBMkw0bnRyRkdZLysreXhkc0tYdWc1cmR4?=
 =?utf-8?B?QWtFVFpFYUs5cVI4NllnWFJ1djlPWWxXWE1NbkNnbGpUTThMNzg4Ry82MWlw?=
 =?utf-8?B?V0k0WDJGdnhldFBIa3FQbGJqQjYvb2ZpMzh5bWdnQnNXWnRGdUh2WHY4Ri9C?=
 =?utf-8?B?Wk9TZnEvRjJnbSszTy81VFM2VUd1QURLSXFrQlFOSDBkbVI3bTRpbmVzUk9S?=
 =?utf-8?B?VzI0SkxQOXZSTHozS0VMdnBORU1pK1pwTldVTzE0Unk5QjI3MU1ubGJIbWdq?=
 =?utf-8?B?MmZxNUlyKzcrdjNwbnNkTjJoY3pVUDFWeEtHbU44Y1pucGVaWnVmeDVPRmRS?=
 =?utf-8?B?RXhSb0RCT3FHM2VSVktVU2pKSGtoUDBCNzBQaTlTZktoWU1YUGRBcGM4WmRL?=
 =?utf-8?B?N2NoMDB3UU51YnA3R3FoWUhyL3RrVzJUYnp3Z3Iyd1duNW5uWXhGaG4yMDZx?=
 =?utf-8?B?bmRObkVYc0tUU1VxeXp1aitCT1hCN0R2cFR5SXZpRjI2WllGZVF1Yzd2NnZz?=
 =?utf-8?B?NHRIRmZFaE1JMUlleDJPSnRiNXZ3TkZ6RlQzTkZxK1lZcm9xTHphTk5sY1pY?=
 =?utf-8?B?MFk5NFkva1pMNFVUWk90TVQ0MzVQOFdCN25qM3BhRWFzdGc3cVhuVXovZksz?=
 =?utf-8?B?clZ3cnlPOEhQM2hxV3JSR3B5WDNxR0NnRGR4Y2pENTVDQWt6WE5jcEVkbk1V?=
 =?utf-8?B?UXBaOE1FeVNCdlFyc0g5UEgwY1lkT0pJcXdNWi9PVVd3OHVJNEY4QVFqQ2lK?=
 =?utf-8?B?UVViMGV0TlRhOGVIYktnbkVXSkZZcldnalZPcVhzSU13VnZOdlJ1eHJPdGpv?=
 =?utf-8?B?WWloZzVRMGp5ZkNiSmkvWFd1UEs0aVZIS1h6L1gxY08wQTU5MERvb1djMTRt?=
 =?utf-8?B?bFY0cmRKc2NHRkxpaXhVNEdOR1Q2OEhlUnRGUlBYSDlLQTRrYk5BaGxuc1pr?=
 =?utf-8?B?S2tzL1dEajUyYVQxSUFWc25DVGxBb1JjWmMwQ0pkRU82TVBjREltNUE2T01M?=
 =?utf-8?B?MGhjSVZySS9CVEp2QlgxTWgzaDh2eTlqTGtxOFVydUpDNXJ6cXBSU3JFQ25r?=
 =?utf-8?B?MGY5a2lFbVVyUWY5N2RTQ0oyQ2RQNWZxMGIvOGljNkVZaHpYcEI1bE5mZ0lF?=
 =?utf-8?B?YnQzQUdBZUpaZGlzZFpULzI5WmJneU5HcXBPK3lYSmJoakVKVXI0QWlPRDFR?=
 =?utf-8?B?elJndm9pdE85SEpOSnplRzJyS1Z2MEJwU2t4VTJZQnNRaVVMWndsa3RHdWM4?=
 =?utf-8?B?b3J4U3lqNzhwMWx2MCtocEFyZThOcEU3WWRqZ0Z4NXhjcTFWdVlib25TZVpG?=
 =?utf-8?Q?deQ84EOGxod3sYWkP38+OXS88?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SGNrUnZwZ3g4RUpJdm84dVpDTmVHRTBkdzlNc3Vkb3pTZ1VNNlI1ZUdvbWUr?=
 =?utf-8?B?aTNFUTJ3WnhmN0tqUktQN05JZWRsbnJVaGJWaDBSNlkyMkllN1l0UzRnYXpn?=
 =?utf-8?B?WXVKWUJPRGdpNFJNMElwMnJFMzluOG9pSU0zNEhoNTFvNW1GdkI3Q1M3c1Vj?=
 =?utf-8?B?ZFVFV1N4d3ZVUnNZU1pjb3RLMzhvMXJTUnpzeUdNYzk5ZmdEdTFOZU9rMzRj?=
 =?utf-8?B?LzlsVXJ6NlBGN3g1UEp6MGRzVFE5VGVpNVBJZ1JWSlBYckg3dnNIaE9Fb1d6?=
 =?utf-8?B?ZXhMNU02bDFLcGI1MmRXUGdibDlQUkxJaE0vVHBBcEhSN0JJbU40akYydFl5?=
 =?utf-8?B?dGl0M2Irb1BGTGhxVm9aVDY5Y2JFRmJYbXNUdVluenZzckRtRVBGOEo4bzhz?=
 =?utf-8?B?emEzaFE5T1FCVk1vQ0JNTmNLK2VrV0E2R1o4b24yQUV0dmxGR2M1eVl2ZTlD?=
 =?utf-8?B?RVA1MlZzQmJpRVRoWDFYaXdGWjRrR0Jpc3FxUDBUcFNIZFFCRnNEbHFSNmxF?=
 =?utf-8?B?MW1yL1NuQTNOeHB6ZEtFMWtIckVpamxlRU5BMGthUk16cjFSWk93aERvOHNJ?=
 =?utf-8?B?WkhXSmJSdlZBQVpRNVhialNHcWVqNThYU0xQSmk2SWJqMWEvSWd4bW8xU21S?=
 =?utf-8?B?RlZEL0ZnWmdCZE1yV0lGckdXSytsRkxaYWg1Y25Benh0d2x2YVlSUGRtampR?=
 =?utf-8?B?cDJ5bmpPN2NPUE1KZHc3c2FGNXVvWVN3aTc5SHA1cGhYYXFuWi9mdGQ0ODZq?=
 =?utf-8?B?emdjcngrSis2WVgxMm14M043WjM2M1l5d2VGaVJPTlBGUVVjcmQwR2xsVlVN?=
 =?utf-8?B?bFZGQkI5bFljYTNJWDBLclFSQUQ3RkFIVUNqclZyWW00SzI1VjlNRE1VbmtI?=
 =?utf-8?B?ampBUVRYaGJtVjh3dHByT1pZN1hHMTZOWDhSUzdoM0xGanI2SktrSmg1cFRN?=
 =?utf-8?B?dUpEaENvS0puTmppdWcxMFBUOU82dk8xT1JrbWc3ODhEY0drczNyTHA5OGJV?=
 =?utf-8?B?RThTazd6Z0YrSVJrWWg5S1U0QlRMTjBlckF6MGVWMUNKOWRMYTN1TWpJM1pO?=
 =?utf-8?B?dUs5NmNuVzJabnBac1ZteTFBcU5uTTBFUyt0bCtiSml1MzJ1MjYxaFlhb3ls?=
 =?utf-8?B?ODd3eU5peVZkbnU0ZWgyQXg1YXRqQlNJWlJEWnBmU0wxMGlLTjRZeWVDYUNL?=
 =?utf-8?B?ZFhqdHRzYU53UjFCQW55QlJNRnlDd2xxT0xTQ0NJMzBVTzBTUXJCekJPWnZN?=
 =?utf-8?B?NWYreE5VeHpBcFNRbmY0d3psaXpxMzdnQmwwR1NJMFFiYXlJWXRhUGY3cUQ3?=
 =?utf-8?B?V3owN1IwcHJsME9IMnJvVG8yOU15QnpwR3Y3VXgrWTNRM0I3d1EzWElXMXVa?=
 =?utf-8?B?RUJ3QjRON0FvejBOalNVb09ZK3MxSjd4aUoxM01Zbm5nOTVBa2k3S3Z4Wmhv?=
 =?utf-8?B?cnJ4Sks2ZmpFN2xyS3BJSjlpcmxubi9hY0k0bzlOUUNJNFhrOHRpVTB5eWcv?=
 =?utf-8?B?ZmIrU0Yzd29ZdnhSeWxsMFByUFBXWHcwR29KbG4zNHZWOTcrajRTbTBVa0ZL?=
 =?utf-8?B?bE4rSVZqUXJBYWpTNGtPTjYzSVpGcEsvZitBQklTN2RBbjVNTi9ndGVUcG1i?=
 =?utf-8?B?S05HN3NDM29Zc3h6VHF6QjZDSERpS1VOaTNOUmtaUElneHptdlU0VGhZbWZV?=
 =?utf-8?B?ZDhhUmluWUdMVDJnRVdLQ0srUWVabVJPZFFPZU5TRk1mSUp5eU1WbmFBMkFY?=
 =?utf-8?B?aExkV2ZLcWY4clpQVUUrc2hVTTJNZ1ZLYXkya294ODV4emFQZTkxS3E5cEEr?=
 =?utf-8?B?VGJFcXRVYnNGQTZoNVhyTUlITEJoSDhBbGV1T00rTU80MStkUGFYdUJjZk9N?=
 =?utf-8?B?V25pWXVDVlNBVFVGQWVNZGZWVDNMdnVLWDVrK0R5S2dDYm05Z2hDby85VVU1?=
 =?utf-8?B?MjB1SjRzV3NEcVk5RUJNbUVzd1pZM2tlWUdHTkowS3ZZSWVRZGJvTXJzaW5i?=
 =?utf-8?B?bDBiS0tsbHMycXp5US9VV2JFZnVRelBCaCtDNU5yWkh0cjZPbE1NY3JhK1BC?=
 =?utf-8?B?bFpkdEd6SEhveUZ5YzJzVUdoNmtuNzY3ZHdkT3ZuQjJkNDgyWlN4clptKzB0?=
 =?utf-8?B?UGs3NzFVcE53MzhXRWVSanNIZU9JMStkd1JaQ0hJMmtKL3RFU2RUaHJFYjl2?=
 =?utf-8?B?SlBtT2E0aE1jYWh6R3JOd0hDL1F0MGtVRG8zd2FuaFRuQWRuYk5WNUFlcDEv?=
 =?utf-8?B?VWI3b2hqNFlrUkJlTHVTQnZTRTBnSWV4T0xsZWcwN280ZVBQM2YybXpLRGNh?=
 =?utf-8?B?RzJVU0p1Z3hmaTZ1M1RvKzNGYUpJOUZFYUErNHB4SlVSYXlRTFNsNlpyLzE3?=
 =?utf-8?Q?knNwpkah2BnktmjyeVFq6jhKzHAFFGqU6o4rT96P8uxeT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: bMa7cwkunDYtYEZBLGPyYKSHuFQspFWVTiWduGLJoCVkHnyPQbAuh1NxtDZAS2rnUnbyDS8goOwF/F8pX/eMTKh3Oq+Olw8aGWXsdntY2ofpxqJtKci8aI8h3NfTgIAobbZz4mehpRAHQLQeAWyLW00OxzXShDVRriQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09397e23-aff0-4b3f-96a9-08db4a8bc57a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 21:33:58.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMXLqazwLyhrVjCOmh/YJCkG2AEmNdpgakpN9kM0d0sgdNVhGOgoH4B9FAvAjTGOPfUMc8XpRDUA/EOr1CZr9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_13,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305010173
X-Proofpoint-GUID: dBg5ZStizV16Btz8PAwRs1Y5vGXrl_Tc
X-Proofpoint-ORIG-GUID: dBg5ZStizV16Btz8PAwRs1Y5vGXrl_Tc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Andy Shevchenko <andy.shevchenko@gmail.com> [230501 15:57]:
> On Mon, May 1, 2023 at 10:36=E2=80=AFPM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Mon, May 01, 2023 at 11:13:15AM -0700, Davidlohr Bueso wrote:
> > > On Mon, 01 May 2023, Suren Baghdasaryan wrote:
> > >
> > > > From: Kent Overstreet <kent.overstreet@linux.dev>
> > > >
> > > > Previously, string_get_size() outputted a space between the number =
and
> > > > the units, i.e.
> > > >  9.88 MiB
> > > >
> > > > This changes it to
> > > >  9.88MiB
> > > >
> > > > which allows it to be parsed correctly by the 'sort -h' command.
>=20
> But why do we need that? What's the use case?
>=20
> > > Wouldn't this break users that already parse it the current way?
> >
> > It's not impossible - but it's not used in very many places and we
> > wouldn't be printing in human-readable units if it was meant to be
> > parsed - it's mainly used for debug output currently.
> >
> > If someone raises a specific objection we'll do something different,
> > otherwise I think standardizing on what userspace tooling already parse=
s
> > is a good idea.
>=20
> Yes, I NAK this on the basis of
> https://english.stackexchange.com/a/2911/153144

This fixes the output to be better aligned with:
the output of ls -sh
the input expected by find -size

Are there counter-examples of commands that follow the SI Brochure?

Thanks,
Liam
