Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82C44177C98
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 18:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgCCQ7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 11:59:30 -0500
Received: from mx0a-00003501.pphosted.com ([67.231.144.15]:40894 "EHLO
        mx0a-00003501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727077AbgCCQ73 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:59:29 -0500
X-Greylist: delayed 1140 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2020 11:59:29 EST
Received: from pps.filterd (m0075550.ppops.net [127.0.0.1])
        by mx0a-00003501.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 023GLNDD042333;
        Tue, 3 Mar 2020 11:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=BWRxjEjEztcWfLIaudrwi3VvQ8tjftJn+2Vk1fd3XiA=;
 b=eGhqyRJz26DvY3yblLJbkd7EBhz726dFW82syh2Yl8AMaN1K/438BRZolfkhH/8Tk0pl
 eITPAPRynw7xE8TX/hzH7XNUCyTVOjApP7H21fDDaAKUfzO5fa6hDxud/75hEjlm69Oi
 dsYU3pqslHu33IykyxBU+FydZsYBSI3g0yndUqBdI651ro8s935/SRU49LesyWzZhBDF
 EFGQ1HER+MPmN/sjPOrXUvDfduZPjuwCPDaT1+BujYdRudUNnPGIlJ/uRXw7fXhfWb7O
 R9jDFFwvkaR+uztzPTaiFW1pnyTsxeGQ9qNSerELTf4dqZ3fjxWAXdFrYRe+ORJEbxjG gw== 
Authentication-Results: seagate.com;
        dkim=pass header.d=seagate.com header.s=selector1
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00003501.pphosted.com with ESMTP id 2yg64qqvv6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Mar 2020 11:40:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX4FWMY7toMlwZS6cDqNnKNUTW62OrMEqC4r8BWzpI0Aa9SoBL22yZVutPf72J/5QmXXRuHFsP0p82RQa6GqrPtolhNZNCj0ruJ8cToej6UikxPYNhXmQDR6ku//FLSdLak8OfQCYUwSZPrsAzg5C36/75X2gWxfD3qzREHikZfraEamcVdAFYP1WstIdPOlv0IavKui9fYr+BM0QyawFeRudrLi7zDIMjC+Y7h0t9ctV2GgcpSGHg8iW1cfNEIVxl7hEM8dXdPH+l2u94P97g4xJBlQzdlYgG4l1qG77XYs9zI8/xy+SDtIpsHVO7BVzUsDm+UIUPkhyYTgS/y3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWRxjEjEztcWfLIaudrwi3VvQ8tjftJn+2Vk1fd3XiA=;
 b=CR7avJnzHHgUd7c3+6Sy1be4qpjEcGZqbS0gEjxA2JpQugZXGo7H8LH62+Zm1rjZZBTZuvmCqQQ2fzgjVOFIOCQsKzo4pLYb0ZcytHLrQU9JDS67XGx783tyCZwC94mZHOQgFjjdKa6J/coCGebwvXDImTgeaMfKzGdw/SsSy/OiiZimP+Hz5+LdWSjzJYX60UQgOroX+mr5hN8rFk1od8hKc6ok3vVn92JvxBcFw90c8Dl2+SVGAy0i7UpJSF6XpxiDpc13xWUzb2ZU/Sn81kgIsk86Y0wUqHY3+9qOVw9ONP2ecwshbE+c4Wn1qdT6QLXZGJzReUJuAiSmDdc3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWRxjEjEztcWfLIaudrwi3VvQ8tjftJn+2Vk1fd3XiA=;
 b=ZCkJQEZiyMs7wgunSWEl9xLCoTbwr8UIeIrUY6WmlRfquseLQqGdT87z8vFzeHrJeIu0CNwdkSntC+FLMHzU8RGnEg1ZzFIjtGwEeAhMdLDIrzpLOoVMSUXqCuwO3azMzpOMIx/GGPim4zWg8D6zODltF9T9ePd/nkut1R7Yp28=
Received: from BN8PR20MB2563.namprd20.prod.outlook.com (2603:10b6:408:d2::30)
 by BN8PR20MB2690.namprd20.prod.outlook.com (2603:10b6:408:87::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Tue, 3 Mar
 2020 16:40:26 +0000
Received: from BN8PR20MB2563.namprd20.prod.outlook.com
 ([fe80::1574:1d51:1bf8:95c6]) by BN8PR20MB2563.namprd20.prod.outlook.com
 ([fe80::1574:1d51:1bf8:95c6%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 16:40:26 +0000
From:   Muhammad Ahmad <muhammad.ahmad@seagate.com>
To:     Tim Walker <tim.t.walker@seagate.com>,
        Dave Chinner <david@fromorbit.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Multi-actuator HDDs
Thread-Topic: [LSF/MM/BPF TOPIC] Multi-actuator HDDs
Thread-Index: AQHV5dmwqHfF02zsAkGfojnVYTf1s6g3J8Tk
Date:   Tue, 3 Mar 2020 16:40:26 +0000
Message-ID: <BN8PR20MB25637F379AA26DC89110A2B78EE40@BN8PR20MB2563.namprd20.prod.outlook.com>
References: <CAPNbX4RxaZLi9F=ShVb85GZo_nMFaMhMuqhK50d5CLaarVDCeg@mail.gmail.com>
 <20200210215222.GB10776@dread.disaster.area>,<CANo=J14NY9TG9RAUMfX2N-q2ZCqiD0CGGVWu-DTgKJDQK20CRg@mail.gmail.com>
In-Reply-To: <CANo=J14NY9TG9RAUMfX2N-q2ZCqiD0CGGVWu-DTgKJDQK20CRg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.204.222.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa0fe5a4-dd3f-4cd3-000f-08d7bf9193ca
x-ms-traffictypediagnostic: BN8PR20MB2690:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR20MB26905C79E41523717EFF37298EE40@BN8PR20MB2690.namprd20.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(2906002)(5660300002)(52536014)(33656002)(86362001)(26005)(8936002)(55016002)(9686003)(81166006)(64756008)(54906003)(66446008)(508600001)(81156014)(110136005)(8676002)(71200400001)(966005)(7696005)(76116006)(66946007)(53546011)(6506007)(66476007)(66556008)(44832011)(186003)(316002)(91956017)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR20MB2690;H:BN8PR20MB2563.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: seagate.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E3pIIpgOa2HUdwCj7zg4gO6ZPqfKlfyC/bYtA3dJUz/fLWxAglGlZHKCxywgLc1QyBNCSkxDnkzTeV9IjZVjN+ilA+oohU2qovRrIgf6OP6Roq7AFjnMW2mDjc/pfXKNie7uQi6rJzTWI5B/FKCK+k3hBK+iR/lIVkXPvy9sJywhfaXW0LAh5hWYScehNb1KfgTEmakZhXqh6GbdWcOfPeJxB/LVXaB4Vd8t7THGC2zUSNtKmM/+NEHzF11SUbTh5LgEgfr0m89A6Okj4FS5lO+dnvP2wiO2BN7Nd2Lm5sn7c9znua758IxCa0glS9jp0F4RT1Vvg36Vnxkse48MVVrGZGOJmH0AZCeYy0PlwCYxRSpYragmAJdyvkkxY63hFCXTkkxwVtVKmgeOtYxyNaz6bdDgYGMOjguQrpwn/adZW2oCooYJxXwwLgKfDR1qNH7UkUzH+5Fanx5IJzNVxw+Hm3lO25oRAp3esTbaKfrthlryq/uU3Mi0rUps3Sxv+xSIvU3phI3/J5LufHiKQQ==
x-ms-exchange-antispam-messagedata: GQf7cGwf3uBz45tg44m/HaW+G73iQ/lyl+M1ZPyMH4XOqGTGJeS0OCEbemVFRQhxfmCyTmIQEAsBrCdwAWlc0/TUO11e6AO0zvhT30nC12fHrjA7z4Ni8zIjunfn40x9uvEIqpTJWF0iFIjIhrrcuw==
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0fe5a4-dd3f-4cd3-000f-08d7bf9193ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 16:40:26.6247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jPjRnxB85be7slX23uBJl6lvv6NDwdQyxfA6BnjEKJgBbdzA/+zuA9UEo0U7cK6e5uNFDlfXSWO8eXXSqn1HpaFRE4djYneboZapvjDyfL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR20MB2690
X-Proofpoint-PolicyRoute: Outbound
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_05:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030115
X-Proofpoint-Spam-Policy: Default Domain Policy
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Are the topics for LSF/MM/BPF finalized? Trying to see if this topic made t=
he cut or not.=A0=0A=
=0A=
Regards,=0A=
-Muhammad=0A=
=0A=
=0A=
From: Timothy T. Walker <tim.t.walker@seagate.com>=0A=
=0A=
Sent: Tuesday, February 11, 2020 1:23 PM=0A=
=0A=
To: Dave Chinner <david@fromorbit.com>=0A=
=0A=
Cc: Muhammad Ahmad <muhammad.ahmad@seagate.com>; linux-fsdevel@vger.kernel.=
org <linux-fsdevel@vger.kernel.org>; linux-block@vger.kernel.org <linux-blo=
ck@vger.kernel.org>; linux-scsi <linux-scsi@vger.kernel.org>=0A=
=0A=
Subject: Re: [LSF/MM/BPF TOPIC] Multi-actuator HDDs=0A=
=0A=
=A0=0A=
=0A=
=0A=
On Mon, Feb 10, 2020 at 4:52 PM Dave Chinner <david@fromorbit.com> wrote:=
=0A=
=0A=
>=0A=
=0A=
> On Mon, Feb 10, 2020 at 12:01:13PM -0600, Muhammad Ahmad wrote:=0A=
=0A=
> > Background:=0A=
=0A=
> > As the capacity of HDDs increases so is the need to increase=0A=
=0A=
> > performance to efficiently utilize this increase in capacity. The=0A=
=0A=
> > current school of thought is to use Multi-Actuators to increase=0A=
=0A=
> > spinning disk performance. Seagate has already announced it=92s SAS=0A=
=0A=
> > Dual-Lun, Dual-Actuator device. [1]=0A=
=0A=
> >=0A=
=0A=
> > Discussion Proposal:=0A=
=0A=
> > What impacts multi-actuator HDDs has on the linux storage stack?=0A=
=0A=
> >=0A=
=0A=
> > A discussion on the pros & cons of accessing the actuators through a=0A=
=0A=
> > single combined LUN or multiple individual LUNs? In the single LUN=0A=
=0A=
> > scenario, how should the device communicate it=92s LBA to actuator=0A=
=0A=
> > mapping? In the case of multi-lun, how should we manage commands that=
=0A=
=0A=
> > affect both actuators?=0A=
=0A=
>=0A=
=0A=
> What ground does this cover that wasn't discussed a couple of years=0A=
=0A=
> ago at LSFMM?=0A=
=0A=
>=0A=
=0A=
> =0A=
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lwn.net_Articles_753=
652_&d=3DDwIDaQ&c=3DIGDlg0lD0b-nebmJJ0Kp8A&r=3DNW1X0yRHNNEluZ8sOGXBxCbQJZPW=
cIkPT0Uy3ynVsFU&m=3D2Eb6xxsYMqNOn4F3Yiola3ef2BTCKKg06zpnqJ_m1c8&s=3DJtxAw3Y=
13PHlYJygS847dBUVRXeM061Snm3hq01DFlY&e=3D=0A=
=0A=
>=0A=
=0A=
> Cheers,=0A=
=0A=
>=0A=
=0A=
> Dave.=0A=
=0A=
> --=0A=
=0A=
> Dave Chinner=0A=
=0A=
> david@fromorbit.com=0A=
=0A=
=0A=
=0A=
Hi all-=0A=
=0A=
=0A=
=0A=
The multi-actuator fundamentals remain the same from a couple of years=0A=
=0A=
ago. One development is to combine the actuators' address spaces into=0A=
=0A=
a single LUN. We'd like to show you a couple of system block diagrams,=0A=
=0A=
and talk about the queue management and command scheduling.=0A=
=0A=
=0A=
=0A=
Best regards,=0A=
=0A=
-Tim=0A=
=0A=
=0A=
=0A=
-- =0A=
=0A=
Tim Walker=0A=
=0A=
Product Design Systems Engineering, Seagate Technology=0A=
=0A=
(303) 775-3770=
