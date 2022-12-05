Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A23064227C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Dec 2022 06:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiLEFKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 00:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiLEFKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:10:35 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF961007B;
        Sun,  4 Dec 2022 21:10:34 -0800 (PST)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B54ssoi014669;
        Mon, 5 Dec 2022 05:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=KYCcM1idfex/9lRd28q6AkXweqmzSou4GSyVK+Y3jbw=;
 b=IUXbxzsU8/r88J0yfIJLopqOpmCWBab6XClmMSc3J2lYBBr9xNbNWkPyYuimPsxB6TSf
 isqSalErxdRqfoDzKyqQV/FYcsOucmgMgJsWYMXTEQ8oQrtrMI8rHxJ0k/pjdnKifaF/
 QIFu8KaPC1L4XFcCseXzXeg9zzd1D0HFxa1CIYmTlqgvuIIA9zZDPeooYdTOeUCw8Cl1
 3wDP+xqj7LS8Tw2bHR2NxfKiIPGCp8ZmyLRVVC/mf1nkKfvBfAQdcSl4fVN5GJBwWzT8
 3D8ySIa09hPCl3lYkg3BPldnJqrkFMs9IelIZyLMlokKuz4ci4gZbNsbfVkyhUjlsvHT +g== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2044.outbound.protection.outlook.com [104.47.110.44])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3m7ycb1ahf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 05:10:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezgT5ui5cuGlLvYKveym/+XOAyrvskqO3DWbjlkSorbqX9gvYY3mQ7KipqEpLFtKkC+GnXP96S4XjmAbEOFoSpyqbPiSx5Szx4LXsUaIHleln3XStlgXw1qPgmC6sEiFAcZppdXkAzAwYooClcfD8ygtwr/K6U/v/wFC8SvI27Skyxwl90jEWW21W4yMCKftiAUAQ6P3739ClcvstOYB8cpBXAvVuKYDe4ZuZ87IP16AiKQaK3poYtJk6XwQkZOZf45RIjbdQJLflss1zSkJE5f/OXOq2KBHXsSOBJJlkzhhQ6L8xdOlNaHa4XvbbcsH2DO9AqQ0vJcwrxWb+uQpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYCcM1idfex/9lRd28q6AkXweqmzSou4GSyVK+Y3jbw=;
 b=Zae3TfqEDQb0mIdr4Uyi6ke/rVQ5fQyajpeSbVa9zmU12dGKSFRHv0PmAy7WyhXi3fcOu96V0T47rUyHa6ud1ctHCBJZ8+nEq8ICOKjOFBlm7Kh7we9QUq4SiGw3t6adg6wM10BzDmdq4uVOdGZR9aaBfIr1nqd6bYo0/+PKQ4syCrewrA4GBPiMaRAISZz0UDTu1am/jBCt9eHtjg9q4/44z3eGnkVoggEtPkDy85BEr1TIqTAzh1V5WUP/W69u+9GaVh4t9colmRXwvr8OU/q31JZMRrSzD3dQJVJJfPJMtJz51OA6yBstnvKr1OSnnA7PLtmDQZKxm0+elG935A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSBPR04MB3909.apcprd04.prod.outlook.com (2603:1096:301:2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 05:10:22 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de%6]) with mapi id 15.20.5880.008; Mon, 5 Dec 2022
 05:10:22 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 6/6] exfat: reuse exfat_find_location() to simplify
 exfat_get_dentry_set()
Thread-Topic: [PATCH v1 6/6] exfat: reuse exfat_find_location() to simplify
 exfat_get_dentry_set()
Thread-Index: AdkIZxYuFGc68+38TxOwJ6/NYKH6qw==
Date:   Mon, 5 Dec 2022 05:10:21 +0000
Message-ID: <PUZPR04MB631628014876FC50CD7EF2A781189@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSBPR04MB3909:EE_
x-ms-office365-filtering-correlation-id: eaed9b83-58d7-4664-e8d2-08dad67f02b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vnfb5eOlbQn+jlCA5xtiqKjtbyiXDZALBUvhSxxCENsb59/dP4rgmtNvfQK3GzpXk4Lo4Vv+hFTxmIBxreODEtu7IMShtaiLuZQI9vVOsiRbmFcIjkbkmRqoHW3XxHR9Psb//DY0EzJSNZ8ajH+meb82q4MxdGSVTvfqme8lv5RBFyi7b9IekfBCB7z37b1ExMM6mzs0zg3UB6sZCzWHUBb430P90n0sfrbS3WeMj6HXwvEx02aODRKKwhxegSSNDDdH9VA8YXlZihQX1ULT2ROxdbsMnC2i6bNEN77NXXM+23cY+fmLs8OC5RCDN9WN6c9pPmK2eO+JDGRxPvGJpdwCVPGsso2Vr4SOf6jYSAJz1oaFqgSMx8gYS5LBvAUvyU4h8Dp6HUO7K2Zeb0txYKzT0Fnj6+yKPhEM571dLQt5v5SU4yNEyDLJpNoppvoeWTUblokZbOmmi0ZBguTimGuK6qeMDw+CCMLyOJq8eelczxW3Yu5Xp7foceRnrG6PETcJ26YgCQ/XaJgHxalXRyrcR2e3qXswOSlJGuqVxdXOTxI/DhV5Oev0k0h2FGAh1RqQPK0i9mNUwKsP0V80dvZTL/+H/wzUVsHSMtbWWKb1VD78W7eX9L12vb9WuKwjGMgAfr8lq2jpzT0U6ODTQ8OOFq0tQz+uia0ct+Tgz0b76Sj6ds35nCDgaQqE/rg3QFjfAuALhu59ezEqHuw8gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(26005)(316002)(107886003)(478600001)(6506007)(7696005)(54906003)(110136005)(9686003)(71200400001)(76116006)(66556008)(66476007)(8676002)(66946007)(4326008)(64756008)(66446008)(8936002)(52536014)(5660300002)(186003)(83380400001)(41300700001)(2906002)(122000001)(38100700002)(82960400001)(38070700005)(55016003)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG02NC9SV2NVL0c4T04vME5RdlNGU3lyVjYxMnJ5Z0lxR0dzc0hxTE9NT3lN?=
 =?utf-8?B?Wkphbm9iZTNScE9yVFNXWmR3VjdYL2pwbHNGZllybXZ3TW1La2pQQzNaWG9B?=
 =?utf-8?B?ZEZzY2V3UDlxV2JSWFlJUSt3TGF2N3IydWN3Q0ZENko4Uk5qbWpNMkZRbWJr?=
 =?utf-8?B?OVJaUzdGaDZveWdKaGJVL2V0SDd3Wm1SMFZnT2hIU1Vna0NQemhiaHV4NitV?=
 =?utf-8?B?T2x2UlVRRVU2NTFFaDlVeUhQdk1sR2JOb2VUekF2TUJaUVhlSG85L0lCS0dG?=
 =?utf-8?B?UGhhZVUzbnNENWt4SGxsNFBZVWJjK0FFeU0vU0lKakVwK3FPcTk5Skk5Snk1?=
 =?utf-8?B?d0IrT3Z4YXRMRlVjclczbVlWNElmbG1kdXZreXRBdktBQ2p3TGMxZ21EY2xJ?=
 =?utf-8?B?TStjNjZjYmZKZXFlckg5cC9CREkzQVdwVVV1SXFtQ1hWRzF3UndBVFBFWWd2?=
 =?utf-8?B?RTRQdE9QcTRHN0xkZFhFRW4zY0R4dVFRZXBSMkhpUlExVDMrUDNBa3hpazdH?=
 =?utf-8?B?Y0hVK0FtQWlVR3EwUysrdTgreHhIWDlkTWVBdkpzV3ZEVjZ2WDFmN1RhbWpo?=
 =?utf-8?B?TENvUXRMMjN4NGRMWERueVNkdzU2VmU1K0N2RThkYk8rZ0FuUEx0Um5vbUIr?=
 =?utf-8?B?endKMHRrRnJEUUdBeDFBRGpjdkdUU1lSZGdVZHE4TFdieXIyVDc4Q0ozUC9s?=
 =?utf-8?B?by9PSXlITll6b0hFYUxybXQ1SFNmSnBDS0U4UFkwTXRJOHBDRi9zMEJIR0lK?=
 =?utf-8?B?U1ZpME9PSHRiS1ZlbW4zbVpFVDRaUFhSMnZocFhOL0Y3SFZzejBBeW5OZ1JY?=
 =?utf-8?B?aHUrZE9GcmlYQVRpMGU3cEJoaHd6REp3VEdoTmRSV3FpUkNGQkVJeEVzYjBo?=
 =?utf-8?B?dzdwVGNlNzUrNlRsb3ludDVrb1ZGSXRFSXJYYW9OUFJEa3ZJSG13Ymk0L1Za?=
 =?utf-8?B?S3JBeTRpbmRSbXlzSEFHWDg3ZnZIbi9IQXFNVWRQbzdIa052b2p6cXg0K1hM?=
 =?utf-8?B?Y09BOXNkeU1PbTN0OHcyU3RmSGc5aXZFaHpqYjhKdndGKytNOU9ybk5ZdkdL?=
 =?utf-8?B?WjFtV2RWdEp0RXZuN0dVVU9yOEdidkxvb3BnbXdGL2FwQ3IyQzhDY1ZuQjhn?=
 =?utf-8?B?dkhDcStoZHFmeEpQZmdUR1RyT2QyVFFna0d1V2JJOFhPQjYvOG1jb0pPb3Vr?=
 =?utf-8?B?akg2akhJaTB6UFk3Nm9qdlR4SUpLS05CMzhxaUJBZGhVOVJ2RENwN0IrZ0Zy?=
 =?utf-8?B?NldxUmtrTStLd2RSVi9zYkZjVEN5akZuN055UEVFUWV0TjkrVnlGeHJvejBC?=
 =?utf-8?B?djJsb24zN2JOWDJ2d2dHR1lydWFQTGQyNk5wd2Rxb0Q1UFZINWVGUm51bFlQ?=
 =?utf-8?B?K0JXSllqSENHOTBlcTRtVEttVElUaHIwMW52bnNDcEszVGFVK1h4bXpvUTNN?=
 =?utf-8?B?eEZiU1F2WjMzZWdiYUlTdnZLM2JtUFFzQWdzT2UrKytEMWEyeXB5Qi9nWHRm?=
 =?utf-8?B?UndIT1FRa3JmUXBtYmhEYVBmeTJpSEZud0tMLzkwd2lLUzJBMWNGOEEwTitX?=
 =?utf-8?B?Z2I5d0o2akRMWXZyQVYzWjBRMGQwY01UTnlUOUNxMG9HQmRKVk1SaklvZzI4?=
 =?utf-8?B?Y0xGRExjdlFjeDk1RTJYUTN4QTVJTXZFSjViaTBVMDRvZGhBbmQyNGNRUGl0?=
 =?utf-8?B?NStSTHp6TW05b2lXa3JwVkRTY2czTEU2UGJyV09IOUtyOGNodzRtdEViNmtZ?=
 =?utf-8?B?QW51RlZrMGdyYlVXSG9XNnBKWEVvRVIrSTBLU1oreHpJYjhLNlFvcjdXdFZT?=
 =?utf-8?B?VnFRSXBPUG5iVy9IMW1NM3dkT2p1SVF2TWtBZHlrM0Y0dkh3S25BL1B3c2F5?=
 =?utf-8?B?dXFnVi9ScWlwMnJTQzFZaU42c2lGbGRFdnZXQ3VrR3p0UkVDYUpSTWhHMVBS?=
 =?utf-8?B?Y2t4dlY0Tkc3NTNKQjFVSUgxeFRZaktHZEdNTkp1Szd5ckZ1WExuQnkvcGRV?=
 =?utf-8?B?ZHIzc3FvRlE0ZnY4YWhJaE8vVTZTdDhWa3ljbjV3cmZOVlE4LzNZVlQvRGtK?=
 =?utf-8?B?ekVMT0h5dGdNUjJ1YysyK1dTY2hWakluZDVJdXczMHE1SEduWHJ5M28wMi9F?=
 =?utf-8?Q?pT9/Das8uMA3al1AUx+zPrkM2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yd6H32pePViWfSjmdy+RAd6B7TnwkaBaW21HxOgJQ7Ux5OESwzQPliw0Rq5ZrCj9rd93vISSgV+c7I6yH6WxoCKpz9ns/oG6aBfvOzK57NBUsONxVmzWYh9jrqMKOoC2gRnqBw2mkN5QmXTtNHe463QV9O5xs7SE5n0MkUW8Z+a6SBVGlqPDgh5iteDd007FzoOnbgTtrw67SflnRQibYcQknX9sQyTub54t7O/Wg0FZHPQFAFn9MzG3jyIpEkyAfzMEw1LxCtWEJLZxdslkkBMFf9FtLTRJBy8tYwnhpMbyj78blp0YNO2gNuGJI9wnQO+3cXfNAmdHOQnP32/evF6bgPG8XCNF/ABIuinLShQvwi0Iii4I2coFxtvg2hqgX8KuYzREy4ZHy5VfJ3ntfUKXXPwiB0TblMSDmGRgzBxlmirut4Sl/esNQuA9vyoPCa7CiiRDFUkCY+SAJRtn3TgfFZ4fX+Q7ODaYvkuCiWa+A8GGKjkAFqtnTMYpqFXOK9nQ2hvNw1aev0G9M573FwvUFIQGvvAaNbjlxukybFyVgmiNtt5hEJe1iXazrHFF+J2QvfkcBffWPiowSxYvIfvQKq0+0NLOpaERWmlq0h6nue/vI0kGv5QIdaPKa2z2EWday+Il4qdC8UmXp2JbswJqCY74RHopczIxXYy44yXHpCa3Y54qWcxoFNgObhU8HFlnRHRsm/3ccq+vRaMTOwWAeT0U6a3nw63HSbpA6JejQ0VnNxah3YJrlBY/UuoiX2Ny/sCQOPrfKFaMearPJR7qjaijfAZqdAc+1LGGili3On0xxlFqy9VVewwckg71Z8529itfrP68L3dFoHgywsUql6AgJyPwSijQqd7FaijP+ZYDpFc/xH1FTcW7uosf
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaed9b83-58d7-4664-e8d2-08dad67f02b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 05:10:22.0478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oWNnLK+ZqrO6bTPk0TcmhS2A86v0LDaxPxjRGDYEg2WLLzc91XSpauNoITIHZnw0GdRsS/52KynuLpH3Lia+Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR04MB3909
X-Proofpoint-ORIG-GUID: COszx_92MyhTaBCaPQCIuB1Lbic_VTwb
X-Proofpoint-GUID: COszx_92MyhTaBCaPQCIuB1Lbic_VTwb
X-Sony-Outbound-GUID: COszx_92MyhTaBCaPQCIuB1Lbic_VTwb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SW4gZXhmYXRfZ2V0X2RlbnRyeV9zZXQoKSwgcGFydCBvZiB0aGUgY29kZSBpcyB0aGUgc2FtZSBh
cw0KZXhmYXRfZmluZF9sb2NhdGlvbigpLCByZXVzZSBleGZhdF9maW5kX2xvY2F0aW9uKCkgdG8g
c2ltcGxpZnkNCmV4ZmF0X2dldF9kZW50cnlfc2V0KCkuDQoNCkNvZGUgcmVmaW5lbWVudCwgbm8g
ZnVuY3Rpb25hbCBjaGFuZ2VzLg0KDQpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhh
bmcuTW9Ac29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW5keSBXdSA8QW5keS5XdUBzb255LmNvbT4N
ClJldmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPg0KLS0t
DQogZnMvZXhmYXQvZGlyLmMgfCAxNyArKysrLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvZXhm
YXQvZGlyLmMgYi9mcy9leGZhdC9kaXIuYw0KaW5kZXggODEyMWE3ZTA3M2JjLi44MzRjMGU2MzQy
NTAgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9kaXIuYw0KKysrIGIvZnMvZXhmYXQvZGlyLmMNCkBA
IC04MTgsNyArODE4LDcgQEAgaW50IGV4ZmF0X2dldF9kZW50cnlfc2V0KHN0cnVjdCBleGZhdF9l
bnRyeV9zZXRfY2FjaGUgKmVzLA0KIAkJdW5zaWduZWQgaW50IHR5cGUpDQogew0KIAlpbnQgcmV0
LCBpLCBudW1fYmg7DQotCXVuc2lnbmVkIGludCBvZmYsIGJ5dGVfb2Zmc2V0LCBjbHUgPSAwOw0K
Kwl1bnNpZ25lZCBpbnQgb2ZmOw0KIAlzZWN0b3JfdCBzZWM7DQogCXN0cnVjdCBleGZhdF9zYl9p
bmZvICpzYmkgPSBFWEZBVF9TQihzYik7DQogCXN0cnVjdCBleGZhdF9kZW50cnkgKmVwOw0KQEAg
LTgzMSwyNyArODMxLDE2IEBAIGludCBleGZhdF9nZXRfZGVudHJ5X3NldChzdHJ1Y3QgZXhmYXRf
ZW50cnlfc2V0X2NhY2hlICplcywNCiAJCXJldHVybiAtRUlPOw0KIAl9DQogDQotCWJ5dGVfb2Zm
c2V0ID0gRVhGQVRfREVOX1RPX0IoZW50cnkpOw0KLQlyZXQgPSBleGZhdF93YWxrX2ZhdF9jaGFp
bihzYiwgcF9kaXIsIGJ5dGVfb2Zmc2V0LCAmY2x1KTsNCisJcmV0ID0gZXhmYXRfZmluZF9sb2Nh
dGlvbihzYiwgcF9kaXIsIGVudHJ5LCAmc2VjLCAmb2ZmKTsNCiAJaWYgKHJldCkNCiAJCXJldHVy
biByZXQ7DQogDQogCW1lbXNldChlcywgMCwgc2l6ZW9mKCplcykpOw0KIAllcy0+c2IgPSBzYjsN
CiAJZXMtPm1vZGlmaWVkID0gZmFsc2U7DQotDQotCS8qIGJ5dGUgb2Zmc2V0IGluIGNsdXN0ZXIg
Ki8NCi0JYnl0ZV9vZmZzZXQgPSBFWEZBVF9DTFVfT0ZGU0VUKGJ5dGVfb2Zmc2V0LCBzYmkpOw0K
LQ0KLQkvKiBieXRlIG9mZnNldCBpbiBzZWN0b3IgKi8NCi0Jb2ZmID0gRVhGQVRfQkxLX09GRlNF
VChieXRlX29mZnNldCwgc2IpOw0KIAllcy0+c3RhcnRfb2ZmID0gb2ZmOw0KIAllcy0+YmggPSBl
cy0+X19iaDsNCiANCi0JLyogc2VjdG9yIG9mZnNldCBpbiBjbHVzdGVyICovDQotCXNlYyA9IEVY
RkFUX0JfVE9fQkxLKGJ5dGVfb2Zmc2V0LCBzYik7DQotCXNlYyArPSBleGZhdF9jbHVzdGVyX3Rv
X3NlY3RvcihzYmksIGNsdSk7DQotDQogCWJoID0gc2JfYnJlYWQoc2IsIHNlYyk7DQogCWlmICgh
YmgpDQogCQlyZXR1cm4gLUVJTzsNCkBAIC04NzgsNiArODY3LDggQEAgaW50IGV4ZmF0X2dldF9k
ZW50cnlfc2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzLA0KIAlmb3IgKGkgPSAx
OyBpIDwgbnVtX2JoOyBpKyspIHsNCiAJCS8qIGdldCB0aGUgbmV4dCBzZWN0b3IgKi8NCiAJCWlm
IChleGZhdF9pc19sYXN0X3NlY3Rvcl9pbl9jbHVzdGVyKHNiaSwgc2VjKSkgew0KKwkJCWludCBj
bHUgPSBleGZhdF9zZWN0b3JfdG9fY2x1c3RlcihzYmksIHNlYyk7DQorDQogCQkJaWYgKHBfZGly
LT5mbGFncyA9PSBBTExPQ19OT19GQVRfQ0hBSU4pDQogCQkJCWNsdSsrOw0KIAkJCWVsc2UgaWYg
KGV4ZmF0X2dldF9uZXh0X2NsdXN0ZXIoc2IsICZjbHUpKQ0KLS0gDQoyLjI1LjENCg==
