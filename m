Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 132C0139EBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 02:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgANBIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 20:08:02 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7380 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728896AbgANBIC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:08:02 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00E14VEF021553;
        Mon, 13 Jan 2020 17:07:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=D1PqrHOlGpzFfDeYHwi6mJL2t//V5O7g/Le4GXaFavw=;
 b=gpXpJHeHIT0VhH8AtbUBR+eB8nxGDhl4InI2GxqJ03momQKRwAFQb0DK5vn+/mIwJ+E6
 Ux6S2PpIMbjmXJcN7puYHmAm/SVp3KhYji6b/UAae2IVZrnlkQo14IPMDUEDyTGWYvNx
 i3UHMmUHvZka+GkkU18t0PYjZ2uuaDgM9WE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xfcyutud9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Jan 2020 17:07:39 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 13 Jan 2020 17:07:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaH8BBTlz/Qr5EKUVlpeZ1RxNOSki584jm8zBaxadVm7MJ3GIPhdq8V0Tdz/29c/v1dT+PJBXKS3gWykDF9b704o4yEo8xwSoJUUfiB4/O7Mcd79EKANC6pTn7iGT8pEflqaD+hwijz95i52XpOfxKQyYWv38FEqcfo17DlmugMkQHGkdUzfrqXBXxD0GvMsFM2efA9qnLzd3iQhV/Tz9NGccjXRpCwfMlE5Xu42NsYzDl0laR3UYVoUuBvYDlOOxh2BATsbAyuVk92da4GuscAMtRLtIa5UEyv3ddRvrG5CIYJ1jOvWRmNDPLj+FeQ2wUZxex5bQ37UZS/EgY1jLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1PqrHOlGpzFfDeYHwi6mJL2t//V5O7g/Le4GXaFavw=;
 b=FhhtlFGZbdm4MmJvZmuhG4AOf8cSnBPqf7QZFEAfrMuUtuqQgFQREj6ocUWZtC2hDhCUkaN40plawwRefG6cq5Pck3WKRwP7PIODepJULIBKdkn1CMzsSbvoQEl67pPog4ZcQJFSopouRW1rplTygbdFwP/hB+62NCygFfnwPBA7xnzzscxULvtgXkWJOABlXInNPQCWLX4uHj/R9Ly4fIeOP4G6/qAMZ4puDocGbEPCcNMe2/XqMXIcMRBWf0hbXDuU1ticpcKPDwZMljVCUxHdwvaSplDKir7B/jnv9d25YTKcIqqp6exhOtr+v1N95dHN2bDYQCDsbyIvf8nxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1PqrHOlGpzFfDeYHwi6mJL2t//V5O7g/Le4GXaFavw=;
 b=RoeEpJt8qGmAryR73k7vvZz3VoyUnzUAyNXrZefIv/YYjUjN3QSlJlzyv/1Q366Z+QvaXO33mCrSFCQTr3RarCG+z7NqhTQtbu/Yvhd+kiMxWVW9g+mUGusSZqxfs1ny4jZlrnceryZAVmGhIWA1miKcE2ZAF2+hKPRFVxtx3Zw=
Received: from SN6PR15MB2446.namprd15.prod.outlook.com (52.135.64.153) by
 SN6PR15MB2397.namprd15.prod.outlook.com (52.132.125.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 01:07:37 +0000
Received: from SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::615e:4236:ddfa:3d10]) by SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::615e:4236:ddfa:3d10%6]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 01:07:37 +0000
Received: from [172.30.120.61] (2620:10d:c091:480::1025) by MN2PR18CA0021.namprd18.prod.outlook.com (2603:10b6:208:23c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend Transport; Tue, 14 Jan 2020 01:07:36 +0000
From:   Chris Mason <clm@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [RFC 0/8] Replacing the readpages a_op
Thread-Topic: [RFC 0/8] Replacing the readpages a_op
Thread-Index: AQHVyieJJr3DU4NMDUiHtIM35/TqzKfozHmAgAAQNgCAAAXGAIAAQlOAgAAAsgCAAALTgIAAAQUAgAADiACAAAIAgIAAKS0AgAABqwA=
Date:   Tue, 14 Jan 2020 01:07:37 +0000
Message-ID: <510518B2-4E9F-4F84-B546-102B387334D6@fb.com>
References: <20200113153746.26654-1-willy@infradead.org>
 <6CA4CD96-0812-4261-8FF9-CD28AA2EC38A@fb.com>
 <20200113174008.GB332@bombadil.infradead.org>
 <15C84CC9-3196-441D-94DE-F3FD7AC364F0@fb.com>
 <20200113215811.GA18216@bombadil.infradead.org>
 <910af281-4e2b-3e5d-5533-b5ceafd59665@kernel.dk>
 <20200113221047.GB18216@bombadil.infradead.org>
 <1b94e6b6-29dc-2e90-d1ca-982accd3758c@kernel.dk>
 <20200113222704.GC18216@bombadil.infradead.org>
 <F1FD3E8B-AC7E-48AB-99CD-E5D8E71851EE@fb.com>
 <20200114010136.GA25922@bombadil.infradead.org>
In-Reply-To: <20200114010136.GA25922@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.13.1r5671)
x-clientproxiedby: MN2PR18CA0021.namprd18.prod.outlook.com
 (2603:10b6:208:23c::26) To SN6PR15MB2446.namprd15.prod.outlook.com
 (2603:10b6:805:22::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::1025]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcc0296e-6699-4283-7241-08d7988e252f
x-ms-traffictypediagnostic: SN6PR15MB2397:
x-microsoft-antispam-prvs: <SN6PR15MB2397420DDFAB015FFAB8E82BD3340@SN6PR15MB2397.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(396003)(366004)(376002)(189003)(199004)(81156014)(36756003)(2616005)(66446008)(316002)(64756008)(8676002)(66556008)(66476007)(6486002)(478600001)(2906002)(86362001)(66946007)(81166006)(54906003)(8936002)(33656002)(52116002)(6916009)(5660300002)(186003)(16526019)(53546011)(4326008)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2397;H:SN6PR15MB2446.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tLpdrnclHB36EfaaROEAnQZUsunBvbieG0MenfJORHKbDPK2lCMf9I658YrM4vJ/AyO5lnZmnPpSMwNp+Sr6QuB5DHsuh0I5jmepq4jrgmfj3Fbt0Jo7mXYrxTfzLtblNyuT8bLUo4c97396eY66d6ISNst+P2ZwHJCyKgY40+efOqJJ0Kd2kitjgqvzjVlzkSgh2tIxkJkEFU3O+lGHFXb7misx/EdeVirw5wyPV02mszCR8v3b5NklJHaKTtYCJN4CcmLGOveZ59eG0npxdNFxbeZ6QFYSYLNCaV3pht1nPmjkVHl35IYRZy0HOC3BFSPbLu3o9PM0j8JKtlL1tpqz7QYFO8XqhPGL2OK+Oy6fu8006ZSXNhy2qQKgeva3X0Z7EINBddJLbjs0nU2bUMzbz//+iqJdQqtdrW4W6s2gcpBWP8ZlYKIqaKl21O1S
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc0296e-6699-4283-7241-08d7988e252f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 01:07:37.4288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8G4/T7eGep7ek4qxeMsiJSXXTDAlAP4sUMHKFGBa7Gu4EUfd0py30tt+HPcXEmJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2397
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_08:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=594
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001140007
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13 Jan 2020, at 20:01, Matthew Wilcox wrote:

> On Mon, Jan 13, 2020 at 10:34:16PM +0000, Chris Mason wrote:
>>> I think what I want is a bio I can reach from current, somehow.  And
>>> the
>>> plug feels like a natural place to keep it because it's basically
>>> saying
>>> "I want to do lots of little IOs and have them combined".  The fact
>>> that
>>> the iomap code has a bio that it precombines fragments into suggests
>>> to
>>> me that the existing antifragmentation code in the plugging=20
>>> mechanism
>>> isn't good enough.  So let's make it better by storing a bio in the
>>> plug
>>> and then we can get rid of the bio in the iomap code.
>>
>> Both btrfs and xfs do this, we have a bio that we pass around and=20
>> build
>> and submit.  We both also do some gymnastics in writepages to avoid
>> waiting for the bios we've been building to finish while we're=20
>> building
>> them.
>>
>> I love the idea of the plug api having a way to hold that for us, but
>> sometimes we really are building the bios, and we don't want the plug=20
>> to
>> let it go if we happen to schedule.
>
> The plug wouldn't have to let the bio go.  I appreciate the plug does=20
> let
> requests go on context switch, but it wouldn't have to let the bio go.
> This bio is being stored on the stack, just as now, so it's still=20
> there.

Plugging is great because it's building up state for the block layer=20
across a wide variety of MM and FS code.

btrfs and xfs are building state for themselves across a tiny cross=20
section of their own code.  I'd rather not complicate magic state in=20
current in places we can easily pass the bio down.

-chris
