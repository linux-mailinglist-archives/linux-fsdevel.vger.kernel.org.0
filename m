Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06680567BEB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 04:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiGFCf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 22:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiGFCfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 22:35:16 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D353B19036;
        Tue,  5 Jul 2022 19:35:14 -0700 (PDT)
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2660vTjl006040;
        Wed, 6 Jul 2022 02:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=S1;
 bh=4iY+732/IzvDi4TF2xB99Sv3OTEHAzblTdM17pFppQ4=;
 b=lAx3lP96KsqrL5XnJ0k1vGbveZwPamHTkspzWstMkxGjifgqqny30AcIzol2Mzp6+Rb5
 eSmlWo5X+sUTUNYozEbR77HYcsf9vJY1IH9kjh5iK9Iz9dNqONyhCzsoFYUZQsitJCcB
 p8y/tTrfu+fVEuH/yoKeWZHacXoyBQJyHVY24bMD9f402IuKkhwGA5iP7bJUljJTG37J
 EE2t9rxa3Y6paeYtxwe1+WTaJLCqeH41QFWVX0hGGs9gbBPZfVTi2E5TVNQz2U3kfrwE
 YPLsGo4ijKaMrm7KdGCIH0M0QBWCW8ZVE+GMRtorEHoZEtlLw1hO5UjfRvU115Kfvyet jg== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3h4ub48b32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 02:35:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3l3gmH0b+pmpbhM55CMda6PqTZCsALf6p4ZoUW+zmVzEC4ycMhCm33VZZ3audxCtWA55iuIP6w3+aNAV6RkG0DRXlw8fXfTC3l5bc0eo828DvFlV88qq0JjyHEceQqxDX1p26kEd1+rlaKaaBxGuYiHnbyXexKI4iv5WacFmMFmoVIjSb1vR1cbs1fpH1wWNfV+HPSvEGf2ZcYb8YL3PV09RbXs7spTbulJx00UDtb5teyTxF0krlWBip00MU/KkfpUMLFHLGc7tOwXxCP9x+swMx1KoVAORbnoe/Ly1/pSmWzGWy5ZQqPilMCoP9OLgeC/idD671NTjWSYA8Xh6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iY+732/IzvDi4TF2xB99Sv3OTEHAzblTdM17pFppQ4=;
 b=SaRLTTe3N+zHYqFKtyASK0iF4DQvM/p5NUJSffbxiG1Q4pOn0KKfq7PaMHgnaCABB5vqpJCVOKScoEAnSSsa6WH478CuNGHlsWHoDgEcs2J6XtzCh3gKJ9mx6WIvXQVNFWJKDEBA/TY8xWfFLYVw8u/wSaC2p8bjV2LsrFY4Utzvn4vi/WjTkXa343YBQJ8Y7JfZ4wdNbgWzoQkLbNzUvOsB9WJ7wH2pYgt+qyq3k7Q3KD8a71+8oMOEe7sHpY9QNfsAwehxV/+EFX1mFIY9SlaCWYCZLDwmTdaJslfO+iNZGkiOsyRUG4lxvj/5kNdpa4XH4jB/4Qt1oluAT0CFGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from SG2PR04MB3899.apcprd04.prod.outlook.com (2603:1096:4:94::11) by
 PS1PR04MB2792.apcprd04.prod.outlook.com (2603:1096:803:44::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.19; Wed, 6 Jul 2022 02:34:55 +0000
Received: from SG2PR04MB3899.apcprd04.prod.outlook.com
 ([fe80::9076:c0a7:6016:599a]) by SG2PR04MB3899.apcprd04.prod.outlook.com
 ([fe80::9076:c0a7:6016:599a%6]) with mapi id 15.20.5395.017; Wed, 6 Jul 2022
 02:34:55 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 3/3] exfat: remove duplicate write inode for extending
 dir/file
Thread-Topic: [PATCH v1 3/3] exfat: remove duplicate write inode for extending
 dir/file
Thread-Index: AdiQ38Q7UTVVpY/QSjGfFgl0xxwZdA==
Date:   Wed, 6 Jul 2022 02:34:55 +0000
Message-ID: <SG2PR04MB38998CCCFA40E794F54B6C1A81809@SG2PR04MB3899.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 584b5cdd-4d16-4641-7b0f-08da5ef81cc7
x-ms-traffictypediagnostic: PS1PR04MB2792:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWcaBDrGmtqNn1ypLOtfq0pJUbzK+6KLPVysdEYNLyZOoj6nme+7abBg+ro0DyWJzh1VHOpV7OV9oJ3eeB+0oh96ISDfCf0ZBY+Vlihd/p20HjzJJCqmEWAMGjrxls8H3iyClZ1oLAQPuA+PDymWA8dV0CfGmzl6d+/kJPGs9+5NIBNkFysrVtqnY89h1BMfWFd7uJpgC8glWCUdn5V3UXs8v9fGUN/7Bhymf4wFBCVupFIHNe+gIpWEyGv3t4XUQzqAsE+QlK0BoLJS5Ot5QFDTSrcnSbace62DHliOw0yxD9d4eBSPqhj/8LCSmXozej3pEWsdXbuxfyh0M0G+H+H3ZsKs1IKFeznKG56cDXzt3NqHUHg8FMjHvw9hltx3DceRmljcpoNOnYrWI1Stmge090iQr30oLuVoYMOBwmBlyq1nD8Wewm4of/+4vqrWGSaswM0SlkMemGcNBZJtGJf6BXINjUNxNxa3oigUibtFgtiwLmuzr+0s4sDLApEOc5CPGEQw33a++0gFRVUVzAoghPK7/CtgJj98EWvQSMJHrEpWGqO/ahXfzNlye70v1mQS/uUCj6PcGHcyNXCrqXg8ZjeSI7z/H9RBlEvfRr1wK90UWYmatv0AgAqtSa+uU0ovAJeFS7UBn4CiQXof8tdvrmekQ7DXQRBF9hWdKzj0ilUj4Lce96S3Ucq3Y0STVUMG+7/8TvfDdXse/Tv7+o+c4Q4GJQSp5sO1WgDIjNTzk/9j5s+XyEClqJxo0oRlIjLrK9QP1nwis6gEF/hRGzF1Kas557VpR8ny3rHEkfMkOZUT6T3iTkTpzzaUW0P2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR04MB3899.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(478600001)(316002)(82960400001)(64756008)(99936003)(41300700001)(110136005)(54906003)(71200400001)(38070700005)(66556008)(4326008)(2906002)(76116006)(66446008)(107886003)(186003)(66946007)(83380400001)(66476007)(55016003)(122000001)(8676002)(38100700002)(7696005)(6506007)(9686003)(26005)(52536014)(33656002)(86362001)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cENabGFjNURQc2JBekVwdGNoYmFaVm1razZkUFZjdXQ2THlRNzlsRVNuRmlh?=
 =?utf-8?B?YlBMM2NMM1J5dm5Rcm5QZUJjZCtlRWppTWRqNjkxYnE3a0VzY0hHUFVlTy9m?=
 =?utf-8?B?UkNjcWFYWG5yR1NHUzl4NEFBbFRRQm1OYXp1cDRKbHMzNzl2UUtHT1RDRmxZ?=
 =?utf-8?B?MkpQdi9BRVl6OW5QUGhoSDVlck5SdFNkaU10a2NXSEd1ZnRNUm1ncGRNclJt?=
 =?utf-8?B?ZmlTck5lbkFvWWlPL3hDb29oVEFBSkdFWGhEUml1NUJTYXVEYlBoWjQ0L3BL?=
 =?utf-8?B?c1ZpTUs4ZEZjeU1WQXp0TlZ0d25hR3lGbzk3QWFLMnNGZnFLUUI3NlhRUlFu?=
 =?utf-8?B?RTVnVDVxT2JMMktqQWI2ZzBCSDRqelF6bHNNQ1RkUXAyQUFqTG1Pb2RMSVRr?=
 =?utf-8?B?cE9KSUNYWjFkOFN6WjhyYll5ckZvWnFhMjVwSndSYmZPMjlJUCtKV2ZVZldE?=
 =?utf-8?B?emxQTnZtdnFYaGZRaFBOZ0F3VlYvR1FQbjRVTVBMdm9EMVdMN2V5a0tDQjJV?=
 =?utf-8?B?Tm51ZVlWNGZUL2xFYTRNNlVnVkk2T0dCdlBkSE81SldwbVUwU3hUSVBoaWJi?=
 =?utf-8?B?TzZoSzNDcGY3NGxXZHZHVkRrTHZuZm9ad2JFNTk3b0poSnJXSU42Vm5CSERQ?=
 =?utf-8?B?Q2UzczhhSmhnVE5MSG0wT0ZabXhld3hUNTRiU29UVDN4dUVsRnM1T0N5TEcw?=
 =?utf-8?B?L28zSm1ha0ZObmttRisvbWZUblhPSldVaDJwbm1nNENuNEw0Q25MMGk2K2xR?=
 =?utf-8?B?cGVsWmdmU0ZuOVI0SjA5bVFEUjJLb0tTbDVnbkt0UkVkNzFON2RDdjU1N2Z5?=
 =?utf-8?B?YUVadHdZME1KeExNQmM4MXBNdkpSelRPcFdLTmFUWDN3aWxrL1hJK2RaNWFm?=
 =?utf-8?B?UDdlR3dBUDBnWlQzYnc3SUxQTHdLSTFhOW1xUEpxN3pGYnE0UmxITzZJS2Nm?=
 =?utf-8?B?MGt1a1RZaGFRNWRmTmZwQ0xKR1A1aEJobTRrRlJvNnI4aSs4UkpUOHhnUmdv?=
 =?utf-8?B?Qmp3ZUdZRE1pVVFKRXRWV09HREI5TTBMb0dzQnNWRVh3aFNUbUZ5NEVqcTdM?=
 =?utf-8?B?VXY2T1ZpM0txcVZCdW1EbVlya1lDczBVbDhJR2diOU5QaTlLVHo1dklBRmlz?=
 =?utf-8?B?ZTJtZ1hyOHhoUXBRNFRtajEyamY4N0Z6YkRJbG5TUjlrVXg1Q0FXZTF6V2FH?=
 =?utf-8?B?cktsZFR0ME1pM3dCaUlzUzZ4TURBWERFd1lzTlZ3dlNaQ2h3akhaZVRDSHVz?=
 =?utf-8?B?UmNydHl1UWMxT3A2MWtldGtCMVBLUzg4d282d3Zkb0YwU0VkYzU5bkszS0hV?=
 =?utf-8?B?dmlKVWlIV1pMcUk0V1Evc09jMTRXWE9XS1k1eTBRREhVUStzeE81V3h1N012?=
 =?utf-8?B?MnovQVQ1K0MyL1pwT1dEM3dDZVlDb3Z6ZHlENnIrU2Fzbk5zZTlMMThQcnhs?=
 =?utf-8?B?OGpUYjJmSDUrOTBJODBMUktvdXFOdDdSM0k1MmdtclUxSURzNHpXcmhielky?=
 =?utf-8?B?dlFlYytNb3pyN0ZyZ0QxczF4U3phMXh3MW1tN0pnQW1HMGpCaUdNaWJOYkNY?=
 =?utf-8?B?YkxqbnJ1Yi9xUUVNODlUM2RrY2pYT3poUllzakQrWDUrTXR3OUc1RHdDS3Ju?=
 =?utf-8?B?Z3NlU21SUnY1ZFdWYldjeTU4TGRUVEZYbUxPNXhxUnBlcVVRWDQzSzd6MDhW?=
 =?utf-8?B?LzRvSkVFb0E5RFoxUXl3UEIwRGJqcHZRR1RaVG4ydGFTZDFGM1BwRUFCdEVI?=
 =?utf-8?B?a3l2aHZRN1U3amtwcjNURy9FSG9mRUF3QnpmU2NKMjh1akhRbDJKTTlXTTNx?=
 =?utf-8?B?WFliZVZwMEFqUisvT0tNRGZGRW5LL2pTVzVvL0licngxTDM1WTdPVzM5Zklj?=
 =?utf-8?B?aExFSE0rS1V5QVNxQ0xTb0tqdjJaV25JSUxkMjRaa2l4cVEvcTlVaTZKZU45?=
 =?utf-8?B?VUFIMCtQeExTT2ttRS9SWmlKTytZcGdDRHZpVktnVU16ZHcrZ0RNVWkvMkZw?=
 =?utf-8?B?Q3c1cnJTdzFwamgrS3hpU2NXR0VkZU54OVBFZThKM1c0ejRvR0R6dlJ2Z1hL?=
 =?utf-8?B?cVBVai9tdVlxRXZNZVl5V1JsazVmT21ydkJEMm5pZ0RQeHhPZXBIWWJYdzQ0?=
 =?utf-8?Q?WoM6ur249fYTms+ht4WcTereC?=
Content-Type: multipart/mixed;
        boundary="_002_SG2PR04MB38998CCCFA40E794F54B6C1A81809SG2PR04MB3899apcp_"
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR04MB3899.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584b5cdd-4d16-4641-7b0f-08da5ef81cc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 02:34:55.3769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 100kl9gxh19Ycne6A53/62SmJ3G1ycfjp/xwAmNgEtzsRWs4PO8g5AzUb5fkc4HBQGNwBO3tTvLwCzyxDi7EWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR04MB2792
X-Proofpoint-GUID: r3h8Mq4R8FkUE_PuotP0xpbMiwQ8nfWx
X-Proofpoint-ORIG-GUID: r3h8Mq4R8FkUE_PuotP0xpbMiwQ8nfWx
X-Sony-Outbound-GUID: r3h8Mq4R8FkUE_PuotP0xpbMiwQ8nfWx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_02,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_002_SG2PR04MB38998CCCFA40E794F54B6C1A81809SG2PR04MB3899apcp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

U2luY2UgdGhlIHRpbWVzdGFtcHMgbmVlZCB0byBiZSB1cGRhdGVkLCB0aGUgZGlyZWN0b3J5IGVu
dHJpZXMNCndpbGwgYmUgdXBkYXRlZCBieSBtYXJrX2lub2RlX2RpcnR5KCkgd2hldGhlciBvciBu
b3QgYSBuZXcNCmNsdXN0ZXIgaXMgYWxsb2NhdGVkIGZvciB0aGUgZmlsZSBvciBkaXJlY3Rvcnks
IHNvIHRoZXJlIGlzIG5vDQpuZWVkIHRvIHVzZSBfX2V4ZmF0X3dyaXRlX2lub2RlKCkgdG8gdXBk
YXRlIHRoZSBkaXJlY3RvcnkgZW50cmllcw0Kd2hlbiBhbGxvY2F0aW5nIGEgbmV3IGNsdXN0ZXIg
Zm9yIGEgZmlsZSBvciBkaXJlY3RvcnkuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZ
dWV6aGFuZy5Nb0Bzb255LmNvbT4NClJldmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNvbnku
Y29tPg0KUmV2aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+
DQpSZXZpZXdlZC1ieTogRGFuaWVsIFBhbG1lciA8ZGFuaWVsLnBhbG1lckBzb255LmNvbT4NCi0t
LQ0KIGZzL2V4ZmF0L2lub2RlLmMgfCA5ICstLS0tLS0tLQ0KIGZzL2V4ZmF0L25hbWVpLmMgfCA0
IC0tLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxMiBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2lub2RlLmMgYi9mcy9leGZhdC9pbm9kZS5jDQppbmRl
eCAzYWNmYmVjMWEwZDQuLmE3OTU0MzdiODZkMCAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2lub2Rl
LmMNCisrKyBiL2ZzL2V4ZmF0L2lub2RlLmMNCkBAIC0xMTIsNyArMTEyLDcgQEAgdm9pZCBleGZh
dF9zeW5jX2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQogc3RhdGljIGludCBleGZhdF9tYXBf
Y2x1c3RlcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCB1bnNpZ25lZCBpbnQgY2x1X29mZnNldCwNCiAJ
CXVuc2lnbmVkIGludCAqY2x1LCBpbnQgY3JlYXRlKQ0KIHsNCi0JaW50IHJldCwgbW9kaWZpZWQg
PSBmYWxzZTsNCisJaW50IHJldDsNCiAJdW5zaWduZWQgaW50IGxhc3RfY2x1Ow0KIAlzdHJ1Y3Qg
ZXhmYXRfY2hhaW4gbmV3X2NsdTsNCiAJc3RydWN0IHN1cGVyX2Jsb2NrICpzYiA9IGlub2RlLT5p
X3NiOw0KQEAgLTIwMyw3ICsyMDMsNiBAQCBzdGF0aWMgaW50IGV4ZmF0X21hcF9jbHVzdGVyKHN0
cnVjdCBpbm9kZSAqaW5vZGUsIHVuc2lnbmVkIGludCBjbHVfb2Zmc2V0LA0KIAkJCWlmIChuZXdf
Y2x1LmZsYWdzID09IEFMTE9DX0ZBVF9DSEFJTikNCiAJCQkJZWktPmZsYWdzID0gQUxMT0NfRkFU
X0NIQUlOOw0KIAkJCWVpLT5zdGFydF9jbHUgPSBuZXdfY2x1LmRpcjsNCi0JCQltb2RpZmllZCA9
IHRydWU7DQogCQl9IGVsc2Ugew0KIAkJCWlmIChuZXdfY2x1LmZsYWdzICE9IGVpLT5mbGFncykg
ew0KIAkJCQkvKiBuby1mYXQtY2hhaW4gYml0IGlzIGRpc2FibGVkLA0KQEAgLTIxMyw3ICsyMTIs
NiBAQCBzdGF0aWMgaW50IGV4ZmF0X21hcF9jbHVzdGVyKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHVu
c2lnbmVkIGludCBjbHVfb2Zmc2V0LA0KIAkJCQlleGZhdF9jaGFpbl9jb250X2NsdXN0ZXIoc2Is
IGVpLT5zdGFydF9jbHUsDQogCQkJCQludW1fY2x1c3RlcnMpOw0KIAkJCQllaS0+ZmxhZ3MgPSBB
TExPQ19GQVRfQ0hBSU47DQotCQkJCW1vZGlmaWVkID0gdHJ1ZTsNCiAJCQl9DQogCQkJaWYgKG5l
d19jbHUuZmxhZ3MgPT0gQUxMT0NfRkFUX0NIQUlOKQ0KIAkJCQlpZiAoZXhmYXRfZW50X3NldChz
YiwgbGFzdF9jbHUsIG5ld19jbHUuZGlyKSkNCkBAIC0yMjMsMTEgKzIyMSw2IEBAIHN0YXRpYyBp
bnQgZXhmYXRfbWFwX2NsdXN0ZXIoc3RydWN0IGlub2RlICppbm9kZSwgdW5zaWduZWQgaW50IGNs
dV9vZmZzZXQsDQogCQludW1fY2x1c3RlcnMgKz0gbnVtX3RvX2JlX2FsbG9jYXRlZDsNCiAJCSpj
bHUgPSBuZXdfY2x1LmRpcjsNCiANCi0JCWlmIChtb2RpZmllZCkgew0KLQkJCWlmIChfX2V4ZmF0
X3dyaXRlX2lub2RlKGlub2RlLCBpbm9kZV9uZWVkc19zeW5jKGlub2RlKSkpDQotCQkJCXJldHVy
biAtRUlPOw0KLQkJfQ0KLQ0KIAkJaW5vZGUtPmlfYmxvY2tzICs9DQogCQkJbnVtX3RvX2JlX2Fs
bG9jYXRlZCA8PCBzYmktPnNlY3RfcGVyX2NsdXNfYml0czsNCiANCmRpZmYgLS1naXQgYS9mcy9l
eGZhdC9uYW1laS5jIGIvZnMvZXhmYXQvbmFtZWkuYw0KaW5kZXggZjZmODcyNTgwM2RjLi42YmY5
YWJjNDUwOTAgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9uYW1laS5jDQorKysgYi9mcy9leGZhdC9u
YW1laS5jDQpAQCAtMzgyLDEwICszODIsNiBAQCBzdGF0aWMgaW50IGV4ZmF0X2ZpbmRfZW1wdHlf
ZW50cnkoc3RydWN0IGlub2RlICppbm9kZSwNCiAJCXBfZGlyLT5zaXplKys7DQogCQlzaXplID0g
RVhGQVRfQ0xVX1RPX0IocF9kaXItPnNpemUsIHNiaSk7DQogDQotCQkvKiB1cGRhdGUgdGhlIGRp
cmVjdG9yeSBlbnRyeSAqLw0KLQkJaWYgKF9fZXhmYXRfd3JpdGVfaW5vZGUoaW5vZGUsIElTX0RJ
UlNZTkMoaW5vZGUpKSkNCi0JCQlyZXR1cm4gLUVJTzsNCi0NCiAJCS8qIGRpcmVjdG9yeSBpbm9k
ZSBzaG91bGQgYmUgdXBkYXRlZCBpbiBoZXJlICovDQogCQlpX3NpemVfd3JpdGUoaW5vZGUsIHNp
emUpOw0KIAkJZWktPmlfc2l6ZV9vbmRpc2sgKz0gc2JpLT5jbHVzdGVyX3NpemU7DQotLSANCjIu
MjUuMQ0K

--_002_SG2PR04MB38998CCCFA40E794F54B6C1A81809SG2PR04MB3899apcp_
Content-Type: application/octet-stream;
	name="v1-0003-exfat-remove-duplicate-write-inode-for-extending-.patch"
Content-Description: 
 v1-0003-exfat-remove-duplicate-write-inode-for-extending-.patch
Content-Disposition: attachment;
	filename="v1-0003-exfat-remove-duplicate-write-inode-for-extending-.patch";
	size=2556; creation-date="Wed, 06 Jul 2022 02:27:07 GMT";
	modification-date="Wed, 06 Jul 2022 02:34:55 GMT"
Content-Transfer-Encoding: base64

U2luY2UgdGhlIHRpbWVzdGFtcHMgbmVlZCB0byBiZSB1cGRhdGVkLCB0aGUgZGlyZWN0b3J5IGVu
dHJpZXMKd2lsbCBiZSB1cGRhdGVkIGJ5IG1hcmtfaW5vZGVfZGlydHkoKSB3aGV0aGVyIG9yIG5v
dCBhIG5ldwpjbHVzdGVyIGlzIGFsbG9jYXRlZCBmb3IgdGhlIGZpbGUgb3IgZGlyZWN0b3J5LCBz
byB0aGVyZSBpcyBubwpuZWVkIHRvIHVzZSBfX2V4ZmF0X3dyaXRlX2lub2RlKCkgdG8gdXBkYXRl
IHRoZSBkaXJlY3RvcnkgZW50cmllcwp3aGVuIGFsbG9jYXRpbmcgYSBuZXcgY2x1c3RlciBmb3Ig
YSBmaWxlIG9yIGRpcmVjdG9yeS4KClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFu
Zy5Nb0Bzb255LmNvbT4KUmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFuZHkuV3VAc29ueS5jb20+ClJl
dmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPgpSZXZpZXdl
ZC1ieTogRGFuaWVsIFBhbG1lciA8ZGFuaWVsLnBhbG1lckBzb255LmNvbT4KLS0tCiBmcy9leGZh
dC9pbm9kZS5jIHwgOSArLS0tLS0tLS0KIGZzL2V4ZmF0L25hbWVpLmMgfCA0IC0tLS0KIDIgZmls
ZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2ZzL2V4ZmF0L2lub2RlLmMgYi9mcy9leGZhdC9pbm9kZS5jCmluZGV4IDNhY2ZiZWMxYTBkNC4u
YTc5NTQzN2I4NmQwIDEwMDY0NAotLS0gYS9mcy9leGZhdC9pbm9kZS5jCisrKyBiL2ZzL2V4ZmF0
L2lub2RlLmMKQEAgLTExMiw3ICsxMTIsNyBAQCB2b2lkIGV4ZmF0X3N5bmNfaW5vZGUoc3RydWN0
IGlub2RlICppbm9kZSkKIHN0YXRpYyBpbnQgZXhmYXRfbWFwX2NsdXN0ZXIoc3RydWN0IGlub2Rl
ICppbm9kZSwgdW5zaWduZWQgaW50IGNsdV9vZmZzZXQsCiAJCXVuc2lnbmVkIGludCAqY2x1LCBp
bnQgY3JlYXRlKQogewotCWludCByZXQsIG1vZGlmaWVkID0gZmFsc2U7CisJaW50IHJldDsKIAl1
bnNpZ25lZCBpbnQgbGFzdF9jbHU7CiAJc3RydWN0IGV4ZmF0X2NoYWluIG5ld19jbHU7CiAJc3Ry
dWN0IHN1cGVyX2Jsb2NrICpzYiA9IGlub2RlLT5pX3NiOwpAQCAtMjAzLDcgKzIwMyw2IEBAIHN0
YXRpYyBpbnQgZXhmYXRfbWFwX2NsdXN0ZXIoc3RydWN0IGlub2RlICppbm9kZSwgdW5zaWduZWQg
aW50IGNsdV9vZmZzZXQsCiAJCQlpZiAobmV3X2NsdS5mbGFncyA9PSBBTExPQ19GQVRfQ0hBSU4p
CiAJCQkJZWktPmZsYWdzID0gQUxMT0NfRkFUX0NIQUlOOwogCQkJZWktPnN0YXJ0X2NsdSA9IG5l
d19jbHUuZGlyOwotCQkJbW9kaWZpZWQgPSB0cnVlOwogCQl9IGVsc2UgewogCQkJaWYgKG5ld19j
bHUuZmxhZ3MgIT0gZWktPmZsYWdzKSB7CiAJCQkJLyogbm8tZmF0LWNoYWluIGJpdCBpcyBkaXNh
YmxlZCwKQEAgLTIxMyw3ICsyMTIsNiBAQCBzdGF0aWMgaW50IGV4ZmF0X21hcF9jbHVzdGVyKHN0
cnVjdCBpbm9kZSAqaW5vZGUsIHVuc2lnbmVkIGludCBjbHVfb2Zmc2V0LAogCQkJCWV4ZmF0X2No
YWluX2NvbnRfY2x1c3RlcihzYiwgZWktPnN0YXJ0X2NsdSwKIAkJCQkJbnVtX2NsdXN0ZXJzKTsK
IAkJCQllaS0+ZmxhZ3MgPSBBTExPQ19GQVRfQ0hBSU47Ci0JCQkJbW9kaWZpZWQgPSB0cnVlOwog
CQkJfQogCQkJaWYgKG5ld19jbHUuZmxhZ3MgPT0gQUxMT0NfRkFUX0NIQUlOKQogCQkJCWlmIChl
eGZhdF9lbnRfc2V0KHNiLCBsYXN0X2NsdSwgbmV3X2NsdS5kaXIpKQpAQCAtMjIzLDExICsyMjEs
NiBAQCBzdGF0aWMgaW50IGV4ZmF0X21hcF9jbHVzdGVyKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHVu
c2lnbmVkIGludCBjbHVfb2Zmc2V0LAogCQludW1fY2x1c3RlcnMgKz0gbnVtX3RvX2JlX2FsbG9j
YXRlZDsKIAkJKmNsdSA9IG5ld19jbHUuZGlyOwogCi0JCWlmIChtb2RpZmllZCkgewotCQkJaWYg
KF9fZXhmYXRfd3JpdGVfaW5vZGUoaW5vZGUsIGlub2RlX25lZWRzX3N5bmMoaW5vZGUpKSkKLQkJ
CQlyZXR1cm4gLUVJTzsKLQkJfQotCiAJCWlub2RlLT5pX2Jsb2NrcyArPQogCQkJbnVtX3RvX2Jl
X2FsbG9jYXRlZCA8PCBzYmktPnNlY3RfcGVyX2NsdXNfYml0czsKIApkaWZmIC0tZ2l0IGEvZnMv
ZXhmYXQvbmFtZWkuYyBiL2ZzL2V4ZmF0L25hbWVpLmMKaW5kZXggZjZmODcyNTgwM2RjLi42YmY5
YWJjNDUwOTAgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L25hbWVpLmMKKysrIGIvZnMvZXhmYXQvbmFt
ZWkuYwpAQCAtMzgyLDEwICszODIsNiBAQCBzdGF0aWMgaW50IGV4ZmF0X2ZpbmRfZW1wdHlfZW50
cnkoc3RydWN0IGlub2RlICppbm9kZSwKIAkJcF9kaXItPnNpemUrKzsKIAkJc2l6ZSA9IEVYRkFU
X0NMVV9UT19CKHBfZGlyLT5zaXplLCBzYmkpOwogCi0JCS8qIHVwZGF0ZSB0aGUgZGlyZWN0b3J5
IGVudHJ5ICovCi0JCWlmIChfX2V4ZmF0X3dyaXRlX2lub2RlKGlub2RlLCBJU19ESVJTWU5DKGlu
b2RlKSkpCi0JCQlyZXR1cm4gLUVJTzsKLQogCQkvKiBkaXJlY3RvcnkgaW5vZGUgc2hvdWxkIGJl
IHVwZGF0ZWQgaW4gaGVyZSAqLwogCQlpX3NpemVfd3JpdGUoaW5vZGUsIHNpemUpOwogCQllaS0+
aV9zaXplX29uZGlzayArPSBzYmktPmNsdXN0ZXJfc2l6ZTsKLS0gCjIuMjUuMQoK

--_002_SG2PR04MB38998CCCFA40E794F54B6C1A81809SG2PR04MB3899apcp_--
