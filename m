Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540F665C3A9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jan 2023 17:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjACQPj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Jan 2023 11:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjACQPh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:15:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6681261E;
        Tue,  3 Jan 2023 08:15:35 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303G44mk007225;
        Tue, 3 Jan 2023 16:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=r5ADQsZdlGskcFOh0RjpgxZ5qdwrmUpcwZYUsekUUdA=;
 b=chtxt9xzY8QPD7eKVvIQhswdpfS0YdaR9k0Sa6w8jqSoJDBKmarWlQTesELhTSmJVX2Y
 XXbHNxIZ6ncdKPCMX/IxZQrX2FM0PECKL2RFxG3Slbq1SgT6iZadaoyxpr54CrreMfdH
 4YiVTKhrUk+hBYD6MFv9M24PWdiwRntXe1cI7eE1W7qyrGz5i3vpJe5L2HauU+q98o+8
 h+eFY7KZYVdLMyHfzasqp15rYd7IczrChE2SacRvWF/ZXzO8Opqt9O/AuQ9ef53jIWh5
 yYgcou5u2zkC34X4Za8AGmHquQU/mjnfS/XrVg0v/12aSLgosXxuDJphq7Yf6WRmNuzw Ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp0vcr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 16:15:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 303ExXFo000466;
        Tue, 3 Jan 2023 16:15:07 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbrc8xew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 16:15:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0A0xpr8mn3gSBfEgoXnLGLvZZdy6FpEPReY0UV6E5D4Lyt0/+a4vaeFckGUlmT4NMy3uhRg7LL6JlcuWJxaBKyMkcM2CQsqyjy7VdX8Yp2PBTAz5OnuHpN+Be0bTPg1yofFwX/PaK1GKkr2g3MlmffWrZfTIHl/D2635A/ZFKR7g8ZDaa5RZjaIhPTlhqpjSpOxvttkKuRhyARgOM+N2vL682Hez3f7q5aH+tU7xWO+hDj2a9i5hQU4HP8Gk72vO7wPcJKaBWvNSVWYj7mqZccjPwmyeO+ihe4sMKsHWwKG7gEhxDTXPxLSIQpikaXU/D/AL6zN08iyL89iOQCJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5ADQsZdlGskcFOh0RjpgxZ5qdwrmUpcwZYUsekUUdA=;
 b=fYCtJ3Ekio8EZuVn8G+GR6TYvQaZgqEoDdgNuZNdMcKQJzQ8ed98dUuAzsjmxkXEkeOsCge7cqu22lOFt0MShseXWJlUwWu2wfer3wOXvVa16ssmU/DWAJdH0INZCksQ3lbPGy9INm6pHP9xFJ25ltBAluTY4qKhEl4zWDHmM8HcaIBNOGVxWS+Mo9bmLGTQ8B1HpU0KpN6/EsP2+jhZaU4Uu7x15KXOz5PM7recI+W6gXtXCbrVaDkkN8OfOZMCXI+Z98cpqDr2ml02PMO9D+bBfVnqJTd/dwptBg6Y1ni00BnRU6LEs4RFNXXwHaXUAQTHnSAqo8/N/bBUyXU1LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5ADQsZdlGskcFOh0RjpgxZ5qdwrmUpcwZYUsekUUdA=;
 b=JSia+2zo0D1KavJCkkQyVkjn/KDXd0b3dhRMpS0E/odiy0ddttYJMbSxAwfImAX6r39DtpcyUnmR+jF9wOFhUfBF97cpvREVawaFel6BuGG8ZhylHoJpq64KbTkhNMqbNp0QpApva7mRkl3DoLh7b+6I143vMQWsANkmw/ZYVww=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6098.namprd10.prod.outlook.com (2603:10b6:208:3ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 16:15:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 16:15:04 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Ian Kent <raven@themaw.net>,
        "chris.chilvers@appsbroker.com" <chris.chilvers@appsbroker.com>,
        "david.young@appsbroker.com" <david.young@appsbroker.com>,
        "luis.turcitu@appsbroker.com" <luis.turcitu@appsbroker.com>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "benmaynard@google.com" <benmaynard@google.com>
Subject: Re: [PATCH 2/3] namei: Allow follow_down() to uncover auto mounts
Thread-Topic: [PATCH 2/3] namei: Allow follow_down() to uncover auto mounts
Thread-Index: AQHZH46KYwHmQVZSuUOnI7kKQrlJBw==
Date:   Tue, 3 Jan 2023 16:15:04 +0000
Message-ID: <EAE9AF79-93B8-4366-8672-20D407694E7E@oracle.com>
References: <20221207084309.8499-1-richard@nod.at>
 <20221207084309.8499-3-richard@nod.at>
In-Reply-To: <20221207084309.8499-3-richard@nod.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6098:EE_
x-ms-office365-filtering-correlation-id: 1b7e4a06-ae74-4a54-86db-08daeda5ac80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5etPrgRpdkUdvdq5wKweQRrKrGSav2DJkaB08ckzZPyyWdsMQLT/LwoLq2LB3tup10Xcx0YtPCbe3J6nO0kQsenmgu57EE+G3qhx9uhQss1KQiDpiSZ4jtvdYzzJMS0+JxzxvcyTKWeF5LxVGB/bcIJZiQk4PiSfazxutwYMS0/lB4vASjmcXKRKlm2CLq2sRGq2vo4m0pUlO6Yb/A9cREt9LuQFubA7Bhd5ZLHEc7ZguKgnMQfOQD71Lfj5qkzuNxJYeEnZrTKvHKJ2RJj6WOSHDPMk+b6JRRpfSwQ3uSBlC2/NemhG9oswDWkDWrxllJ6EW43YMt53LM/6GRJ8w0ZXrdIQ/56XKISwf0FRvlXAkQwJ8j27ZpSAPCANfjjndgHohe9qfIEYyVq+zNksxgvTvxof8IJXSmwpgvTxD54ZeVk47BiyTwhs9RFqicUgpZ9yfRp7g9qrnI2N5/JswGO4kl40Y35uJxpXc9CHHwxY9ZjZmYkeCBcCazu5Tj6t5qQlUYu7LFdECt1yPDHoCSBX9B1cLUYhFRRmrtKuxcZmXZPsyJ87Tdzf/EqI8xe1puXBQffPN9Li1Nh0aitBd32UvFXf1+yXN0/oqn4dpzcz8nIz4XBJAzAO9TT40emCJ8KckEVYPbjEzYxg5/xyiQMnRvaxTYLC9jFpv1yndnuvE1V9P0dEa4KCPf0dNNyy135K46jAdPdWOSyw5NuCOrIPZXppNivJc3hOothK96iGLY4UqB1HZhRDVC1TCGAV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199015)(5660300002)(7416002)(83380400001)(33656002)(8936002)(2906002)(41300700001)(38070700005)(36756003)(122000001)(86362001)(91956017)(38100700002)(71200400001)(6916009)(26005)(186003)(316002)(54906003)(6512007)(6506007)(53546011)(6486002)(4326008)(66476007)(66556008)(66946007)(66446008)(64756008)(8676002)(76116006)(478600001)(2616005)(22166006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BsmZCzYy3puqtxlzgfom6J6hAbuhaX4PuOo1+LN/A2yI5S3eWqFY8j95pX7j?=
 =?us-ascii?Q?c7dla6F8KABX1V/zpbFk+WGFCZm6e3XsNKymbk5lWQwy8Ypbo5JmeqLTz1mF?=
 =?us-ascii?Q?HWoGfr0aA9kHd0EGBiKQHB5wkFf0mjuR20Ch4pB/T+97b7CeqTUKggHkf4b5?=
 =?us-ascii?Q?geB3c/bnpkLZyNh4Vbvm6EE1d/D1oUKZiJpXVNxmU9Yxf6tDwpOm1Ew94ejL?=
 =?us-ascii?Q?FLHusfrogru9HMzFin+7Ay/jpW+kzk6QkC7ua1c3d1IPhWveNviUrnhAh2Wa?=
 =?us-ascii?Q?XQNIC5lhdrTRVtrKorz0L6AJPkl8ENl82cGBbMeqvfyyxS7qeMTEayrekR9N?=
 =?us-ascii?Q?aSB6qa/Q4IUSAELlcCjLJXYmx4ISByHfHwn0yPzxicbWPokYDDAgcMXa/Qfs?=
 =?us-ascii?Q?TMOFeOzw0x3WHpxuNZQSjYG4dBmRNlpkff0oJ91MQK9NLQDyeKiquVa/wKG/?=
 =?us-ascii?Q?VigQDT7pJu0Xl4T7/WEmp+ScjE6mnB3I1J8eDO0lDvqpxa9gPuntsNaaRnax?=
 =?us-ascii?Q?k6EDKZHo/riAn87QOpkBV5EM8R2UQQJmCYLM2+zam32OtCLrAeQw/SGvDI6A?=
 =?us-ascii?Q?Js77CoD3g67TVuJlPYzGX9Ut5fLDuKMwyrxqaZyNP6NcINZfQATk6m5G+Ecn?=
 =?us-ascii?Q?EdEhrQTMVcXBbTRWs0qdtoAY+Oyv/UWZGH5dwDO+8AHg0IBNcIMb9EdoOiEF?=
 =?us-ascii?Q?KKl0EATRmpLk8P7C4IP06F9eZGbECtVShBbC+Ew7YJO/RyWjSyi0V3nK+vzK?=
 =?us-ascii?Q?E5QPO2CMGRgasg0w/A9K9isn1HHWUciEnJfWeElz7ntAlnDFGVtOnT+JUaU3?=
 =?us-ascii?Q?3/1bZyHapE2zhauWSmjtQpsNPQqcGidISFuXuewyPPmioEVjuRZ/yCvQyVcf?=
 =?us-ascii?Q?XoAzfP7iEqbwQ5wYkF/wYGrA53ojgwmciMyoVVwvp9JUklpnZwcRkitggwzk?=
 =?us-ascii?Q?2n/lOMYYFkI8erTtcwkcC76ZhQDmGOMha0921qn2oVpoi+DRoCDhmt6dB33i?=
 =?us-ascii?Q?EaoJtm1dVa3jKzS7RougpUfaJujpbLUDwHd31zH/LalRclsvBhQZPvZPDXh6?=
 =?us-ascii?Q?iBUnJ/2316BJsXMb92OGfFNoirKGS+NFGyklVryMzKamAW1n3BCTEtT/a2xn?=
 =?us-ascii?Q?6sZtoX0DSjYuntmrAPENJeev/xyMWEogN8S/7VTuLGiHb/wu15a4ZWjBmbnL?=
 =?us-ascii?Q?5zYpq+4NoHC/dRL75F2QWRsDKi+rYOFbdbgxe+kT9RfjunHdsNSRjZ97/IBd?=
 =?us-ascii?Q?YtDZIRMPrtunB7ii7sDGotm5FWLlUc35Cz1eGSeoxR8bjT+mynrqO4oAOra3?=
 =?us-ascii?Q?Kjnqqet8/zC5wKZnB8OByJdOyEN8KWaj4yxzENU937utJxbBsU5nUXD87G3h?=
 =?us-ascii?Q?LcY5xud/0nYxP/dgxeI5eWDo9VbVpdRr+lk6z8LmfIoWo9ekHMpJjYpbwbfV?=
 =?us-ascii?Q?cvEyuwCa7mfOL+z8+xrQyhyiHexQ7FJZIm7fvtKGxUGYAu4mlEwF9Hew8gU2?=
 =?us-ascii?Q?NwllHLSX93PP5LkZA3h4ZxEUjxbvHF0QUfy6K4aAD5kZ3s8C+x694hX+3LUA?=
 =?us-ascii?Q?J7/pMRV9fURbDI6ysZNIOuvS1ly/iuEDjBxiDkWOEjv56kSN2dc+ZYVWg9N8?=
 =?us-ascii?Q?jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D73C89D0004DE24AAAEA34BEE0AAD936@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?aLD5+lX+AoanqxgByryeVQMQku2DqVuZbGF50aagJhAZNXr1FkH2pw91aFYL?=
 =?us-ascii?Q?c1nvkaRcrkIBv23sWthpSGr8fsvl+QBVcxIs5K1Fapw9nVm2/2VYe7swqLfo?=
 =?us-ascii?Q?f3ZTNX9YoflBfOjDPyUcPdd8YeVkbgJvIhNpTFYlWROf/fxezCG3m5HcD6a5?=
 =?us-ascii?Q?5OE226A8gDKBWeB4plGVSelMiOzxP4wR3Vs87qcHPRvDWt0gay6prjqIMwEy?=
 =?us-ascii?Q?3MqxLwYutp7poydzRdE2TIfBliVIDfw2bGKnuNvTPU9Eh9zHK3iyO8pdPAfg?=
 =?us-ascii?Q?dsd5qSHbA+DV+t+pN0iGBu6BrorJuNf5MU9UfXyy09Lb95TNDRfYKNWa+otX?=
 =?us-ascii?Q?gxRl7nXJXIOK4AbWMNlSXQUFmpWGj06prnPOPnIS3G/o3+AHXvoRvrmx1Mnz?=
 =?us-ascii?Q?sSIrqIPvObiYkCSufnzuSaNyKQFJjLm7e9Bc6AkJnFldgfq/zBLIw53ScwUr?=
 =?us-ascii?Q?0xabvK6YBFlWcEBChztYaRAcOyn3jbIj0MrmCGs+dfRz1DZ7EmEQ1uwgdNUH?=
 =?us-ascii?Q?gXsZbP+HPjjrBNA25NenkoEWyme3VELLE3j89AbOJV+WMWWdIzIPQTnGDrs9?=
 =?us-ascii?Q?obfu7rdUNhdN62cBZg3UgCd3wQu+tv3Vn1vBk5DJ8x5QDpGNtoxE++DeCKDZ?=
 =?us-ascii?Q?LVgYvt+tk+ZmTIcE1PeTx5LbByhGyWnxO9MvPqYe3OlI7S/wbRZEXLbcvZrY?=
 =?us-ascii?Q?Ud9M+zyWlh7+14iiMEvjFy4rkWmjwMZ80C2T/jgyzHi6edc7DSrFJg0NtRQ3?=
 =?us-ascii?Q?H0PhgvvxzTW3YsCZPe8IoJ6wBn/6/+Rxw+4CEzVkT1cVhmZNJkYOyahneHvK?=
 =?us-ascii?Q?Zu/8JOcVbWH0E0Yoj+g5URiD3vI5LPYj92CWdB1gNAGIvMBMsp6HXCTx0ZbP?=
 =?us-ascii?Q?ddS3g3hOe1YlRmdMAuQzumC0ImF2JCHOfKuqL+YRyGMBUBylwv+gQxp7MFL7?=
 =?us-ascii?Q?tbWEfHIMiAZjFn+OJEx2NxyWwv6HtHgNPUOszXpOy9RaLQxL4q5ActJxDXOT?=
 =?us-ascii?Q?2iZdrWrSLxxY/EJVY8tV2eNe1qTlRYwkPj+h72Q4kFk4mvI3SPxi6NeAbw/e?=
 =?us-ascii?Q?HgaKuS/CRkrS/Z4N/Fa9K/3I65H3WnZGANGKcoXplCPocwpnbv5BLLDmtrDn?=
 =?us-ascii?Q?xSWj7/nOzcEoFQdzagbQwSnKIT3BcJVykDqSipnsAkp/QMsb3kiM/59cFEEL?=
 =?us-ascii?Q?h2NwLMSAiOPFF0NnN0sGVhMcBehSR1jQQf7NhcsWl6L8LyXDlknP/fCBT38?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7e4a06-ae74-4a54-86db-08daeda5ac80
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 16:15:04.5681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mgVJUcspcFEoANFW3xb0iRsqIgxOemE2ms6FkzKv5bJ8uJ0FP0unSgEJbI0OfSlyxUQVs8B2xc0aGHlKSU4XJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_05,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=988 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030138
X-Proofpoint-GUID: ZzGk7an_mrEcKcaOD1IZMz6UUrKzHT96
X-Proofpoint-ORIG-GUID: ZzGk7an_mrEcKcaOD1IZMz6UUrKzHT96
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 7, 2022, at 3:43 AM, Richard Weinberger <richard@nod.at> wrote:
>=20
> This function is only used by NFSD to cross mount points.
> If a mount point is of type auto mount, follow_down() will
> not uncover it. Add LOOKUP_AUTOMOUNT to the lookup flags
> to have ->d_automount() called when NFSD walks down the
> mount tree.
>=20
> Signed-off-by: Richard Weinberger <richard@nod.at>

Hello Al, you are top of the maintainers listed for fs/namei.c.
I'd like to take this series for v6.3 via the nfsd tree. Can
I get your Acked-by: for this one?


> ---
> fs/namei.c            | 6 +++---
> fs/nfsd/vfs.c         | 6 +++++-
> include/linux/namei.h | 2 +-
> 3 files changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 578c2110df02..a6bb6863bf0c 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1458,11 +1458,11 @@ EXPORT_SYMBOL(follow_down_one);
>  * point, the filesystem owning that dentry may be queried as to whether =
the
>  * caller is permitted to proceed or not.
>  */
> -int follow_down(struct path *path)
> +int follow_down(struct path *path, unsigned int flags)
> {
> 	struct vfsmount *mnt =3D path->mnt;
> 	bool jumped;
> -	int ret =3D traverse_mounts(path, &jumped, NULL, 0);
> +	int ret =3D traverse_mounts(path, &jumped, NULL, flags);
>=20
> 	if (path->mnt !=3D mnt)
> 		mntput(mnt);
> @@ -2864,7 +2864,7 @@ int path_pts(struct path *path)
>=20
> 	path->dentry =3D child;
> 	dput(parent);
> -	follow_down(path);
> +	follow_down(path, 0);
> 	return 0;
> }
> #endif
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 157f0df0e93a..ced04fc2b947 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -63,9 +63,13 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry *=
*dpp,
> 	struct dentry *dentry =3D *dpp;
> 	struct path path =3D {.mnt =3D mntget(exp->ex_path.mnt),
> 			    .dentry =3D dget(dentry)};
> +	unsigned int follow_flags =3D 0;
> 	int err =3D 0;
>=20
> -	err =3D follow_down(&path);
> +	if (exp->ex_flags & NFSEXP_CROSSMOUNT)
> +		follow_flags =3D LOOKUP_AUTOMOUNT;
> +
> +	err =3D follow_down(&path, follow_flags);
> 	if (err < 0)
> 		goto out;
> 	if (path.mnt =3D=3D exp->ex_path.mnt && path.dentry =3D=3D dentry &&
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 00fee52df842..6f96db73a70a 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -77,7 +77,7 @@ struct dentry *lookup_one_positive_unlocked(struct user=
_namespace *mnt_userns,
> 					    struct dentry *base, int len);
>=20
> extern int follow_down_one(struct path *);
> -extern int follow_down(struct path *);
> +extern int follow_down(struct path *, unsigned int flags);
> extern int follow_up(struct path *);
>=20
> extern struct dentry *lock_rename(struct dentry *, struct dentry *);
> --=20
> 2.26.2
>=20

--
Chuck Lever



