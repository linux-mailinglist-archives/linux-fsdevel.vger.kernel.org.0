Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A52A5BA395
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 02:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiIPAwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 20:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIPAwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 20:52:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906377A74D
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 17:52:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FNmrwa010472;
        Fri, 16 Sep 2022 00:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hQ7VidKxWElq04JBOT/GoqnbAjbnRu8CurLKkpkWpFY=;
 b=yPSZzfCiC8g7YYJWsZ6PFapton3KqGDHGFG+jXlydn/4KDHN6ICJ3STzgTYy6uTzXHmw
 VvO0HR1veD1kHpeQfO/gaES7NqU3hBe6qLj6vyK6DmAX3gh83o1j4htAwYFB/4pI0LCA
 K+HasDvVLrIWK8n5M+1lZ2govz3+cohXodUuESFUMGA3ty47GvRO17DgLgOj/wi9fIsW
 dz26MtLCYAgwBqVG2FmqVXsD4N9dEB4IehAkTciq0wtP4QHbiGCxVUcgqb0eplHENZYa
 LyWWJIe5njIsc9SnSnZseggAsKpSHal/LoXWgJOdujcLeE309nIBHM9i/QCAjfefwD69 +A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xagvtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 00:51:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28FNw2A1013381;
        Fri, 16 Sep 2022 00:51:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8x946jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 00:51:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJDmDePbIZRmi5u+LtK+NsvUhFJpB0qnj6SglkW3IHRpKs/XJVx7vundaOq4qAUfzCfEa8oYrzuh7Pe6yWZQkul2O8ZxJk0UpgvrGUdPZBsfoXH7E7ntkXzkJ4QpTMyUNOcwXGK0ZEr8qefLAiLvCQuLZErmx/11cQrhqyUfEAnfw27CAZyUzueool93sxKPE4JmGksYepwFs2ygvZFVs4zW4LC/PfVNfl6FEpUcbbmf3O15HcfmF/1paH4OJuWCl6YYDR2LJBIPKoGd4KgVmpBkYNkTtkePhvdPZQgFAa1Kq/HvuJU6BASrGnvvkzYp/R2kw14KpSmz1Wb+NzBcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQ7VidKxWElq04JBOT/GoqnbAjbnRu8CurLKkpkWpFY=;
 b=nksRdWc4DLuCmfKi8STtF99f0HTOg2TypXCpLxOK9KS0KiuOuMavGusgv5H4JXYJN0YjKET442cDHyOuFdDuhfv8ILZj8RYzsI+skxCuKft16RPlbcNftJCLBuwS3SDmB12l31bZhAGJ/CJiEdbNCFd38HfqpjZFbLOFp9vfb3iW9/yQRrBBlNXQPfViBmPNmnQYWu67u/oIvQCEC5PPxV4ruP3PA1Wi2ZWjZJcdgrbbegQl2gusrkW+pRscBLIP7TSEpIuerbdU0+L/k0PfBKop9OWaKE6Xe4TMMyI7YNXkj5q1jatvg4hsOT9ekx3FDHyL3gO1dgDjzkpWL5gqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQ7VidKxWElq04JBOT/GoqnbAjbnRu8CurLKkpkWpFY=;
 b=ZEZFCgNVW+ITjHm6q8qbjiFPTFIoegQCZCu2FHwgDsm0jQ9RX0WFt82tt3jHPJ3JHqU7gGzTF/HDg9JZpTkqYYa2YhFsWJaShj7Lc3nAuOERtmloGEvWkiLzhgEN3PeNmn5qCEBVdkqkxBtykqbjkr3nBMMRN+3/yvZP1pWS4S4=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by PH0PR10MB5846.namprd10.prod.outlook.com (2603:10b6:510:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Fri, 16 Sep
 2022 00:51:47 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%5]) with mapi id 15.20.5632.015; Fri, 16 Sep 2022
 00:51:47 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: Is it possible to corrupt disk when writeback page with
 undetected UE?
Thread-Topic: Is it possible to corrupt disk when writeback page with
 undetected UE?
Thread-Index: AQHYyVOZuHnP7uLChkm+T/SiMC7uC63hFndwgAAc0YCAAAERAIAABf0A
Date:   Fri, 16 Sep 2022 00:51:47 +0000
Message-ID: <9c5f2012-ac88-7e35-ca08-ca94483da840@oracle.com>
References: <44fe39d7-ac92-0abc-220b-5f5875faf3a9@oracle.com>
 <SJ1PR11MB6083C1EC4FB338F25315B723FC499@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <cec5cd9a-a1de-fbfa-65f9-07336755b6b4@oracle.com>
 <CAHbLzkrNnp5SsMUJykK5M_sy+C1+smm1CgYvaboO86FfLbZOnA@mail.gmail.com>
In-Reply-To: <CAHbLzkrNnp5SsMUJykK5M_sy+C1+smm1CgYvaboO86FfLbZOnA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4429:EE_|PH0PR10MB5846:EE_
x-ms-office365-filtering-correlation-id: 351d3956-6fdf-4ca4-45ec-08da977da204
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y4sZZg7p7RsW3HHup08XbWTmfvZlY9kvzoBqLjyi5WNSmjTV5ygTOt7Ydw3zpukl6FCocugTG5OnLQgbicxohx+vQ4I3ShjbI6GKmpRyz6dZZ9lvYF0nT3ltYHiz3vfvdiP0JqF1rzULeuD9e8Zc8UclX1gzDHrZzRULBagJ9gJaK2hjzbAUOuKJYVHk60efL02efEQoSB4tku3mQKRYZb8pA5z2RR1pOnB7ipRB5nk8zwORxY7bP6KA8e+VslevorsNY/39XIGKKuj5beCc9Kdm/fH5du8FCz0Wgy9yKIqzrb3H+kTM6+J9hSHH+ZPHCqm5ndOjiJrELHb1rUfMk+zkwyAJvjVc5p0V1p3BNKrlk8wwqXx4RxwmGXKClncISDup2zVcewrQIEHX72VzQj/hYERNAeWCB/HIah/mL8JtTSLtLcAoROPHDwwpWJzkvuN1OaGUBobBYtvfQ2YLAmotyLJUiGKxFZRurrP/SNTD2z+qWEImrhFC2HCxYnJe1wOX+FhZfuzMdepvomFkxHtp94jKbc2o8cTMCu3f7JZUoG04oUuQqSMSr4UIurleHgZ2JKqeuPNvMhwgUk0wPeb1toaqpboVVyiq8udI+u8ANfgxFseKzzm6VbOgKNhhz/S91IdG4raG0wU9IOk2KRQJlvSC20Sw6XJreais4Ro+AD9E1V3Qv8v+hesUTJa443CDwpGqcxptMSz1dt4uKrFNfl/BGV2NvZKjjWzdwFA+CXK6Jer3mLHuRdHse4tnC3uZVqfEUkmmIyYHp5qTClMLn8oxB0KvPoHu8oyS8fAAkZuNdmtrR0GzEtqQEMD8RxZUT/tW68L7GKQL8Usr5grKXDDuBviOyVkXL9cG9ww=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199015)(38070700005)(44832011)(71200400001)(41300700001)(478600001)(76116006)(86362001)(6486002)(66476007)(8676002)(5660300002)(6916009)(64756008)(66446008)(66556008)(66946007)(26005)(4326008)(966005)(8936002)(36756003)(316002)(54906003)(186003)(122000001)(6512007)(38100700002)(53546011)(31696002)(6506007)(83380400001)(2616005)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0cxMGV6UHo1L0k4ZzVrWkR6SFBWa0xCNHBwT08yMzdZc29UQ0NHc1N6Ujhz?=
 =?utf-8?B?V0d6ampOUnR2ZE91cjY3L2xBMXVtc2FTMVZCR0l4L3JBaWtpeCtWekYyWmts?=
 =?utf-8?B?VjN5ZnF6RHozSzBYZlB3WHdBemF3UGdwQm1FR2poTmpRbDhxYkVIWUsyWUFE?=
 =?utf-8?B?Mlo3TEpRTUc5OTk1TldwV21jUmh3OVpORXZCKzdWeEpIZ2xMQW9GdTZCSFNE?=
 =?utf-8?B?UVJVNXVDNHRYeEpZT0dNWENyaWx4eHpBQzNVMkkwQlJ5bnJ5Umt4WTIrb20y?=
 =?utf-8?B?WHFRWnRwM0NXME9wOXhqM0M0QlplUWFsbWdzcjI5aCtLZkROY3ZFbnh5aXA0?=
 =?utf-8?B?enNqNVhkODRLUEtISGNta0tqYXJjL1JlNVFzN1dUUWFhMEVFTWZ3UjJHYklD?=
 =?utf-8?B?UGNEc2JSNmNuNkZOWEF0QnZDQ0o5NEozSWw5dU0xSjdLZXplZG1iYnVjTzkz?=
 =?utf-8?B?eFIwbEViUDBicVpsQkJPVEhTMi9keXN2UVQ0NUxzK2x1aVFlOXN5OW1oZnQ5?=
 =?utf-8?B?SkpGTVBCTyswTkJuMlA4dUsvZks0ZWp3YVhCdU1CeUpHTzdlNk9VbUxmMisw?=
 =?utf-8?B?UmE1RE1BWVNFUWVJbFFIZ25majNKcmVtQ05YUGl6azk1Q0xCN3NvZFZuSlFQ?=
 =?utf-8?B?Z0Jrd0dxOWV6NFFVRi9IZU1qRm9tVThJVkNqSk43TnVLR0dJWWNhSXdzTmhY?=
 =?utf-8?B?OXZSUlFoNzVlTnpvYkZjc0NWK0Y0NGxGNWs0SlM5am1EaldRWmcwSTROMUFk?=
 =?utf-8?B?T3FuYlR0UEdRbGhjd0J3bHRTV3ArbElCblBzNmNBTUJjOXo5c1Q2UUJSU0Yx?=
 =?utf-8?B?NTlQV0NYdTJYZnppZ1h3NG9LY3FnVGUrUEtmMnczV2pFaW83eFY4Z3RjUGpi?=
 =?utf-8?B?VS95VWxjWGUySDh4VlYrenAxcCs5UTFoUElsN2FzS01oaVg3MHF6Rm9mMGF3?=
 =?utf-8?B?TlNTQzROQ2JYeFlSemp1YXl1ajV3N0labG5lR01VYVRCSDg4SlY0UTh4c3M3?=
 =?utf-8?B?c1B1YmNEYlRFSWQ0N0FKN2t3RjJHQXlXTU9PVFFxeGRwSnp4Wm82dXg3amtH?=
 =?utf-8?B?NE1XcHoxTzVuWUxnZjc1VEdQRzl2QWkyZTRXbHVaVHl3RUxNMFFPenRZY2wr?=
 =?utf-8?B?b3hIelhua3FvMkFndXhTK3FqcUhsVjlXR203dHF0Rk9vNjJlSnZScEdMTHpl?=
 =?utf-8?B?VVVWVW1tUTJMZXJWZFkyZCt0WENvRjlzZU5QeWtFMDlHU2VOeVRWMTcwWmc0?=
 =?utf-8?B?QjZJTnlFdTJrL01LK1dTWElldm0vYkdKSXR0NzhhOC9hK2dJVENGRE14TUV3?=
 =?utf-8?B?YWp5QUZXR1h6RWIraHY5WUFzemh2ODhxMStRQy9LM08xSExCaHBvMXBIZHRL?=
 =?utf-8?B?dDdzcVBnU0Q1WHYxb1U4VkZJd2lzd095Q3A4aVBQd3VuNTU0ZHc5SmlLL0di?=
 =?utf-8?B?YVhWVmtEMlhnbHp5b3BWdmZXWEcrUyszTndydThuN3g1eUhUb2dLSG5vQ2xX?=
 =?utf-8?B?dVcvSWxGczZPQjdTYkd0Tmw5djF4QWlqaTdVSkE2QnQvQkRINWVUc29sSkRq?=
 =?utf-8?B?ODRnVmJCdkhKaXVhNnRKNXFMMUhid0xmMWZrWHh6bmRnbnpsSUlobndqc2Q2?=
 =?utf-8?B?UTI2QytCbmNGSXd1aEVqeU03UUxlOFY4UVF4TzRHeDh0QnQvUnBrOVR1NCtp?=
 =?utf-8?B?T2t5c0tmSmF5MHkwTjVUNFVDbXNlaHdraU0veDBIa3I2bEVoc1lEWk5GbG5u?=
 =?utf-8?B?aFFOazUyMDJtckViWThkTkNiZ3VuWlJlc0lYanJ5Ym9BTkVQTUFhQXBleWVm?=
 =?utf-8?B?a0ZmekJrTjlqTTlCZmR4UnRVcStkaEl4Y2hTektHNENRSVY1YnhxcW9rQUhL?=
 =?utf-8?B?cC9kQW5YV0VDb09nYlY1Y3RiRVZCOXk4b05ZekJBaGFOY2tpVEVPUVM2K0Yw?=
 =?utf-8?B?M2QzVlRORm0xMjJ3ZWcvbzQ1eW1LbkVIblp1aE5hTnArYlpnS3loVWxhRW0w?=
 =?utf-8?B?SDFzREUxWk9Lamc0MHVJdjZ0bkR3dFNrVEZkNC9rcUVBVHZXSEl1a25MZEdL?=
 =?utf-8?B?TnFKQ1JMeGhScW5Cc2VGZXJjdGxnQ2ZBRjVhRVZUenh3eEh3L21zNTBwVHl1?=
 =?utf-8?Q?cnsY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <383E8FA743111143A9E305AA985DF9B6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 351d3956-6fdf-4ca4-45ec-08da977da204
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 00:51:47.1085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: voocX+PdwwIT3/RC8YL5k3H7Fy1qTi1FSfcGeZe/VPiBpgtKJW6B12d/0lFMUFtq6ftvx6mhvipS2YGbzrt7oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209160004
X-Proofpoint-GUID: D1hDS6Vf2-CrHR1uzCt67jhnGDLI16ZH
X-Proofpoint-ORIG-GUID: D1hDS6Vf2-CrHR1uzCt67jhnGDLI16ZH
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gOS8xNS8yMDIyIDU6MzAgUE0sIFlhbmcgU2hpIHdyb3RlOg0KPiBPbiBUaHUsIFNlcCAxNSwg
MjAyMiBhdCA1OjI3IFBNIEphbmUgQ2h1IDxqYW5lLmNodUBvcmFjbGUuY29tPiB3cm90ZToNCj4+
DQo+PiBPbiA5LzE1LzIwMjIgMzo1MCBQTSwgTHVjaywgVG9ueSB3cm90ZToNCj4+Pj4gU3VwcG9z
ZSB0aGVyZSBpcyBhIFVFIGluIGEgRFJBTSBwYWdlIHRoYXQgaXMgYmFja2VkIGJ5IGEgZGlzayBm
aWxlLg0KPj4+PiBUaGUgVUUgaGFzbid0IGJlZW4gcmVwb3J0ZWQgdG8gdGhlIGtlcm5lbCwgYnV0
IGxvdyBsZXZlbCBmaXJtd2FyZQ0KPj4+PiBpbml0aWF0ZWQgc2NydWJiaW5nIGhhcyBhbHJlYWR5
IGxvZ2dlZCB0aGUgVUUuDQo+Pj4+DQo+Pj4+IFRoZSBwYWdlIGlzIHRoZW4gZGlydGllZCBieSBh
IHdyaXRlLCBhbHRob3VnaCB0aGUgd3JpdGUgY2xlYXJseSBmYWlsZWQsDQo+Pj4+IGl0IGRpZG4n
dCB0cmlnZ2VyIGFuIE1DRS4NCj4+Pj4NCj4+Pj4gQW5kIHdpdGhvdXQgYSBzdWJzZXF1ZW50IHJl
YWQgZnJvbSB0aGUgcGFnZSwgYXQgc29tZSBwb2ludCwgdGhlIHBhZ2UgaXMNCj4+Pj4gd3JpdHRl
biBiYWNrIHRvIHRoZSBkaXNrLCBsZWF2aW5nIGEgUEFHRV9TSVpFIG9mIHplcm9zIGluIHRoZSB0
YXJnZXRlZA0KPj4+PiBkaXNrIGJsb2Nrcy4NCj4+Pj4NCj4+Pj4gSXMgdGhpcyBtb2RlIG9mIGRp
c2sgY29ycnVwdGlvbiBwb3NzaWJsZT8NCj4+Pg0KPj4+IEkgZGlkbid0IGxvb2sgYXQgd2hhdCB3
YXMgd3JpdHRlbiB0byBkaXNrLCBidXQgSSBoYXZlIHNlZW4gdGhpcy4gTXkgdGVzdCBzZXF1ZW5j
ZQ0KPj4+IHdhcyB0byBjb21waWxlIGFuZCB0aGVuIGltbWVkaWF0ZWx5IHJ1biBhbiBlcnJvciBp
bmplY3Rpb24gdGVzdCBwcm9ncmFtIHRoYXQNCj4+PiBpbmplY3RlZCBhIG1lbW9yeSBVQyBlcnJv
ciB0byBhbiBpbnN0cnVjdGlvbi4NCj4+Pg0KPj4+IEJlY2F1c2UgdGhlIHByb2dyYW0gd2FzIGZy
ZXNobHkgY29tcGlsZWQsIHRoZSBleGVjdXRhYmxlIGZpbGUgd2FzIGluIHRoZQ0KPj4+IHBhZ2Ug
Y2FjaGUgd2l0aCBhbGwgcGFnZXMgbWFya2VkIGFzIG1vZGlmaWVkLiBMYXRlciBhIHN5bmMgKG9y
IG1lbW9yeQ0KPj4+IHByZXNzdXJlKSB3cm90ZSB0aGUgZGlydHkgcGFnZSB3aXRoIHBvaXNvbiB0
byBmaWxlc3lzdGVtLg0KPj4+DQo+Pj4gSSBkaWQgc2VlIGFuIGVycm9yIHJlcG9ydGVkIGJ5IHRo
ZSBkaXNrIGNvbnRyb2xsZXIuDQo+Pg0KPj4gVGhhbmtzIGEgbG90IGZvciB0aGlzIGluZm9ybWF0
aW9uIQ0KPj4NCj4+IFdlcmUgeW91IHVzaW5nIG1hZHZpc2UgdG8gaW5qZWN0IGFuIGVycm9yIHRv
IGEgbW1hcCdlZCBhZGRyZXNzPw0KPj4gb3IgYSBkaWZmZXJlbnQgdG9vbD8gIERvIHlvdSBzdGls
bCBoYXZlIHRoZSB0ZXN0IGRvY3VtZW50ZWQNCj4+IHNvbWV3aGVyZT8NCj4+DQo+PiBBbmQsIGFz
aWRlIGZyb20gdmVyaWZ5aW5nIGV2ZXJ5IHdyaXRlIHdpdGggYSByZWFkIHByaW9yIHRvIHN5bmMs
DQo+PiBhbnkgc3VnZ2VzdGlvbiB0byBtaW5pbWl6ZSB0aGUgd2luZG93IG9mIHN1Y2ggY29ycnVw
dGlvbj8NCj4gDQo+IFdlIGRpc2N1c3NlZCB0aGUgdG9waWMgYXQgdGhpcyB5ZWFyJ3MgTFNGTU0g
c3VtbWl0LiBQbGVhc2UgcmVmZXIgdG8NCj4gaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzg5MzU2
NS8NCg0KVGhhbmtzISAgSSdsbCB0YWtlIGEgbG9vay4NCg0KLWphbmUNCg0KPiANCj4+DQo+PiB0
aGFua3MhDQo+PiAtamFuZQ0KPj4NCj4+Pg0KPj4+IC1Ub255DQo+Pg0KDQo=
