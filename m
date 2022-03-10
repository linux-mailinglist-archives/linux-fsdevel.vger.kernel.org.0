Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830464D4256
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 09:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbiCJIUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 03:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240259AbiCJIUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:20:06 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009C1443DD;
        Thu, 10 Mar 2022 00:19:04 -0800 (PST)
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22A6oZE6021751;
        Thu, 10 Mar 2022 08:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=S1;
 bh=o88d0l1C/GST9ZkdRfhXDgEHwt6YCT8f4bS1TFJU+Q4=;
 b=NmmItyU8aRH1PVYOLVRqbCvH6PZcnZoUr4YhWL5xH+4f1ah0TrxWcOieRTKbASLM8FNV
 RSketHk2/wB4Ywb1xGLqNErUwSCtl1bJPdQqCjl1phXBdftTaZBfmWuUJJI0kpbRnlD/
 4janvHo2HZVmdaJPVLrL3W8axqQHDKxlS5PXs3dWD3iYhv9KIA7OJywdJEvbzIKIHlaI
 AJRYTzIARXh70SpvZ/J8cuRWmTiugPoiEkYWCMkwQ1jSOnJZUJTfCwkIxC2LYaWRiYbY
 bEddYjKNhtz1dAv7UmC8XFhGWGVi0/bmFkRmYjQatfXz3TXAFiVwei/AqxlPj2nOZ4/S zw== 
Received: from apc01-hk2-obe.outbound.protection.outlook.com (mail-hk2apc01lp2054.outbound.protection.outlook.com [104.47.124.54])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ekxgxcnst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 08:18:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkoIOkx76BwfegI9vTS3Tev03u3GmDCNDFlVylHRZjjBh+XALuuWqh15mAgU26MaO5IK2NpuKzmR0XjcUYVuJfnTHDxhMqdw1GHNwEuY5y3dJamiMp+Z2V+3U/oyY3DkEAD22GD9gisSn0J90kta8H46nQjhyVfL9lnOFxaYueveFD9OYjDHEVQlUr6kac9xMxS+4DBi+c5K01VR6bcFLsdjytT3KB+HF/+iBAp1c2Q33nIKW6PV7OHsRzPDv+/+U/bfcpXq6fWQVDKXAykgUzzgFZWNms2NBSaTOYz6ZTU4MFF2af8dY4tf5AXpvNiOP3TR3mqmFN7/UAASFWhsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o88d0l1C/GST9ZkdRfhXDgEHwt6YCT8f4bS1TFJU+Q4=;
 b=dGBbQ0qTcJi2x9gHcNlRTCtGNnGXrTtc60zEeLNr1yQrtjQzCMnl5G4caBfDGI3LexWnJDBCKWKOGl+5j5FA7e7mLrxWI6jZHWJZvaZHrSvASbBFnZZ3IIqfu/ajSbbzLmCAKWXHEx2u7lpU84KpgzfgZ+HMuGTpQuf9SVHLzT44Rofr18nclwsw3523BmaGstfDaWg/zVWsBj+nt2O+ZVGvAoWuXL9W391TRYlfmGWIBQ6sIo88xbY82b+JFRN7OP2/0ylm7ikwNGvdtO4ldhLCTbvZOHGTBjYMenlihc4gtl6CHspR11uF4AVgUfgcjE78VoTZi6JM4JZQ/9rlaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by SG2PR04MB2267.apcprd04.prod.outlook.com (2603:1096:4:c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Thu, 10 Mar 2022 08:18:34 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7420:b05b:beb9:38a8]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7420:b05b:beb9:38a8%6]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 08:18:34 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2] exfat: do not clear VolumeDirty in writeback
Thread-Topic: [PATCH v2] exfat: do not clear VolumeDirty in writeback
Thread-Index: Adg0Vskc+T+8E+65Sm+jIEZBsmb4mg==
Date:   Thu, 10 Mar 2022 08:18:34 +0000
Message-ID: <HK2PR04MB3891D1D0AFAD9CA98B67706B810B9@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 87d863c1-a82b-e0d6-e7c2-f43e385a686b
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36873832-a971-4909-300e-08da026e9232
x-ms-traffictypediagnostic: SG2PR04MB2267:EE_
x-microsoft-antispam-prvs: <SG2PR04MB2267D88CD9BEA886A5ED7F56810B9@SG2PR04MB2267.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xfjz3thTHc91wUeDTOsKcE1t1e8phXvuHqJRjD73iPx8OUzNB8R7Po29CT2Q2JxFh0qWsPail600DJKVcRmc+fFJrqwOoFWa/5+ETjYTnmvncNycjdhqgbxs8SFKMytlf2a8z1PM4eVQCG0nZe4EcWWglkiXcx3tTQnZ+shYtsPS9B4Gge0syHNHfz5t8OkAV+PNg0K7fW5OsfloBB8c76wWNZAdtr3E7wS0MRFXJ2VU1n1uC0GFQTk4Ie23S9Rq60Ukah/2jhqaRYi8DXUlh9r2FztV6KBkwIzS4t+hRwhv+LqAB+HeoYrZtPChPQSPdLOUoO4zQLGzk2uq3CWnvq+2kLhQhFW10gW4BK0Pj6y6AGMMSv4AbQwFh3OlSsG0t1l61et6+ruv3E5NvCs061fIzh0FuIJ7hbbhxl0oZPDcSJWQgzChmvk7Qs8SddlFT+xWueF9qRSUbBU9SFYgX/Yo7kFEYQ/tSIZWy3huDgi6x6/wdoJS1blUFtEFmDX1k251R5NxXB4K7IglpnGddeHDE2y5F6A/nYG2qV5PWGVeyyvxxBYzerZBBfqCv9ZuOlscvZmnfcA9X+ZrobS2aUe1ewbBEIjEGuxIe9i+nW49VPX7+mOS3WySoRtC/SlIq49sPHobv1mOqrhECQpOVfdKbAJzqJkSHQ3ypnxjSeiuN/3yQftgFl8uaFTTXeLCh/nBT63wdvx/EadLjbw0Vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(107886003)(66476007)(64756008)(66446008)(8676002)(9686003)(66556008)(110136005)(82960400001)(38100700002)(4326008)(5660300002)(76116006)(66946007)(52536014)(6506007)(2906002)(7696005)(33656002)(186003)(26005)(86362001)(508600001)(99936003)(54906003)(316002)(55016003)(122000001)(38070700005)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW4xMmpzMUNwZnEvREZqNVh0ZlkxclhGWGFnVGpURDNEUklZNzRtZGpMcmpo?=
 =?utf-8?B?bHZ3VUxUUUdBbTFPUGJ0VmVJMUkwdHhLaGVqMFVPVTB4TmxBM1VvTDcrVTlJ?=
 =?utf-8?B?a1FhNGxhL0l6U2ErN1E0QTBEaVdlWnNsRHFVenN4bnJ5bWNhT3c4d3hXZ2tB?=
 =?utf-8?B?NVl6K1pVTW0wWlkwZnI1M1NYay9KSnRaaUZackowRjcwQnh2RGFRZ3hSbmJ4?=
 =?utf-8?B?S2UxcjJEZ2RxN2dGbEJicEprckJFNFFUSDdkemhUT1htOXg0YU9NcXRoRys2?=
 =?utf-8?B?S2VrMFllemw0dlNxTTh0Y3prR1B0NjJ0N2orRVVMeWhzRjNiTnhPVlM0eTFv?=
 =?utf-8?B?Uk1CRHdCeWxGbzBkWUI5MXlUUDhPWXdFWW1xVCtyNXYyZGgxa090d1dRZGJP?=
 =?utf-8?B?eHlFa0cvd0E4MG9kNzVadWNQYU9iK08rTXQwb0NXSDlIRlROaU40T1VqK2Zn?=
 =?utf-8?B?aGdNYzlTVkxiRkV3bGR6d0lhZjUwbXZYVUw5SnpqTzBRdlArR2xUaUdtdVJo?=
 =?utf-8?B?cFNtcXI5YnhVa3hvNlY3TXlMWEVSOFlNblRwZkNXSnJYQ3RlbWdkNTRYMVJH?=
 =?utf-8?B?M091bW1EaG1iOFZscGpacldITmdFVjAxRjdwcTdvaitWZkN3NnlVd0liMy9n?=
 =?utf-8?B?V0RjMzJDZVBhUU9wRkwwQW9LYVFSSnVHNmQ0VCthYXJKeGNMSDZ2eElIQnFT?=
 =?utf-8?B?SnRSYlJtY0pQZXZ4eC9iSytUazNIaDFybXpKd3R6a1BMazBaajZPaGVyUzZu?=
 =?utf-8?B?czYrTll5VVhhSHd4TnV3YUtxZHZKUDNzemNIeE5BM0drUzBqTXB1MmpJb3Z3?=
 =?utf-8?B?dXdQaVphd1RoOVhHbXVPNDFVdU5zajl1LzMvdmFIVDhqRGNZRHBMZnovN216?=
 =?utf-8?B?RDFMemlqM0I1MjlzZnJpYWU0eGRPWUIrVm5rRUdycDRRbHhNdEk2SWFyS2to?=
 =?utf-8?B?b0c2akVUTkhCUTlJT2tCUUNBVFVyUEw0RjgwakVoSFF2cmlDVlFNeERBOTRZ?=
 =?utf-8?B?SzNnWVVqVlZlKytjdGlLYzlaSjhiWGZPbzZUN2hRTzFac2trZVg2NmZhaVBY?=
 =?utf-8?B?dkUvZ3BiNjlONUxvVko1Q2NuWkFmTU4ybnJGeEdOZXZzekFndWJWUG56SEdw?=
 =?utf-8?B?bWFtWVIvb1h3c2VLQWZaUzQ2dmxiRHJ6Vk96VDNGQitlZ1ZUMzVHT29jQ3Vu?=
 =?utf-8?B?d1FjWktrZ3I0L2U2cFdxSU1EOFdoc2taVWNCdGNUQnZETFZxVnltSEF6cnk0?=
 =?utf-8?B?eGJ0K0VMdTRPRnNuNURLSmFZRjJZY3B6UUdURVdCRlRIVlFSaWpudy9tTWhv?=
 =?utf-8?B?SFdKTnpMWGxhdGIzU1ppUjRRdS9rTWNkTm5NWEthVXQ3TWRIS09yajgxWWFB?=
 =?utf-8?B?Ti9FY0JBVDVxZ3JjZVloVUwwRmdpSUFYWlVpVEVUcEdQb1NUNGR1NzAzWENh?=
 =?utf-8?B?bE1IMDhPamVqUVpHaStjeER5NVpPUnZaaHNXZkNqbnJBMmhpbGR0d1NnMGFI?=
 =?utf-8?B?RHhtbllIWUovR2hQeXllRUxnc3dNQW16MFJmSDJlOFF0aWJ2bktiQjBqRjJk?=
 =?utf-8?B?L3dIaHlJMExmbTBKWExTRmsvN2tvYjhJOHl5VTFvQUU5MzVRRmpkdkhuZVB6?=
 =?utf-8?B?RHo0RmMxb2JGVTRxVVh6NXRoMjRMWjZydjRSN2NxSGdBV1h0Y0F0OTJDSFJH?=
 =?utf-8?B?T3ErSlFZTW80TWkvS2RzUmQrS295WTNReEpubnN6cFRxVmZyS3prZzB3ZTNZ?=
 =?utf-8?B?enorR2lGd2p4WERiRklVck8vN3BQSWpWNnpya3ZyL2p1eGMzZjJHTzVDVjZy?=
 =?utf-8?B?WTVqUFZBa2NQSTA2dkxxSnNMVXk1bVVBVzlZZWg4U3Z3SGh4cEg3a0VBYWdI?=
 =?utf-8?B?c3NTbThWMWl1YlNMS0lramhOV09aWHVjeU8rTDJ4NzBTNlA2ampDYTJDRlZN?=
 =?utf-8?B?VkFNbE9jMzdZNlNtQ2t0cHErakZOSmE4bVhGSWUzQlczamREN0ZPaFF2Ujk5?=
 =?utf-8?B?U201SHhTczZ4NURJN2VWRm42elVlYXJHUmkrQ2dOMlZhViszdEFxR2xJS3hW?=
 =?utf-8?B?SDMwRXkwRE1vdTN6V3BDaS9XYkZvMWkwemFjWkN0SEd6dWhFL0hpaGxYSnVY?=
 =?utf-8?B?bFRUN3FDWTZPdWdyTTNTOG1lNWpoaTkreVhqNWRncHhCTVlERjExMEZjK0Zj?=
 =?utf-8?Q?5Akaa/BPJeMjMMAnzf3k9UU=3D?=
Content-Type: multipart/mixed;
        boundary="_002_HK2PR04MB3891D1D0AFAD9CA98B67706B810B9HK2PR04MB3891apcp_"
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36873832-a971-4909-300e-08da026e9232
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 08:18:34.8298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SeWI+cFu2Xi2gVoBHdRoYjY6OMvnhG1ZwweJ+iB5tlGhkJCag5nTDnX0aNQvE77NBc1TtHRJ1abBxcwRyB++KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB2267
X-Proofpoint-ORIG-GUID: 714v8txXGxVOLMxEYW_tVmo5tOo-sEcw
X-Proofpoint-GUID: 714v8txXGxVOLMxEYW_tVmo5tOo-sEcw
X-Sony-Outbound-GUID: 714v8txXGxVOLMxEYW_tVmo5tOo-sEcw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_03,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100043
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_002_HK2PR04MB3891D1D0AFAD9CA98B67706B810B9HK2PR04MB3891apcp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QmVmb3JlIHRoaXMgY29tbWl0LCBWb2x1bWVEaXJ0eSB3aWxsIGJlIGNsZWFyZWQgZmlyc3QgaW4N
CndyaXRlYmFjayBpZiAnZGlyc3luYycgb3IgJ3N5bmMnIGlzIG5vdCBlbmFibGVkLiBJZiB0aGUg
cG93ZXINCmlzIHN1ZGRlbmx5IGN1dCBvZmYgYWZ0ZXIgY2xlYW5pbmcgVm9sdW1lRGlydHkgYnV0
IG90aGVyDQp1cGRhdGVzIGFyZSBub3Qgd3JpdHRlbiwgdGhlIGV4RkFUIGZpbGVzeXN0ZW0gd2ls
bCBub3QgYmUgYWJsZQ0KdG8gZGV0ZWN0IHRoZSBwb3dlciBmYWlsdXJlIGluIHRoZSBuZXh0IG1v
dW50Lg0KDQpBbmQgVm9sdW1lRGlydHkgd2lsbCBiZSBzZXQgYWdhaW4gYnV0IG5vdCBjbGVhcmVk
IHdoZW4gdXBkYXRpbmcNCnRoZSBwYXJlbnQgZGlyZWN0b3J5LiBJdCBtZWFucyB0aGF0IEJvb3RT
ZWN0b3Igd2lsbCBiZSB3cml0dGVuIGF0DQpsZWFzdCBvbmNlIGluIGVhY2ggd3JpdGUtYmFjaywg
d2hpY2ggd2lsbCBzaG9ydGVuIHRoZSBsaWZlIG9mIHRoZQ0KZGV2aWNlLg0KDQpSZXZpZXdlZC1i
eTogQW5keS5XdSA8QW5keS5XdUBzb255LmNvbT4NClJldmlld2VkLWJ5OiBBb3lhbWEsIFdhdGFy
dSA8d2F0YXJ1LmFveWFtYUBzb255LmNvbT4NClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nLk1vIDxZ
dWV6aGFuZy5Nb0Bzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2ZpbGUuYyAgfCAgMiAtLQ0KIGZz
L2V4ZmF0L25hbWVpLmMgfCAgNSAtLS0tLQ0KIGZzL2V4ZmF0L3N1cGVyLmMgfCAxMCArKy0tLS0t
LS0tDQogMyBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZmlsZS5jIGIvZnMvZXhmYXQvZmlsZS5jDQppbmRleCBk
ODkwZmQzNGJiMmQuLjJmNTEzMDA1OTIzNiAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2ZpbGUuYw0K
KysrIGIvZnMvZXhmYXQvZmlsZS5jDQpAQCAtMjE4LDggKzIxOCw2IEBAIGludCBfX2V4ZmF0X3Ry
dW5jYXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGxvZmZfdCBuZXdfc2l6ZSkNCiAJaWYgKGV4ZmF0
X2ZyZWVfY2x1c3Rlcihpbm9kZSwgJmNsdSkpDQogCQlyZXR1cm4gLUVJTzsNCiANCi0JZXhmYXRf
Y2xlYXJfdm9sdW1lX2RpcnR5KHNiKTsNCi0NCiAJcmV0dXJuIDA7DQogfQ0KIA0KZGlmZiAtLWdp
dCBhL2ZzL2V4ZmF0L25hbWVpLmMgYi9mcy9leGZhdC9uYW1laS5jDQppbmRleCBhZjRlYjM5Y2Mw
YzMuLjM5YzliZGQ2YjZhYSAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L25hbWVpLmMNCisrKyBiL2Zz
L2V4ZmF0L25hbWVpLmMNCkBAIC01NTQsNyArNTU0LDYgQEAgc3RhdGljIGludCBleGZhdF9jcmVh
dGUoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1Y3QgaW5vZGUgKmRpciwN
CiAJZXhmYXRfc2V0X3ZvbHVtZV9kaXJ0eShzYik7DQogCWVyciA9IGV4ZmF0X2FkZF9lbnRyeShk
aXIsIGRlbnRyeS0+ZF9uYW1lLm5hbWUsICZjZGlyLCBUWVBFX0ZJTEUsDQogCQkmaW5mbyk7DQot
CWV4ZmF0X2NsZWFyX3ZvbHVtZV9kaXJ0eShzYik7DQogCWlmIChlcnIpDQogCQlnb3RvIHVubG9j
azsNCiANCkBAIC04MTIsNyArODExLDYgQEAgc3RhdGljIGludCBleGZhdF91bmxpbmsoc3RydWN0
IGlub2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSkNCiANCiAJLyogVGhpcyBkb2Vzbid0
IG1vZGlmeSBlaSAqLw0KIAllaS0+ZGlyLmRpciA9IERJUl9ERUxFVEVEOw0KLQlleGZhdF9jbGVh
cl92b2x1bWVfZGlydHkoc2IpOw0KIA0KIAlpbm9kZV9pbmNfaXZlcnNpb24oZGlyKTsNCiAJZGly
LT5pX210aW1lID0gZGlyLT5pX2F0aW1lID0gY3VycmVudF90aW1lKGRpcik7DQpAQCAtODQ2LDcg
Kzg0NCw2IEBAIHN0YXRpYyBpbnQgZXhmYXRfbWtkaXIoc3RydWN0IHVzZXJfbmFtZXNwYWNlICpt
bnRfdXNlcm5zLCBzdHJ1Y3QgaW5vZGUgKmRpciwNCiAJZXhmYXRfc2V0X3ZvbHVtZV9kaXJ0eShz
Yik7DQogCWVyciA9IGV4ZmF0X2FkZF9lbnRyeShkaXIsIGRlbnRyeS0+ZF9uYW1lLm5hbWUsICZj
ZGlyLCBUWVBFX0RJUiwNCiAJCSZpbmZvKTsNCi0JZXhmYXRfY2xlYXJfdm9sdW1lX2RpcnR5KHNi
KTsNCiAJaWYgKGVycikNCiAJCWdvdG8gdW5sb2NrOw0KIA0KQEAgLTk3Niw3ICs5NzMsNiBAQCBz
dGF0aWMgaW50IGV4ZmF0X3JtZGlyKHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5ICpk
ZW50cnkpDQogCQlnb3RvIHVubG9jazsNCiAJfQ0KIAllaS0+ZGlyLmRpciA9IERJUl9ERUxFVEVE
Ow0KLQlleGZhdF9jbGVhcl92b2x1bWVfZGlydHkoc2IpOw0KIA0KIAlpbm9kZV9pbmNfaXZlcnNp
b24oZGlyKTsNCiAJZGlyLT5pX210aW1lID0gZGlyLT5pX2F0aW1lID0gY3VycmVudF90aW1lKGRp
cik7DQpAQCAtMTMxMSw3ICsxMzA3LDYgQEAgc3RhdGljIGludCBfX2V4ZmF0X3JlbmFtZShzdHJ1
Y3QgaW5vZGUgKm9sZF9wYXJlbnRfaW5vZGUsDQogCQkgKi8NCiAJCW5ld19laS0+ZGlyLmRpciA9
IERJUl9ERUxFVEVEOw0KIAl9DQotCWV4ZmF0X2NsZWFyX3ZvbHVtZV9kaXJ0eShzYik7DQogb3V0
Og0KIAlyZXR1cm4gcmV0Ow0KIH0NCmRpZmYgLS1naXQgYS9mcy9leGZhdC9zdXBlci5jIGIvZnMv
ZXhmYXQvc3VwZXIuYw0KaW5kZXggOGM5ZmI3ZGNlYzE2Li5jYjZiODdjMWQ2YjkgMTAwNjQ0DQot
LS0gYS9mcy9leGZhdC9zdXBlci5jDQorKysgYi9mcy9leGZhdC9zdXBlci5jDQpAQCAtMTAwLDcg
KzEwMCw2IEBAIHN0YXRpYyBpbnQgZXhmYXRfc2V0X3ZvbF9mbGFncyhzdHJ1Y3Qgc3VwZXJfYmxv
Y2sgKnNiLCB1bnNpZ25lZCBzaG9ydCBuZXdfZmxhZ3MpDQogew0KIAlzdHJ1Y3QgZXhmYXRfc2Jf
aW5mbyAqc2JpID0gRVhGQVRfU0Ioc2IpOw0KIAlzdHJ1Y3QgYm9vdF9zZWN0b3IgKnBfYm9vdCA9
IChzdHJ1Y3QgYm9vdF9zZWN0b3IgKilzYmktPmJvb3RfYmgtPmJfZGF0YTsNCi0JYm9vbCBzeW5j
Ow0KIA0KIAkvKiByZXRhaW4gcGVyc2lzdGVudC1mbGFncyAqLw0KIAluZXdfZmxhZ3MgfD0gc2Jp
LT52b2xfZmxhZ3NfcGVyc2lzdGVudDsNCkBAIC0xMTksMTYgKzExOCwxMSBAQCBzdGF0aWMgaW50
IGV4ZmF0X3NldF92b2xfZmxhZ3Moc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdW5zaWduZWQgc2hv
cnQgbmV3X2ZsYWdzKQ0KIA0KIAlwX2Jvb3QtPnZvbF9mbGFncyA9IGNwdV90b19sZTE2KG5ld19m
bGFncyk7DQogDQotCWlmICgobmV3X2ZsYWdzICYgVk9MVU1FX0RJUlRZKSAmJiAhYnVmZmVyX2Rp
cnR5KHNiaS0+Ym9vdF9iaCkpDQotCQlzeW5jID0gdHJ1ZTsNCi0JZWxzZQ0KLQkJc3luYyA9IGZh
bHNlOw0KLQ0KIAlzZXRfYnVmZmVyX3VwdG9kYXRlKHNiaS0+Ym9vdF9iaCk7DQogCW1hcmtfYnVm
ZmVyX2RpcnR5KHNiaS0+Ym9vdF9iaCk7DQogDQotCWlmIChzeW5jKQ0KLQkJc3luY19kaXJ0eV9i
dWZmZXIoc2JpLT5ib290X2JoKTsNCisJc3luY19kaXJ0eV9idWZmZXIoc2JpLT5ib290X2JoKTsN
CisNCiAJcmV0dXJuIDA7DQogfQ0K

--_002_HK2PR04MB3891D1D0AFAD9CA98B67706B810B9HK2PR04MB3891apcp_
Content-Type: application/octet-stream;
	name="v2-0001-exfat-do-not-clear-VolumeDirty-in-writeback.patch"
Content-Description: v2-0001-exfat-do-not-clear-VolumeDirty-in-writeback.patch
Content-Disposition: attachment;
	filename="v2-0001-exfat-do-not-clear-VolumeDirty-in-writeback.patch";
	size=3566; creation-date="Thu, 10 Mar 2022 08:16:47 GMT";
	modification-date="Thu, 10 Mar 2022 08:18:34 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhNjM2ODhlZDZiOTE0OWRiYmNlMjI0ODA4ZTkwMzY0NWM1ZmE3MmE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiWXVlemhhbmcuTW8iIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4K
RGF0ZTogVGh1LCAxMCBNYXIgMjAyMiAxNTowNDo0NyArMDgwMApTdWJqZWN0OiBbUEFUQ0ggdjJd
IGV4ZmF0OiBkbyBub3QgY2xlYXIgVm9sdW1lRGlydHkgaW4gd3JpdGViYWNrCgpCZWZvcmUgdGhp
cyBjb21taXQsIFZvbHVtZURpcnR5IHdpbGwgYmUgY2xlYXJlZCBmaXJzdCBpbgp3cml0ZWJhY2sg
aWYgJ2RpcnN5bmMnIG9yICdzeW5jJyBpcyBub3QgZW5hYmxlZC4gSWYgdGhlIHBvd2VyCmlzIHN1
ZGRlbmx5IGN1dCBvZmYgYWZ0ZXIgY2xlYW5pbmcgVm9sdW1lRGlydHkgYnV0IG90aGVyCnVwZGF0
ZXMgYXJlIG5vdCB3cml0dGVuLCB0aGUgZXhGQVQgZmlsZXN5c3RlbSB3aWxsIG5vdCBiZSBhYmxl
CnRvIGRldGVjdCB0aGUgcG93ZXIgZmFpbHVyZSBpbiB0aGUgbmV4dCBtb3VudC4KCkFuZCBWb2x1
bWVEaXJ0eSB3aWxsIGJlIHNldCBhZ2FpbiBidXQgbm90IGNsZWFyZWQgd2hlbiB1cGRhdGluZwp0
aGUgcGFyZW50IGRpcmVjdG9yeS4gSXQgbWVhbnMgdGhhdCBCb290U2VjdG9yIHdpbGwgYmUgd3Jp
dHRlbiBhdApsZWFzdCBvbmNlIGluIGVhY2ggd3JpdGUtYmFjaywgd2hpY2ggd2lsbCBzaG9ydGVu
IHRoZSBsaWZlIG9mIHRoZQpkZXZpY2UuCgpSZXZpZXdlZC1ieTogQW5keS5XdSA8QW5keS5XdUBz
b255LmNvbT4KUmV2aWV3ZWQtYnk6IEFveWFtYSwgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnku
Y29tPgpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZy5NbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+Ci0t
LQogZnMvZXhmYXQvZmlsZS5jICB8ICAyIC0tCiBmcy9leGZhdC9uYW1laS5jIHwgIDUgLS0tLS0K
IGZzL2V4ZmF0L3N1cGVyLmMgfCAxMCArKy0tLS0tLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZmlsZS5j
IGIvZnMvZXhmYXQvZmlsZS5jCmluZGV4IGQ4OTBmZDM0YmIyZC4uMmY1MTMwMDU5MjM2IDEwMDY0
NAotLS0gYS9mcy9leGZhdC9maWxlLmMKKysrIGIvZnMvZXhmYXQvZmlsZS5jCkBAIC0yMTgsOCAr
MjE4LDYgQEAgaW50IF9fZXhmYXRfdHJ1bmNhdGUoc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90
IG5ld19zaXplKQogCWlmIChleGZhdF9mcmVlX2NsdXN0ZXIoaW5vZGUsICZjbHUpKQogCQlyZXR1
cm4gLUVJTzsKIAotCWV4ZmF0X2NsZWFyX3ZvbHVtZV9kaXJ0eShzYik7Ci0KIAlyZXR1cm4gMDsK
IH0KIApkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvbmFtZWkuYyBiL2ZzL2V4ZmF0L25hbWVpLmMKaW5k
ZXggYWY0ZWIzOWNjMGMzLi4zOWM5YmRkNmI2YWEgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L25hbWVp
LmMKKysrIGIvZnMvZXhmYXQvbmFtZWkuYwpAQCAtNTU0LDcgKzU1NCw2IEBAIHN0YXRpYyBpbnQg
ZXhmYXRfY3JlYXRlKHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucywgc3RydWN0IGlu
b2RlICpkaXIsCiAJZXhmYXRfc2V0X3ZvbHVtZV9kaXJ0eShzYik7CiAJZXJyID0gZXhmYXRfYWRk
X2VudHJ5KGRpciwgZGVudHJ5LT5kX25hbWUubmFtZSwgJmNkaXIsIFRZUEVfRklMRSwKIAkJJmlu
Zm8pOwotCWV4ZmF0X2NsZWFyX3ZvbHVtZV9kaXJ0eShzYik7CiAJaWYgKGVycikKIAkJZ290byB1
bmxvY2s7CiAKQEAgLTgxMiw3ICs4MTEsNiBAQCBzdGF0aWMgaW50IGV4ZmF0X3VubGluayhzdHJ1
Y3QgaW5vZGUgKmRpciwgc3RydWN0IGRlbnRyeSAqZGVudHJ5KQogCiAJLyogVGhpcyBkb2Vzbid0
IG1vZGlmeSBlaSAqLwogCWVpLT5kaXIuZGlyID0gRElSX0RFTEVURUQ7Ci0JZXhmYXRfY2xlYXJf
dm9sdW1lX2RpcnR5KHNiKTsKIAogCWlub2RlX2luY19pdmVyc2lvbihkaXIpOwogCWRpci0+aV9t
dGltZSA9IGRpci0+aV9hdGltZSA9IGN1cnJlbnRfdGltZShkaXIpOwpAQCAtODQ2LDcgKzg0NCw2
IEBAIHN0YXRpYyBpbnQgZXhmYXRfbWtkaXIoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNl
cm5zLCBzdHJ1Y3QgaW5vZGUgKmRpciwKIAlleGZhdF9zZXRfdm9sdW1lX2RpcnR5KHNiKTsKIAll
cnIgPSBleGZhdF9hZGRfZW50cnkoZGlyLCBkZW50cnktPmRfbmFtZS5uYW1lLCAmY2RpciwgVFlQ
RV9ESVIsCiAJCSZpbmZvKTsKLQlleGZhdF9jbGVhcl92b2x1bWVfZGlydHkoc2IpOwogCWlmIChl
cnIpCiAJCWdvdG8gdW5sb2NrOwogCkBAIC05NzYsNyArOTczLDYgQEAgc3RhdGljIGludCBleGZh
dF9ybWRpcihzdHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0IGRlbnRyeSAqZGVudHJ5KQogCQlnb3Rv
IHVubG9jazsKIAl9CiAJZWktPmRpci5kaXIgPSBESVJfREVMRVRFRDsKLQlleGZhdF9jbGVhcl92
b2x1bWVfZGlydHkoc2IpOwogCiAJaW5vZGVfaW5jX2l2ZXJzaW9uKGRpcik7CiAJZGlyLT5pX210
aW1lID0gZGlyLT5pX2F0aW1lID0gY3VycmVudF90aW1lKGRpcik7CkBAIC0xMzExLDcgKzEzMDcs
NiBAQCBzdGF0aWMgaW50IF9fZXhmYXRfcmVuYW1lKHN0cnVjdCBpbm9kZSAqb2xkX3BhcmVudF9p
bm9kZSwKIAkJICovCiAJCW5ld19laS0+ZGlyLmRpciA9IERJUl9ERUxFVEVEOwogCX0KLQlleGZh
dF9jbGVhcl92b2x1bWVfZGlydHkoc2IpOwogb3V0OgogCXJldHVybiByZXQ7CiB9CmRpZmYgLS1n
aXQgYS9mcy9leGZhdC9zdXBlci5jIGIvZnMvZXhmYXQvc3VwZXIuYwppbmRleCA4YzlmYjdkY2Vj
MTYuLmNiNmI4N2MxZDZiOSAxMDA2NDQKLS0tIGEvZnMvZXhmYXQvc3VwZXIuYworKysgYi9mcy9l
eGZhdC9zdXBlci5jCkBAIC0xMDAsNyArMTAwLDYgQEAgc3RhdGljIGludCBleGZhdF9zZXRfdm9s
X2ZsYWdzKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHVuc2lnbmVkIHNob3J0IG5ld19mbGFncykK
IHsKIAlzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpID0gRVhGQVRfU0Ioc2IpOwogCXN0cnVjdCBi
b290X3NlY3RvciAqcF9ib290ID0gKHN0cnVjdCBib290X3NlY3RvciAqKXNiaS0+Ym9vdF9iaC0+
Yl9kYXRhOwotCWJvb2wgc3luYzsKIAogCS8qIHJldGFpbiBwZXJzaXN0ZW50LWZsYWdzICovCiAJ
bmV3X2ZsYWdzIHw9IHNiaS0+dm9sX2ZsYWdzX3BlcnNpc3RlbnQ7CkBAIC0xMTksMTYgKzExOCwx
MSBAQCBzdGF0aWMgaW50IGV4ZmF0X3NldF92b2xfZmxhZ3Moc3RydWN0IHN1cGVyX2Jsb2NrICpz
YiwgdW5zaWduZWQgc2hvcnQgbmV3X2ZsYWdzKQogCiAJcF9ib290LT52b2xfZmxhZ3MgPSBjcHVf
dG9fbGUxNihuZXdfZmxhZ3MpOwogCi0JaWYgKChuZXdfZmxhZ3MgJiBWT0xVTUVfRElSVFkpICYm
ICFidWZmZXJfZGlydHkoc2JpLT5ib290X2JoKSkKLQkJc3luYyA9IHRydWU7Ci0JZWxzZQotCQlz
eW5jID0gZmFsc2U7Ci0KIAlzZXRfYnVmZmVyX3VwdG9kYXRlKHNiaS0+Ym9vdF9iaCk7CiAJbWFy
a19idWZmZXJfZGlydHkoc2JpLT5ib290X2JoKTsKIAotCWlmIChzeW5jKQotCQlzeW5jX2RpcnR5
X2J1ZmZlcihzYmktPmJvb3RfYmgpOworCXN5bmNfZGlydHlfYnVmZmVyKHNiaS0+Ym9vdF9iaCk7
CisKIAlyZXR1cm4gMDsKIH0KIAotLSAKMi4yNS4xCgo=

--_002_HK2PR04MB3891D1D0AFAD9CA98B67706B810B9HK2PR04MB3891apcp_--
