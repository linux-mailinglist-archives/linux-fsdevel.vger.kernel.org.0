Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC1E37EF8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 01:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhELXNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 19:13:34 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33272 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442889AbhELWOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 18:14:23 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14CM06UR051555;
        Wed, 12 May 2021 22:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Mk8yeljsWbOqJs+Yf2pDMXIigG5E+jRx6/R1iLrSDXw=;
 b=YqzZsOhGUd7nTB8VgxdQdnxqXmpcbjQsJ0B9ishdoOptXBzWzfv8unAxE6E/fLMIQjd/
 1xywgf4LNUSfU0XSVm7DHMR//zU9yx4RM7D+HEOSOSAkJiWwTHdr68AQmqhAgvnLD7yI
 LVfxRydQI31dNgty7cVfqeHC+wmtrl3XEnOu5UMqpNcGxUaNiJ2ZIcjpmeCHnyXxpqNo
 BlCblmkl6/XkqK1agWX3PaUJT/O+HHrwWIM2bt+MoOsUnBNyD7IJadk1fmbNzlmOncnt
 3AgSjCKEKmRpnQvQVoQhx+6QtHTt7DDm/CoLzvsHnTbNumx/hr9ki6LokZ/zWCCVWH2s zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38gpneg43x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 22:13:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14CM04HE080675;
        Wed, 12 May 2021 22:13:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3020.oracle.com with ESMTP id 38gppfhdcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 22:13:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jR8fLFgCklJ7EELIl6sHGseAO+aVW5w4G6TCOy5RI45fIlP5A+Vdit+mVEbfc4LC415ZJ/QmxEHnt78ByFRiI4msJxYsEPHRGQtQnDATwizHemv4e8FKk/36Dp2jaw2m5Ehk7gRngSECktT8z1b4pfC0LitYbH4L8TINQCRtcbez2tiQLYhlykEfNOmk6StVe+/oxxNOwK5KIKaLJwQTiSp7SwhwhFU5ZLkXvTzihBdfUZ5V4e+HoLsegg+Edn6ageVuY3sHDiP64E13bsB5ooWIG12RemixBY3Ea9BmC/0cBUqu69iQYU0320Wyehah8QjI0r1ZD8M43KYKAXt0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk8yeljsWbOqJs+Yf2pDMXIigG5E+jRx6/R1iLrSDXw=;
 b=hUaOEkTzGDPnt5ygvJbKfIn8pHvLaJooulb0YvsiDjyOdXgy0+tFdTgR5GcPY7TD3zRk7duYH870sOHnKkh6ZWKiWIHzUr7MBgNmpD8V4wItY22LvFWUS0pT//ksTrIFlYfFoAxhfX3CIdEo4bk2zmH4hLNkN9GXJqq0DgagYN4jZ+h0Z7fvufWvmF9Hw47/jMR3m/cRATXENGSZdtxqqqtLazDC38vAUaY/LgMD7q9eogjfkkSbBvYRlpHs9K8fkfINq8l7TSZGo4ot+DTM37zg2ZEozrQou5mXbKGz78qBW4Br0R1F44ESWiDzvIqHYkAK/PoFj+EzbBSG91LXBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk8yeljsWbOqJs+Yf2pDMXIigG5E+jRx6/R1iLrSDXw=;
 b=QxKKD13JwHE/LHkYXvn7PjPLN8uRIGvCyEN7MmLvzgnJMjobYf6uvfjxN/lOeusV9nIztzs/fTqRO0h0aAeHOZwnT1S/mv6mVotDuUDnFQprMInrnTHE97qteEgLDueTkSyRXYTM4nlYyAPMAtgnoQb/FkYuF5QT3uIV9vuW9ig=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB2013.namprd10.prod.outlook.com (2603:10b6:300:10d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 22:13:01 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 22:13:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] radix tree test suite: Add __must_be_array() support
Thread-Topic: [PATCH 2/4] radix tree test suite: Add __must_be_array() support
Thread-Index: AQHXR190eoWyOuXiYUWELoogebyZ1argYcuAgAAHNgA=
Date:   Wed, 12 May 2021 22:13:00 +0000
Message-ID: <20210512221055.jovurbe3b7h7ipsq@revolver>
References: <20210512184850.3526677-1-Liam.Howlett@Oracle.com>
 <20210512184850.3526677-2-Liam.Howlett@Oracle.com>
 <YJxMt92cy/9zM7li@casper.infradead.org>
In-Reply-To: <YJxMt92cy/9zM7li@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b52cd31-fbbf-4403-9816-08d915931b40
x-ms-traffictypediagnostic: MWHPR10MB2013:
x-microsoft-antispam-prvs: <MWHPR10MB2013253AA350675D693A5586FD529@MWHPR10MB2013.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Virjr9OLQiYSJmECAv4nFynxx0USawkA9ugQK/YWkJM0ZcQqCiU0bXOKltLlxNo+Z0PuHmPPAeA1xfTCIBgCc21AvpznusntzARZ5idQFEdmgmAeAdFL2lUT0nuODklHagQ2/2qQb64Zq25xjozOJmatSLGIGc6O4I9DzX+j0EAAEaJvzOQUUKz6s7AAMucD5W3oz3G6kBSLYB9DLUeSWkMRsBTm3zgBfUB9OJdqrBlfGFFpu7Sl+lxWnw+6H+pd6tSlo82wvr/20gSP5Ph8BKVl3q2hKLJhuhQTYw8Ackjm+rq06DMtwdJiSvn/jeR+/jWl7Lxc3KalAMGusilP7qV1Poadpi7ptE69VgeMK2ZAtNOVVrPfcvrhWf0IJFhdvcRTowhiaBvfGaH7Kf0R/XWtXhXeLp4iYfLH5zVZxeYY3rJu2zVOFklbTL7FBtpn7x9AE1HoPqk7xv6oK7RCjVG1H9jabxUKwTGKBKilRpUTGGanv0AL6jJjbHg2CFtIP5Qx4sasiAaYytNVuC+RlzhYvw8vVPz4GtihPPauBhcfo4Y6TgFg+/W9o4Mwv52lQi2nlTYEN2ORqTl1FNk2YFYc6Zw/DGtUDC5HT0GEZNM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(136003)(396003)(366004)(346002)(39860400002)(5660300002)(186003)(6506007)(478600001)(44832011)(26005)(64756008)(66476007)(66446008)(9686003)(6512007)(122000001)(1076003)(6486002)(66556008)(4326008)(38100700002)(6916009)(8936002)(91956017)(54906003)(76116006)(2906002)(66946007)(316002)(33716001)(71200400001)(86362001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?m21zqj84+80neDDCaOXlUHn8D4pIBdHnAInfqpMuUHNWcXkKn400x6RwPFuc?=
 =?us-ascii?Q?Mk53ErZvvGQhNkLl9UjiXTZCDJWwqh2KiIK52oBfLbbZkDoHCIqhR3X/9yWS?=
 =?us-ascii?Q?z6j5qwYjNUVXhEQbv0F2GvX6y8+TowUF3fgbR0sO2FcE5FwPjUDH34Hi+G2b?=
 =?us-ascii?Q?vVXGioP7wh9RYFzmupIamtabZjNhwF0T4kArMHGFZhmG39y/2RDsXbuXT0YP?=
 =?us-ascii?Q?AwBq23Nl5jpunpfzdFb67BlO7+9yvk+Nfs1ArrVizJv77BosVgqyJkP+Fr0C?=
 =?us-ascii?Q?nMpEgNBlNtYKb5nsmuiJKymqMmZnX/FEgcQ9THAGR0QBDKqOochLK4bC7Am1?=
 =?us-ascii?Q?fuPjbF/K3VoyNf7ipcz5gmkfGigFrFctGDjthAgmwnKpb30I0Bn9AC/3axDK?=
 =?us-ascii?Q?QoIRhD8oSZytc68B0P6FsTob2ekO+11ETi1OeBlgytQmpX9qrtPPL23nwgaG?=
 =?us-ascii?Q?HFtUBgFDUF5KFxAAZk4WAfCMrgX9F1U/KYDWO9RGco5e/6VwcItSNu3PVt5x?=
 =?us-ascii?Q?VyFKih49+d68G5h33NgnBnWvYFpTHrICau933HEAuG5Es4QirsLK9VfYQW8e?=
 =?us-ascii?Q?quaSUdxpG9/Y3Dq7ORxa8AVAhROLp17UntBcKZfSJGtxCI7g0wc8/tbdv0XH?=
 =?us-ascii?Q?be4e05dl8X8u0c/wvknn2Vtt5QQwKgjeVQ92wpXTUOYVWwXaGaeOuveFsmRa?=
 =?us-ascii?Q?fhZZ4UCfdYNrWyZU4dKsqEFKFt5pxBisiNGquqPvos4moULVywIaDiB4TzLU?=
 =?us-ascii?Q?02tyWXo5gydyZRuVU/qJIUo+sKnTkbpU7YNa8j54p84DFr8UDUm6Vncqv15P?=
 =?us-ascii?Q?tgCaWCJVC302Z4oTGI7RvZCba2558FtEGNd041UktvMDG4gKUDyHSihEPdHe?=
 =?us-ascii?Q?kV2u9v+Y35UU1MVsOBxO9STRfZA/ry/iMDCvNlK1L9I6kYCX3SFyyJcHSW6K?=
 =?us-ascii?Q?wW5YUBuOqVJd4cwXmN3YSQQyVzuzw9ezJ9jmFGjrGxd89RDDZHNvylv3ck/b?=
 =?us-ascii?Q?O9hxjSr5EG3jANwKlogEXyHuz+grHn0sKGLw4yhZZHqq3T+LKFzUNUkFoBAt?=
 =?us-ascii?Q?+dDUOuwVEAHDqXWIN6cdOYkqHv8HFEX1qsFjNsZGsqjKPfGEuepBYHuOswLG?=
 =?us-ascii?Q?Hc8ZlIwErmIW6GFlp97A6BSXtBgSLRCFLHmXiO+hR5GEpq8/CjWP9Qn+YQ6Q?=
 =?us-ascii?Q?m5z8vlsuGCS99qkyA9Co1sqX74qalQVZsn/O32APPUse2nrXEP6QgZu+x4iU?=
 =?us-ascii?Q?WPvkchgjPGRg4v2rJMJYqyLRxWx87fFR3SD1AFTkBPGq6QxFYpsrxKo0RndF?=
 =?us-ascii?Q?i3tnYRXQxptlk/G46hI5jEJi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3CFF4EDB2DACB648B0539BF73139D211@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b52cd31-fbbf-4403-9816-08d915931b40
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 22:13:01.0340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 029cStd3dULrKv0JhtgIBieAScLWepqFOSaW9r3ps2dzYKOknDAwakoxkhmEWa4czy20g8lvWV0JHYMxNBXTOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2013
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105120142
X-Proofpoint-GUID: _lG-vxPvkmzTFcLyAvle1i7LYc14owdC
X-Proofpoint-ORIG-GUID: _lG-vxPvkmzTFcLyAvle1i7LYc14owdC
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105120142
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Matthew Wilcox <willy@infradead.org> [210512 17:48]:
> On Wed, May 12, 2021 at 06:48:52PM +0000, Liam Howlett wrote:
> > Copy __must_be_array() define from include/linux/compiler.h for use in
> > the radix tree test suite userspace compiles.
>=20
> We needed this earlier, but see commit
> 7487de534dcbe143e6f41da751dd3ffcf93b00ee
>=20
> I bet if you revert this commit, it'll still build fine.
>=20
> Also, I bet patch 1/4 is the same -- I see a definition of
> fallthrough in tools/include/linux/compiler-gcc.h

You are correct.  Please disregard patch 1 and 2.

Thanks,
Liam

>=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  tools/testing/radix-tree/linux/kernel.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/ra=
dix-tree/linux/kernel.h
> > index c400a27e544a..2c3771fff2c0 100644
> > --- a/tools/testing/radix-tree/linux/kernel.h
> > +++ b/tools/testing/radix-tree/linux/kernel.h
> > @@ -30,4 +30,6 @@
> >  # define fallthrough                    do {} while (0)  /* fallthroug=
h */
> >  #endif /* __has_attribute */
> > =20
> > +#define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0])=
)
> > +
> >  #endif /* _KERNEL_H */
> > --=20
> > 2.30.2=
