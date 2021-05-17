Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1452386DD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 01:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344551AbhEQXmU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 19:42:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8236 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235483AbhEQXmT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 19:42:19 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HNaDXc012097;
        Mon, 17 May 2021 16:40:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ZN6/VQWVG81IisUGUtzwWNpZgkqH0Rwsk9P919cLQ/0=;
 b=LAxNAbiHLRuXtg73baiGqqwxCMNS+cWCdUocrMyTy2GDgWvWHKxHwxO6GyQe8mYWodaE
 zim2umI9DAgGhCGEUBy4yK8fqJmeilxDsHrbUijxXRd2ysuuUa6mFr0wZm3CxzM+NmY+
 kJhM6vNN6Jpa7BV5YeC0i3bmvCGdPQKlokc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38jxcx0s7e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 17 May 2021 16:40:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 16:40:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpFZX/I35v8kRQe8e2u02XnJgdQ6eNI8EpvxxkjOkfolIdawfFlHVxengGEgM0L+krmzOjVvCguiR3Jp5EFOmC+CAp8/cSt7wV2K02/DVwlCc2Mzh4C2NSo1hNNYANg9Yn0dJESYrDP4Y8MneDJ6zxdVzhW7qwdEvHSEZbPmV+G38VVH8859EmRpXsDaMnxajoaai++kEt4a6B8d81xu41qAeWUTRUOaqrMsEkuOI0VauLVn9gB1vQljMWdmje6XE6/A7vk9axjP1UKirg7eh0OYxTGC+k99NH+qEyTccOSgojzAHd4SVXIbDb5bUZ1Mti9ZQ4g9lKtMRaACN0sryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZN6/VQWVG81IisUGUtzwWNpZgkqH0Rwsk9P919cLQ/0=;
 b=ds4ezRvShrDcXDHOn9RrpnQ4PM4dR/qcV7M+1DTQ1tIPcFxFpYdi5z+ynRHPTrVgPWzh/KsenfwXRAAPctTlNQ+LWH/K5IQ69OF0kO7C7NF1LtEK9q7OcRHgjWa0Yl6ScCWE8B34C9qtwE1G8nkx2llx56AJHxqEbzU33K+qF7GPaTYWdn948OKw97KNg/yrah1nH1PENCc+ibMBnPSSpXOkzJHCF8Xh5VyQNLauDKSpx852JMfO619DJoDjaTNvbFEFqcgBDTb5kTE/jSfpsXxzDzfkMfSDuzzlOj5ZHqOc/TqEEMVvRfGWFIdNCV8O81aNXDeu+lCH3QFFyev/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4359.namprd15.prod.outlook.com (2603:10b6:a03:358::15)
 by BYAPR15MB2486.namprd15.prod.outlook.com (2603:10b6:a02:84::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 23:40:51 +0000
Received: from SJ0PR15MB4359.namprd15.prod.outlook.com
 ([fe80::1836:351b:ea83:df75]) by SJ0PR15MB4359.namprd15.prod.outlook.com
 ([fe80::1836:351b:ea83:df75%7]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 23:40:51 +0000
From:   Chris Mason <clm@fb.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     David Howells <dhowells@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: How capacious and well-indexed are ext4, xfs and btrfs
 directories?
Thread-Topic: How capacious and well-indexed are ext4, xfs and btrfs
 directories?
Thread-Index: AQHXSy5S9wK3qRYDs0OeBucANXpnfaroUK+AgAAFFwA=
Date:   Mon, 17 May 2021 23:40:51 +0000
Message-ID: <9073312A-DB74-4ADF-8E12-6C04E15FE34C@fb.com>
References: <206078.1621264018@warthog.procyon.org.uk>
 <20210517232237.GE2893@dread.disaster.area>
In-Reply-To: <20210517232237.GE2893@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.80.0.2.43)
authentication-results: fromorbit.com; dkim=none (message not signed)
 header.d=none;fromorbit.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [172.101.208.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ca6cdfe-65e8-420e-d048-08d9198d3491
x-ms-traffictypediagnostic: BYAPR15MB2486:
x-microsoft-antispam-prvs: <BYAPR15MB248679AF3CC7A2BE2851AA16D32D9@BYAPR15MB2486.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2T4mg4ZIqfQLxMp//sUPA0EOnN59FL0Y4Z8rQ2jmOZd09zfvj37gTvBsCbNExEhf+PQYatpUQIbxSYyzfTxChISte54QxU8KtneMR41tExkC4a8O/dsWK+eXu/Wf9FEXegIt8mYTRvP2t2F/sSMOxM27xNdsJXN/Dkm/HHF1ZYZ8kjdQOacvV+2QLhIzXG/90K9e7ZFB1Ir4gRAwnwXXQoEOX8uK5UdvQPF+6VfbTZQ12eMkBQn8TDMGivLMhGxL7+kbiHOmkkmii94HKn3/43tOk6JqbbMYZuDmEpA/okwyZj7t6Q7ahbkFwGnxRCdeROPNfTeg/7V4XRbuEjSLbajCJtUy56AUgdyFR78cZVs16jlHPuwzYQZHz3fSRsjmpjS+5N14xzN6PzDbfULmjy7ulSJSWtZyXgVkTkTvm3nnZPGuSsG1SLdGhLjCTp+6Sagq7xaEgveE+G4YBEJit3JHkU1dTVhdaFx0oIfoyhKRrKSyvc11+RCep+CfHg7zZzVQEbdPmKhI3wdh+U+7w+g+VOSdyjZrw5RB7SbCjpci06Smtwkc42qsLJ7N6Hevxd16QqOOOUnx46J5Yk1ZRmpKtk6SDVpBrmRUATNW+9DK/4fektQyjlzk8pqOQIlTm+tFdrvacKeNVludUmR8ZeXpoqUpuCIKcv2BdqWDHFA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4359.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(2906002)(6486002)(26005)(54906003)(71200400001)(316002)(86362001)(36756003)(122000001)(478600001)(66556008)(8676002)(38100700002)(2616005)(8936002)(66476007)(83380400001)(64756008)(66446008)(6916009)(53546011)(6512007)(6506007)(76116006)(7416002)(91956017)(5660300002)(33656002)(4326008)(186003)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZjBVR0x3SzNYNk9rdXhFZDFLU0dmZDlqc0ltMi9mMGVMUTEwQnhRbkZYR0xT?=
 =?utf-8?B?UFpENzBnaEN4ZzdhUkJ5VnpDeEVEMkVmVzhLMGpkVlhScFBrcTNpeGczVkpD?=
 =?utf-8?B?cndWSU5adFZmSGVKL2FsdUFWMUdhbDBKYVJ3MG5oSkQ0dUVFSlRJMnNUbmVv?=
 =?utf-8?B?bUJ5Y0Yyd0NXd3FSd1JDTnZmQk9EU2NqaHN4OXBIVEN4YlpsNUtaNmpGWkdk?=
 =?utf-8?B?NVFadE83M2JsY0dJSVN5SFgxZ0tIS1loTUNYT2xERDZKWjJqMndKQUNlQ1Iy?=
 =?utf-8?B?bGNwcERIT1lzQlViQ3dPZHRpU1BaUXhBa1BudlpxcVdUY2h4eStFME4wdEty?=
 =?utf-8?B?VlBzZHZnbXFHZ21RMmpvRkpjYnFuTEpxK2dsemRRVDJ1NzMyMmdOOWtMK2sv?=
 =?utf-8?B?ZmJVV1IyR0ZqVk9VL3RaekVncGM3VURESDV6Vk9QTi8zRVpRWjFabmZ5bmVE?=
 =?utf-8?B?dWh1OTdSRFNET1NVSE1uMGRzcWFsN0orN2ZBVG9odE9vSFNsMHgrbzY1aGJJ?=
 =?utf-8?B?YitEN21LY2pTcGxjMmxvRjB0RkJqSFp0UFQzWDZZNGg4ZS9oZzl2aTZoWU9F?=
 =?utf-8?B?ZG1rR3NVc1BNWTMwN2VDV2YyMXJsMXNLdGxVaiswelBpZ0RFMlFOWGFVTWNT?=
 =?utf-8?B?S1U2THlKMlVRbER6enlPVmpob3FjYkpUaW1oTFFEVG1ITWd4eU1SR29UNXZt?=
 =?utf-8?B?VzFoSGZCdE01VXA3VytibGV5eVZaL3pEM1ptdHNkck55dlo1R2pyZkhvQU1V?=
 =?utf-8?B?UG40N1hNWnpuUndCWWpHa0thUXVqcEhCZVhqa0UzN1VqSnBZc2FkR3RaeExL?=
 =?utf-8?B?WDU1V1ErS25hQk1NME5Nb3JVUFpLYmRkOStZUnpwYjlKbk16NDNlWnJsSzd4?=
 =?utf-8?B?YU1naWhpK2pLUHQxWEkyek1WYlNCbW5tMUMxNnVjRFhPa2E2enhpcHlvZ3hN?=
 =?utf-8?B?Vk13UFduN1FZSERpdkxsWGlGQ2NQSVNRUU9YcERoUkNQNTdMTnkxVFo5ZXRw?=
 =?utf-8?B?V29IKzZYa3VpY1B3bFpDMzhLRVBTMmhZMjlFU2VIcmlMeGdzTkxFWXFnZnhn?=
 =?utf-8?B?azFVbk9HVllVelBVRUlKN25EUDVOMFhzZUdHdC84Um5qTlBKN2gwZmR4WFlq?=
 =?utf-8?B?SnJsWnZuNnFsV0wvbmtnR0xtOWo5T1pqdklEZmNKQ011MjRFQjROQW1CZThu?=
 =?utf-8?B?UVZCMXhNVWZ5bVNuaUhXY3RSL2g3ajJGVGdqd0NqOFc3c2hiSmsxK2dqaTFF?=
 =?utf-8?B?RldidkhuRlpMZXdsQTRhM0pINmg2eVJGSThFSVBKY3VpYmZDNmsrT0dkSjFr?=
 =?utf-8?B?REltMy9VNUN4bStVeFdTdWM3MHVOMGJ4aWRtQ0Z2OFk4S29rcXd3WGJLajhU?=
 =?utf-8?B?K3V2UU15aWNYa1VNK00yaTJCRVVVZ1VVLzlLbndmM0VyRkFLUjZxQzRtZVB1?=
 =?utf-8?B?c21SRDFoL3JUTXNMRlFpKzczZEh4VDhxN1cxVzNvbU9hckFVQUVBeit3alRt?=
 =?utf-8?B?cVVMSG9HUmlqSEh1RmFyTCtyUkFrMzF6M0JhVEdaTk5tU09STGN0WVpQczAx?=
 =?utf-8?B?SVhqbkpDV1A1YTA0TkhvZHZ3Y0lmZ2NocWE1ejVDNURkVjZpbG9BT2MvaUdT?=
 =?utf-8?B?QjhaYXA4MTVRRHFRUmF4QnVRcWwzTkx0cmkyYi9Sb1hoWlRqajdkemtvMCt4?=
 =?utf-8?B?Tjg4bTVFTFk3aWlOcExZUEcrYnJlTHJCZUxUam5senlZd3dZWjRWcEN6SHh1?=
 =?utf-8?B?Y214VGw1NVpYaTRqMUFSM0lTWDJlQkVrTEVEYkVkM2Z2c1k5WjdaK3Y4QTNW?=
 =?utf-8?B?dThPUEFEMEdkMU9Scm9vdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8A55C60E04A5D47B82BAC896DB71BCD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4359.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca6cdfe-65e8-420e-d048-08d9198d3491
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 23:40:51.2411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGY6XelFw5jxPxgiNFRLx7R5WJejHDKVU/cbg3E38CUeqgQy7OZJ9H+oMYa8B/mQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2486
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: DCZwvkab0Y-1OetI_FuNsJaIK3apepPZ
X-Proofpoint-ORIG-GUID: DCZwvkab0Y-1OetI_FuNsJaIK3apepPZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-17_10:2021-05-17,2021-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 clxscore=1011 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=465 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105170169
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIE1heSAxNywgMjAyMSwgYXQgNzoyMiBQTSwgRGF2ZSBDaGlubmVyIDxkYXZpZEBmcm9t
b3JiaXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgTWF5IDE3LCAyMDIxIGF0IDA0OjA2OjU4
UE0gKzAxMDAsIERhdmlkIEhvd2VsbHMgd3JvdGU6DQo+IA0KPj4gV2hhdCBJJ2QgbGlrZSB0byBk
byBpcyByZW1vdmUgdGhlIGZhbm91dCBkaXJlY3Rvcmllcywgc28gdGhhdCBmb3IgZWFjaCBsb2dp
Y2FsDQo+PiAidm9sdW1lIlsqXSBJIGhhdmUgYSBzaW5nbGUgZGlyZWN0b3J5IHdpdGggYWxsIHRo
ZSBmaWxlcyBpbiBpdC4gIEJ1dCB0aGF0DQo+PiBtZWFucyBzdGlja2luZyBtYXNzaXZlIGFtb3Vu
dHMgb2YgZW50cmllcyBpbnRvIGEgc2luZ2xlIGRpcmVjdG9yeSBhbmQgaG9waW5nDQo+PiBpdCAo
YSkgaXNuJ3QgdG9vIHNsb3cgYW5kIChiKSBkb2Vzbid0IGhpdCB0aGUgY2FwYWNpdHkgbGltaXQu
DQo+IA0KPiBOb3RlIHRoYXQgaWYgeW91IHVzZSBhIHNpbmdsZSBkaXJlY3RvcnksIHlvdSBhcmUg
ZWZmZWN0aXZlbHkgc2luZ2xlDQo+IHRocmVhZGluZyBtb2RpZmljYXRpb25zIHRvIHlvdXIgZmls
ZSBpbmRleC4gWW91IHN0aWxsIG5lZWQgdG8gdXNlDQo+IGZhbm91dCBkaXJlY3RvcmllcyBpZiB5
b3Ugd2FudCBjb25jdXJyZW5jeSBkdXJpbmcgbW9kaWZpY2F0aW9uIGZvcg0KPiB0aGUgY2FjaGVm
aWxlcyBpbmRleCwgYnV0IHRoYXQncyBhIGRpZmZlcmVudCBkZXNpZ24gY3JpdGVyaWENCj4gY29t
cGFyZWQgdG8gZGlyZWN0b3J5IGNhcGFjaXR5IGFuZCBtb2RpZmljYXRpb24vbG9va3VwIHNjYWxh
YmlsaXR5Lg0KDQpVbmxlc3MgeW914oCZcmUgZG9pbmcgb25lIHN1YnZvbCBwZXIgZmFuIGRpcmVj
dG9yeSwgdGhlIGJ0cmZzIHJlc3VsdHMgc2hvdWxkIGJlIHJlYWxseSBzaW1pbGFyIGVpdGhlciB3
YXkuICBJdOKAmXMgYWxsIGdldHRpbmcgaW5kZXhlZCBpbiB0aGUgc2FtZSBidHJlZSwgdGhlIGtl
eXMganVzdCBjaGFuZ2UgYmFzZWQgb24gdGhlIHBhcmVudCBkaXIuDQoNClRoZSBiaWdnZXN0IGRp
ZmZlcmVuY2Ugc2hvdWxkIGJlIHdoYXQgRGF2ZSBjYWxscyBvdXQgaGVyZSwgd2hlcmUgZGlyZWN0
b3J5IGxvY2tpbmcgYXQgdGhlIHZmcyBsZXZlbCBtaWdodCBiZSBhIGJvdHRsZW5lY2suDQoNCi1j
aHJpcw==
