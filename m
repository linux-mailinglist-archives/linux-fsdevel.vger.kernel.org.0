Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934C632C4FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbhCDASx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:18:53 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:5041 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345702AbhCCG65 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 01:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614754736; x=1646290736;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=M6px86qYittYAHc++4yKFel/SHClM8raObiG2HgxbKw=;
  b=MVRobM+GWYmmmOC89n2swoUZlQ+JtEAbBz4iO1qcaf9o2Z7csmyWdBeK
   MPJcZmpR21QYziiOuPkgy5VVCYeFKAQbNymD053Ir5d5id4tWN+qB090y
   jTAzZJSylIGH+tzKrRlPDyewJRLBNGY5OIGi8clsIlbdPlTyWD0grXoNi
   ulX31BX7HTTbC3AtQe7klAp+agIypc67UbedYD7b8ez9PZ2ZXyQBTomzc
   wg2Pe8pP4sdKm3cvdJMVsaqu1J2N4ctHManciBcTSvJi0kYSIwq37LtBS
   091wa5fsws+Lz7vOIH61pNCDQJV/GfoLD1GNWoawXIhWLsXNZefByRWzn
   w==;
IronPort-SDR: vDbLinehq9e1t53SrA+oG85Hu+unVKA6fjmQh3OIG22UU2BBhHIvTIRtkGXMk4IBLow0pBS1Sn
 DLVCwq0Js8RlAAHwHdmNoGWsmaxkQy+DegsPa55Fg/1ssOBczF088dmtAVqqLmzTt7gMyxr1+k
 gY+euKGtDoGti5Vc2ode7eEg+Dd09p9BLU8YIr7Ncyzso4nrzwQaWV7XMpKSd42LDbmpdCX8JR
 Y5CpdVjr0VXLvtye//enGkLh4hihkqcMNuJG71Zl0hnmisCtJTkU4mfXwNgV3bG+nIdwyPFcG/
 3UY=
X-IronPort-AV: E=Sophos;i="5.81,219,1610380800"; 
   d="scan'208";a="271848526"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2021 14:57:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHUa3DDPYnW9/BV6ho73iuQGiuzZYSs054RoSpFpEaYZOIyszSohS2GFfaHoPy8aqPngU/RJss1kQIpoQ86UiuqMbuu3lBGnywAM/vPSpJi6IYMc9nHVJDcCHO+U/9+zBfmbjalc+0SHFqMphQjTh/n2ToAo0YoYkeWZLktZu8kI8YHjrSMJUIFI/n7XBCKM7bPt1vtY1RdMoHpy900o65pq/f+DIsCdAsDt6SrQcjdJfJxoVlEgTidruzE9/F2mkbdRTDdUMJ9eD5Tlia56evaiGgJ3ChKvO1zkDjCkdLaLZtoFF9JvzK0ZW101Eq+5dLr0HsPP4mqskRYzP34hCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6px86qYittYAHc++4yKFel/SHClM8raObiG2HgxbKw=;
 b=adwA/H2b0Wty5EgIt6bF9205QB+s8gv0bVWmVGdDusamKJ/2TBo2nMmxXJVbrv/3fZjovgpc8SJX4t2jdMAoPrA/j4iWzIwgifZgAQzWVt0OEPiXARLxTVNXuFqg7o5FwF+JSSubSF1JSXn099uVuJ5ZTzpeyNz2iXF6hxqqHHAvWn75w1YouonHf8KOnbtPMI/oxG5A9dPK3iliCqi50V6OtKGWXUg9VyEMTDRz9bTdDHi6RRbAdrLUx0qu3VWlkKebE0+86CmxQ1YiYxOH42/a2lk3B/4PaAYLKsFjYyUhJc3xBL9Zqw07KZGeK62M0YKPqE4OrQWvA3e8dqkidg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6px86qYittYAHc++4yKFel/SHClM8raObiG2HgxbKw=;
 b=yQUNCDZfYvzqCdKgjJBNr7POaIO9tJJQg7pA7YNvoxOJ/hdAhXejXhWFqSW02q6MOocQsvY5VCXXqxFZrQ43Tq1pnHVXyRTrDEhgru7amLvOFoa0kqzzF6D1T3h88Q0ZsGCYZ9xyrdL7MHX84oSTzRYZgc/w7gyvcdyVknXyGmI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4871.namprd04.prod.outlook.com (2603:10b6:a03:4e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 06:57:38 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.029; Wed, 3 Mar 2021
 06:57:37 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Pintu Kumar <pintu@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "sh_def@163.com" <sh_def@163.com>,
        "mateusznosek0@gmail.com" <mateusznosek0@gmail.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "nigupta@nvidia.com" <nigupta@nvidia.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>
CC:     "pintu.ping@gmail.com" <pintu.ping@gmail.com>
Subject: Re: [PATCH] mm/compaction: remove unused variable
 sysctl_compact_memory
Thread-Topic: [PATCH] mm/compaction: remove unused variable
 sysctl_compact_memory
Thread-Index: AQHXD41VmHVMaaygcESwzSP7eEOUuw==
Date:   Wed, 3 Mar 2021 06:57:37 +0000
Message-ID: <BYAPR04MB4965756AB8024F40A4E2418C86989@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1614707773-10725-1-git-send-email-pintu@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ccfe96a-843e-4eee-9f93-08d8de11a179
x-ms-traffictypediagnostic: BYAPR04MB4871:
x-microsoft-antispam-prvs: <BYAPR04MB487116500255BFE6F22F835086989@BYAPR04MB4871.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 13HeRcdneoeeGgeUH+5Ha4OZETKxpFt1O8ZP8JnCw7WoHt9RSAuuAHPlsRsYz0I4HmREtEtCc5qN1ZqNJ4J+lAwLQJ9J3ru+wxzfp6z0zdmfq8y4ZYdjZJxdI2Sxwsy7SCt59618wSjfntCDy528Zr/hEZcg5c4wLRAMqxRnnU4tIEWn/YEF8TqFhpFKh0neN0BpcqW+GgovMzGf39blJ6E8kf6xTICsw4DfDwEISnSf45XzqLhQM01sSjkWC+t+IkWve+FCheWshv+B5fj9LH3MMO9ywxhX3xozN16xa/UQTvrNnigbGC6zgHgINlaL00yjhst2Uo6QEzyboq+d/ZVIpmYt7jC331qzc1BAb97kW9Sv1R3kO0bPpGcafxweWU8L8ZQ5liTTSz6IEpQhX2O2ynodp/E54rYzoZrknnuSQnpBObocQhLbD0X0paS6t5EsXzDJuUIYdNvIYeqz1GlWei0rGnCtp9r0Bw/1b8vHde3kIuWK0wbx/4SaWLmSnPVB1qBCVAUOlTx15rzwcrs5h+LqJXp/O9mFdmZFmAxvZlGSoUGaAN1j/zpLR1cs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(7696005)(8936002)(8676002)(478600001)(7416002)(52536014)(4744005)(186003)(5660300002)(110136005)(71200400001)(26005)(316002)(53546011)(64756008)(66446008)(66946007)(66556008)(66476007)(4326008)(2906002)(86362001)(83380400001)(921005)(33656002)(55016002)(9686003)(6506007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RAYav14oz35OlIqDkX44nb0ID39E+ZROf0tJZRNv0AMrByIRaiIA46yOPlMS?=
 =?us-ascii?Q?3QPNmAfvl7XlR6HbcYZ2BJ5RR7nwR02ALx9DXTcDozncOk0VwjoH0WWsEktg?=
 =?us-ascii?Q?gaFnbYmnuecHk+z5nqCm9xZHkWsxZj20UIBOkxsdGKGpz3F/ApWgaVMXLPHQ?=
 =?us-ascii?Q?rPcLdHgnNvKZUnniZ93YUBuCXVGOfexcfbzyYSVVkxwG9cLmJO8BN09bozsY?=
 =?us-ascii?Q?0wMQy0vwHZCLLbFRjwUgIA9U36KBj9Ou7LuCE9BY6RF5mSNTrQ9OFmv8qhuA?=
 =?us-ascii?Q?3Fs2s3OvKEXd6z522zq0hyYD4hZ7GALtj4ddcGSxxRMP//A/pBNbFyMpr1XZ?=
 =?us-ascii?Q?dUgJvuURrzEOcSNtGVVhu8VAk8QC4ODHXZeDRpCcd9zbyQBUXeJ71Fsi+VOJ?=
 =?us-ascii?Q?oinCPE6Uq8zZx2YfjFV2KwqVhhe6+waZlVSTDwrThMLAJdEuUCQoaP+lyK/U?=
 =?us-ascii?Q?0QkgoI4gtb7roTaTHaozAqgV+1o8CwVrGBOHt8krVRMifEXotzs/7St8fY0J?=
 =?us-ascii?Q?VC92WNXExyrPLawkk86LARM1oLB5HCYdN9qYeB5D1vZAggjO5YcYSUYpBv0/?=
 =?us-ascii?Q?wI42bcTqh3gtjU+pHbE5eK09aY/AeHdNZVpViRBOyHPZE7bNFCIz09XvUCEH?=
 =?us-ascii?Q?+LYj8F2/EcWUdFIU1a2j5ckUI25EGh72dwwbIXumjWFRqouzar0qLRvnH3zK?=
 =?us-ascii?Q?42LH/0Zt9LTTigAI/VYYlDd4tlSuNts/9ef47nEV2bjkHmD5kB+pcNfglcoR?=
 =?us-ascii?Q?62mH/sY1JNCEf2DqcB/aANskmZZNhpZWtexN4pk8klU8YomcvVoumSHKJ62P?=
 =?us-ascii?Q?a5VWjoVQsDSWotBOWf7sOjxF2belShTryfwKBF505I6mY8ghyKVTH18lyw4t?=
 =?us-ascii?Q?Fow1FPf7r4aDwtN0Z6l8f54nY4uK7pbZVa9OMDHlmRCZNL51hMpTK8N1GFW1?=
 =?us-ascii?Q?DJd8PoZ8eBpg7DnunmivYeD5UMS5wJjrHeAF+k7nsV3ck5i+pgWcVr/AiFXv?=
 =?us-ascii?Q?suU2/svwOgoWtMSwTf89MoJluH8RS+NW88Tti5BgcRWu1TxgcF6Eq+6TL9nG?=
 =?us-ascii?Q?FtWbhn6w9djShXKtCq40D37PcExxmhcm9v4J2Zwwoe/0R/8mttufozZcN8wj?=
 =?us-ascii?Q?fHS87LrnTzPy5u0iSiSbfeJP292Sf9SDK5Fng5z+xuys10ThdheKfKad6NXn?=
 =?us-ascii?Q?zn9UUv6DJt6xjH7wtTBLkjnMwIYJxujU7KJ8hSAclbIEmSaoieJKber8Ggi2?=
 =?us-ascii?Q?5R49GYoJx9s1q5ScvBXmV/sfzd9xTUYoqV39STGp2qfnoPbo9MzFMEs7MZyR?=
 =?us-ascii?Q?K5Qov3aDOkPZba3gOsHY4GNS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccfe96a-843e-4eee-9f93-08d8de11a179
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 06:57:37.6978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qkUiC3W0PLdwv8HrGRwNxH99X/ouJM+KKcCKt4bg9UCpdqxv2pNh++CWQxvd1uQx2zbQNvClECwJnHd0mlQuVXX37Nv4g0aROFq8UxJT7fQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4871
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/2/21 22:21, Pintu Kumar wrote:=0A=
> The sysctl_compact_memory is mostly unsed in mm/compaction.c=0A=
> It just acts as a place holder for sysctl.=0A=
>=0A=
> Thus we can remove it from here and move the declaration directly=0A=
> in kernel/sysctl.c itself.=0A=
> This will also eliminate the extern declaration from header file.=0A=
> No functionality is broken or changed this way.=0A=
>=0A=
> Signed-off-by: Pintu Kumar <pintu@codeaurora.org>=0A=
> Signed-off-by: Pintu Agarwal <pintu.ping@gmail.com>=0A=
=0A=
You need to specify the first commit which added sysctl_compact_memory=0A=
variable and if exists the last commit which removed the last access=0A=
of the same variable in the file mm/compaction.c in for completeness=0A=
of the commit log.=0A=
=0A=
=0A=
