Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE15975B0FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 16:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjGTOPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 10:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjGTOPM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:15:12 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A29D26BB;
        Thu, 20 Jul 2023 07:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689862509; x=1721398509;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=MefOI/dOt4p162yhIK0Lq/JkpEUwa1GWe5Z9SW6ZffXIXBnfSQLiPab8
   /RqSN/W2LJrVipXBFn2VugnBmVTJ7n3vVWOton/gbSmml1gZXvtjiNAlV
   /mBfj7c3rx2iF1wcb+BfjOcWi1k3K8cENc+QiDULZeUmmDWLuByHOCrZv
   QTaYtdxwsZ4Wxqlu9w7NC6CuZOLHRumNm0csi6QYHD9pDEf20HTXuMrip
   zqcunq8oYwocMV6GXWCnHwL7UXwN2RrUn/jehonm9MYqelU0dqoUH7yo1
   bpaiiGbGpBuIGOObLwRhl4xb8BX+MgoFi81h5GvrBqNO42qzKR6EW1sMl
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,219,1684771200"; 
   d="scan'208";a="238971386"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2023 22:15:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGZmM6SGvIm3cj/zfa21be/6FxUjLZSSltqV8pkC3bG0yr6eHUmpwA+jKx/ARD858tr7gmxLcGgKBhE8Qt5RfseKLXjumNL5pgI67jqnX7C6D0Hcrpem9Bu7Z8/6tXnh010MmB13ITTEo8GiA2+dBD1Ps9oKkOY4j/NAaZ8neWD/USHuVfhAqXHTLZ7UZ6NnbuF7iyj493DvMB5ahpFjhfeHyUsTF2WeWgPD74F4TrudMhukArE3Mbyn5n1my2SSu7rd5sIy14+YI1S+B//1C1oiVgWgyLncc6pxQ906/98/wR2skHcDvt/TZKfH+SCZ6rmhwEEYkMhzhNkWTRk8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=WfN0uXtgPFL+N9Ryi8ceq0ewCgfL477LRPV11KbWT8j2R3c4Gk9Kq50cphrE1JeY70PVsL84HByI4gUyRIpPtJCJ8r6aLeeJrajzz8are3F1Xa/6Uy/avFqIiIVu48Fq4ixCWC0mlH6IwxBfwZJiz5cF/or8/GhLt9X2bbC45TDdXpHLHxIW5RNttdSRU9auTSFrBvg6p66dPXglu3YABTRNcKjvL1jCwF+3yYhJS24ThoQtqpAhvK26QVJBkDd2sXua25NETlE+ZdtJZ3Ed4yeTEbpVmgPfPsjD+GjriPIiDM1rCgLh/EltYj7xCubwqnfqB/9jfB54GT+q9m0GCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=SJ8luUCX5HkWEXktRWmcY2uCFJcnh6UeuefIlrZOmJuSi8GA2irYC/fw5EVFBvkaLSb+sp3ISuuk6YDjLOy/R2VImKkPvYhdrfLQO2MIWj45lbvn8W0KoNf7iWF92NN5N5B2ZaXSGC9L7X9rNhkz2azy0wvrdqWicg2QSadr8Ko=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7658.namprd04.prod.outlook.com (2603:10b6:806:14d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 14:15:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::64cc:161:b43c:a656]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::64cc:161:b43c:a656%3]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 14:15:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] block: stop setting ->direct_IO
Thread-Topic: [PATCH 4/6] block: stop setting ->direct_IO
Thread-Index: AQHZuxNGGrQ7dkGeRk6nimBnlIHHxK/CswKA
Date:   Thu, 20 Jul 2023 14:15:05 +0000
Message-ID: <2f73984b-c104-c5f7-bea4-6e2a873462c7@wdc.com>
References: <20230720140452.63817-1-hch@lst.de>
 <20230720140452.63817-5-hch@lst.de>
In-Reply-To: <20230720140452.63817-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7658:EE_
x-ms-office365-filtering-correlation-id: 3f97bc94-3292-4c94-a833-08db892bb793
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qr66ox30vAqLORpzdx04CVMQEIcxeFE9mGCfYx/Sn4Lq09w7KgUmEwz8pRvq2jRof5eagpUppEcndJCOzj10utb+qLjLyT1zYCjvtyCBqCfjpsGnCYvDWogo/tS9/FszIwPzV5bqiA9bpQVrFg6OSGKpUj4h6OMN4koUH3K+HWd4Hkf6whnjzreVjQqxB+TAV1YO0M8Ykttfi6vf67nt21Po4yYQVebNjP9174khRBTKWzbl1+7l2N7qzXk3s1cwQQ5PrWT4QduxA5DoKJH/HXav4M6kw3EzNKQ0YKENrImEYOQBl+hJ1loFAukj3XDWF2kOaW61BzEbN8UdqCFsbG0iRqF3f6h8zgfG2g2Bj7+PMJO78Zqn3dE0CqHm2cjtbseUD2yqChCJma0soNR7lRrwPZhs9eIZyTWIBUTz5cIeOzIuQwytzlMCUnj8KYu4e7Wmao2vJTshAX4AXMK8WrbZSVX4UEZ1O1t60yJpdOk4WHDva6DdSJnlhnEj2xaum5tmrZPyMwSc/lPIOJTGCKrhniNbRZzIabnJC7exqT0gJDzMULNHZ6Gm9v1ck+LUg4z+2jkbnyx+NdLmdaWmkmptdmMkiSyvIjWmgdTw7GBfgwEi3ZYYHLfbqlj2egTm3J2cWrVAI6OfzPXWlfmkWj7Elk3A4QNgGOs5eKCATSCSi/PX5PEffixkiWT/8wum
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(86362001)(478600001)(4270600006)(19618925003)(26005)(41300700001)(186003)(38100700002)(71200400001)(31696002)(110136005)(31686004)(54906003)(8936002)(8676002)(7416002)(316002)(2906002)(4326008)(122000001)(558084003)(66556008)(6512007)(64756008)(66946007)(6486002)(66476007)(66446008)(38070700005)(6506007)(91956017)(82960400001)(2616005)(76116006)(5660300002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zi9nbEJHY0tvcnZUd0JLejZsSDdRQXk5VW1iUllVeVptUGNIZTZ4VDRvbFBC?=
 =?utf-8?B?UjN1djVwSG5kWTEyRVY3TGtSYThPbi9md3paTHQ5SGVSOGxZbjRiY2Z1MGFw?=
 =?utf-8?B?ZE80aytPdW5CK0dMelJsSjgyTzdiWmI0S282Tk9JdGNVQ0JiRmNQTFFER1F6?=
 =?utf-8?B?cWxaM1dKRFJWR3VBM0VRWTIyTnhxSXdvcDFhSU5TSXIrdU1QYjJvVmZYQkJw?=
 =?utf-8?B?Tkp3aWtESHMzQmRSK3B4UlJHOWN2NkIzSFF1cU5OdEVjVnRKYzllcC83SGJQ?=
 =?utf-8?B?bCt2MCtLbENmLy9BMXVla3BzQ3lCUk5IbSttL3B3bkg5aFhPcGp0SGVwQ0dw?=
 =?utf-8?B?eTlicldBZTY2eFptdlZRYWZ4SUY4VzR4eGxwUmx5VWJLem4rakJFN2NRVGNm?=
 =?utf-8?B?ZWhDVURmSGdJbmVEa2V5eHdTTjg5elRFd08wL3VlU2RKNWV3aUF5UzV0Uml1?=
 =?utf-8?B?OXlIb0gwWE13ZERHbExMM2pOOVRYWGgrUVl4bTVycmQwdGFMc3NQaDdId2lM?=
 =?utf-8?B?THZURXZlNkdIUGZKM0ROaUhaendmaldEaDV6VjNEZm43M0I0L1JuZkt1Q095?=
 =?utf-8?B?bmt4eVYyL1V5UUtqckM5cm9CV0JhWFJvU1M2TFlpWkhBMmlDQjNyZGJiWDZk?=
 =?utf-8?B?Y2FZRHRaeTFrUGFaOW8vWi80Vjc1aEhRMnVpR3dqemNWa0E1YkM4ODNtWWVX?=
 =?utf-8?B?b0pRM1pPeWlLN3JFMHprZjR2QkR6Y0RzWlNZSU42Ny9wL1BkN2lZNWVnQXVx?=
 =?utf-8?B?OGhwazN4alJoSyt3SGdBNkJ4b00wbkdZNm1PNm0vMHVlNVc0QXZxdWFKT0dx?=
 =?utf-8?B?SXFhanVUb3FUdmhqemp3MjJKOW5JTC9HTERZajJTcnAyRFZKRm9BYjdIeWty?=
 =?utf-8?B?NTdSNkEvOFJOMU9HSHFGNGhxV0NpMU9DT01od0NYU2o0RkZKNGs1UThYY1dM?=
 =?utf-8?B?STlTc2hkTkUrQkJKT21UbnUrY0xyWktxQ0NtRTRaOG81U3FmVXN4K2oxd3gv?=
 =?utf-8?B?VXFIcUNJL29MQ2VlWHBtOGxQRUk4SW4rQWVuRVRnTjJrTlZjNXJNdG9vdGJ5?=
 =?utf-8?B?NWw5bjdnL0d0b0FiUFAyMjkrZlc1dTRGNzBXWTIzSDYycEU0VDYxQWtKQmJO?=
 =?utf-8?B?V3puNEVhb3hxOGhYYkx2SWdIODYzc3pXaU5Nelo5ZkhTZU1WWC9MK1RXVE0x?=
 =?utf-8?B?Z3oyRTVDM2JuWnBlYTFpcFppblp0aUZtbXE0YURGaTN4aDNzV2d5ekdyQk9N?=
 =?utf-8?B?b1BUSEllMU80L3drT2Z2UUdHcVc5SDZKM2RXdEc0T0pORHdya2tPUzNoWjl4?=
 =?utf-8?B?ejNraTdEV2RPQlNiaGNZODJGUGpJL2xrMjhaNno1MUF2UDZtaVhEaDBiVEZ2?=
 =?utf-8?B?enE1SzFwK1hYMzJXNGhWdlA0NWMrMUFia0JIU0JlZXd4dEcvRVpQekpOcjVM?=
 =?utf-8?B?QWxDcGtXOGVSTGxOMWNuMndJaGdrTm9OdzhlMlI4MDZGaWxRSXowdFJpTzAv?=
 =?utf-8?B?Wkd6SEw3bHhjME5aQy9DY2RsU0hTeXFJN1paRitYcGx6NWlMKytLck1KY1pR?=
 =?utf-8?B?QW81N1JaYnlIeGkzN1BoN1pmRzJGdTFGSzB6Vk8xNHYrYVBKRFVFYXlrUTdT?=
 =?utf-8?B?eWg4NXhiaGFLeG1LdFREdjNpakVNalpBbkg3QWFtWkNHTkcxa1cvdGVPdWRZ?=
 =?utf-8?B?eHZHV1RyVW5tQlNJSm1YdSs1ZEpCNHpRRnpBaWI1Wm83dDhCTi8yOXpBbE5L?=
 =?utf-8?B?MEpNNDR0WFVRbU04TXc0dHJFYkNIN1FwSkxMLzVZY0xtQ1Z4eEhtRWVzbk5y?=
 =?utf-8?B?Tm0zY05Vc014cUZMRCs3UTJCZDc0bnlmdmlDTU4yOHphZzJlWkJmeVV1bGFD?=
 =?utf-8?B?WUNxOUEzM0NpNW9tUlp3QndqaHRzS1FpMldlUWxvSzBDZUIwOHRlbkt2b0pt?=
 =?utf-8?B?cGZwcEFVT3hxWWttVDgzZG5LOEgrNHN5SERqL2RoRUkrNTcvYWp2VVVVMEMr?=
 =?utf-8?B?SHJQUStpTDhBTWQrcFJLclRPYTVNVTJZZmFLSkYrSEF1MEp1elNraHd3VlNr?=
 =?utf-8?B?U1ErU0dSQjdMOXlJODIxaXVWUUZqVWdlZGpVMHRCZy95QjlSUDZIUkVkVXdn?=
 =?utf-8?B?dGtqVDFIQnBXeUpHV3h5ZjFiM0lVOW9QMHVsNzNLZVVkZXUvVW1aS29qa1BK?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC1F61F79535F346BCEAFEFD1436801C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UDJJUmJwbUkrUEE0SS83RDlHM2lCVzYvQThQdUJzaFFGQTNlVHc3UHVwcFRr?=
 =?utf-8?B?OWRZMlAwSVlueWdzdEYzYnBmVUZOK1ZKSUc5NWpNREpoRmo4N0ZMMnVrSVdx?=
 =?utf-8?B?K1RORmtrVDhkM2Rhbmhuc1RHNmt0VWx2N1dzNnh3MldzMzBlR21rVGx4dHR4?=
 =?utf-8?B?Wlg2SEQzVkRnclAzOHhOdWZpcE5NYmdwNW1TRkZLTURMTEtEbExEQXdvZUJy?=
 =?utf-8?B?SE9wUkIyNzlCNVhlYWNzV3lab2U1RXF3TDRSUlhTSDJOd3paQkVROUgxRTJB?=
 =?utf-8?B?RHluNzdiZTZtT1ZWSTVOaTJTRi9hY2NrTStHZlV0U09BK25EcGdldWYwdXNk?=
 =?utf-8?B?dityeDNjbFlGeUNMZDNtcTRTbHlwUnNITDAxVndwRjVMZXVGN1Z5c3FPK0hK?=
 =?utf-8?B?aS8waWNSaHNsWFVpMk9kbTJqNUlJNmxoc1VHSmNSbzkwNzM4Z1VOZmZ0MEMv?=
 =?utf-8?B?dHpTMXF4NlNsc1lWeTJVRStmZVVQTlRuZkdLZ2h3SUhQaHBQSFA3dThYaEJ6?=
 =?utf-8?B?T2p6enZWTGV3SVVNNUVkajR2RjAzaFBGT3ZZUDV1TzJJOG42aWJhM0lKS3Nq?=
 =?utf-8?B?UEN5MWdYWVBqeCs2YjlYWWNNY0ZWeXBNRnpTTTZPL1MrS0xaWCs2K2JlbXFK?=
 =?utf-8?B?dnU2NE1JZWNOVTFOMHAvN0tDVGJOSis0WWFlVDQzZGpIZ2pCcHpaSHRNQU1M?=
 =?utf-8?B?dTZDTjdOUVQ0ZTkwU3NHQ3gyQm15ZHowdlZvYitBcTNUZXlNTU9Qdy9qZDha?=
 =?utf-8?B?Tjkrc2VVaDc5YlhyUjhFK2FQTW8vTk9MbWcySDNiNE8wai9jQlB3aTNzTlZh?=
 =?utf-8?B?TEcvdEsvMzVlOHk5TURhQk9BMFJydjNoUCt4bW1oYks0bjdld0dJTWFzdndi?=
 =?utf-8?B?dlg4WWJHbTByQ0JHRmZVcW00QXkxaC93UXJablVFMjYwOERKY3RsOGM2Y0ls?=
 =?utf-8?B?R3E1OHFWWnVwM2xyRW9GWW55SVFidDc5bVZDU1VybUJVZzhLTStjbTE0SkNn?=
 =?utf-8?B?Ti94QjNxaEJEaERFbW1idjNEZ01MWEtWdjdQSWNiR3VXZ29VeFdDWGRXa1lN?=
 =?utf-8?B?T0Y3UkFPSlRPVExCOGkzcGR6V0pXbjBRVmVwRFpBb0lteGp2bjlhbWlsM2Zn?=
 =?utf-8?B?QU15dW4xY213Y2pwMm1OdEZpRUE1aWNoWDZ0aktZeURqazB3dHdsTlhBMDRR?=
 =?utf-8?B?b2tzQmMzT1hrcHNoNk8vMnk0RFdSTVhqdFRGNFVidllHUTlYMktZWUlBTlN4?=
 =?utf-8?B?aGw1dDl4Tk1ORXQxUG5qZHlnQ2d4aGFhVTkxbjg3aXNJSTR1ZVozK0ZNb0t5?=
 =?utf-8?Q?kz+EmVjQiu6TA4oxCcvmznKg3SZWA3IQ1K?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f97bc94-3292-4c94-a833-08db892bb793
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 14:15:05.9310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IoCemEKcHJM0IC1V0KfIVRKqxHY6lcAQUPixOCFwYLgRraVEomTbhwzqXGxOSYQs/42EPSoHO4hOI/1OlNIfEUdM8GKd61DYKl8BHxp/0ZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7658
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
