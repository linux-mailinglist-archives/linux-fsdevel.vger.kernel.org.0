Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81546CFD86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 09:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjC3H7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 03:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjC3H7H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:59:07 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10hn2208.outbound.protection.outlook.com [52.100.155.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10C418F;
        Thu, 30 Mar 2023 00:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ES4FZ+f8YrrblWamVwGMNQ+l4TwnJS95d0EaqUnVASkp8SvrYiv6xiZ9OcYfF5L3fODfWESsl2IsnVs0Nnv8BlRWUVJQlRfrKOkUCdiA2TsbC+XHuPQ2Ug1YhNJqgg/n3+YE5CTRFQe6kA6ae7xJd14uPm0vZLAlomKBZVhQMK5QWoATDcrbqVotpUvuKeOR3lUsw/pzhMsXY4qsA2FsstOmZkjxAr8m22eN5Tfk8zUStDwNG3LUVOC8LgIvDXbBD0P6EAJnO3sWeYXy115HrbMxcou7ho5FBZjfOK4s3YfBJJa+8V6DimI/uvIT4Ka6YLZIejEMDFfTSkdIldH0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4LsvzOsnlj7xL/z34pqZ5k95dBpzOzNg24T2nzOzs0=;
 b=A96EduvljmvTBR+tA2LUCSj9j37YSyP08PCV21KIBqkiLkgYsIfCMlNoSRBTI7n7UjhgoyQ23Wz53ut/Z0PYy9ITy/NrqRsOZO3Wx691gxbxHmk0+kZ6xOg/k1uSgxuXQDD9UN1yrMS90MNm7G4NG+IT8a6QXgUlWIw0J71BcIO0Gg7AFFj9cOJzWMa4s2t/vqYxnfxlZZJe42/ZqkpGUd2I19cON66wkAfYjVZaa5TvTxR7L+5QXelPGgfGPtXFOTNmuQ21zAH2AVRf0rZYzNgYNG1mHFyQQnZP3IrzHSmHhZ4nH3BRSLWPGcPAOLa3xkMNxzFskSwsQzA/py0CNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 201.217.50.26) smtp.rcpttodomain=yahoo.com smtp.mailfrom=ips.gov.py;
 dmarc=bestguesspass action=none header.from=ips.gov.py; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipspy.onmicrosoft.com;
 s=selector2-ipspy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4LsvzOsnlj7xL/z34pqZ5k95dBpzOzNg24T2nzOzs0=;
 b=azCyvfo6zC7yeq3RRij4rRfk2r1QyGqojSh/pe2zrOyL3zItS4UvhcRPph3Kf/XTHT+JHi19PpN2kiEKUOKnUBQ/52gHB2xdOwhq1BWm5VSxAfFrJcptlOjV+xfV84Bq782ZWhF9aOMYt8+00TSVo8TMsFAAQcajrp9Ltjuxnqc=
Received: from DM6PR07CA0103.namprd07.prod.outlook.com (2603:10b6:5:330::35)
 by CPTP152MB4406.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Thu, 30 Mar
 2023 07:58:57 +0000
Received: from DM6NAM10FT028.eop-nam10.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::c1) by DM6PR07CA0103.outlook.office365.com
 (2603:10b6:5:330::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 07:58:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 201.217.50.26)
 smtp.mailfrom=ips.gov.py; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=ips.gov.py;
Received-SPF: Pass (protection.outlook.com: domain of ips.gov.py designates
 201.217.50.26 as permitted sender) receiver=protection.outlook.com;
 client-ip=201.217.50.26; helo=mail.ips.gov.py; pr=C
Received: from mail.ips.gov.py (201.217.50.26) by
 DM6NAM10FT028.mail.protection.outlook.com (10.13.152.240) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 30 Mar 2023 07:58:57 +0000
Received: from VS-W12-EXCH-01.ips.intranet.local (10.20.11.161) by
 vs-w12-exch-02.ips.intranet.local (10.20.11.162) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 30 Mar 2023 03:58:52 -0400
Received: from VS-W12-EXCH-01.ips.intranet.local ([fe80::4157:7765:5532:ff9a])
 by vs-w12-exch-01.ips.intranet.local ([fe80::4157:7765:5532:ff9a%14]) with
 mapi id 15.00.1497.042; Thu, 30 Mar 2023 03:58:52 -0400
From:   Sara Mereles Colman <smereles@ips.gov.py>
To:     "21@hotmail.com" <21@hotmail.com>
Subject: =?iso-8859-1?Q?MAESTR=CDA?=
Thread-Topic: =?iso-8859-1?Q?MAESTR=CDA?=
Thread-Index: AQHZYtydIuxelvslgkGsEfuqOp6JkQ==
Date:   Thu, 30 Mar 2023 07:58:52 +0000
Message-ID: <1680163095518.37954@ips.gov.py>
Accept-Language: es-PY, es-PE, en-US
Content-Language: es-PY
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [191.96.227.51]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM10FT028:EE_|CPTP152MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c08420c-cc1f-4e39-8ad1-08db30f49d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAJixl3Kzi5Ek9MCH8z2aeKvpbYkaL7r86F/frYqLOJbp9ZPdEnCn5x29UgflclWsWB/0JiTrkeFE+1OTWACKCTPbuIw6KZu8oN9ISWk76S8MbBNamUMnUU08s01v72eQDSdmNf1Ew+rC3PywFJxtoWyg9IjmdZf147V0LpgqBoX5QNVEitEOGyvKYs+105qPlHs2WRa5ffuQRRhro+d6WsUFx0c4G/B7fxH4lP4GhDGdiDgdKiFOgvknxLHvjpg4WmPS+Wyz5CIZttOkV9i1ESBFAHYvNBADsXbn7YGWm9+DLMEwYRou9YZ/XD3/3R4/N0cwp5UOFdnfPB22DoALf3W4+sVtNr9LOy2jnlfLbowVRrbXn1HK9O65JHZkM92J+so9IGX1g3AHNVANA/0NFFDfuqwuRUN2JO9FOJ+yh19AuGqShrTKj9Iw4LXVKNdAXdNbMa/1ENclaKuq88QA1lRwFYv4zbDq4c1HnGvTKnR3tglRFZMb4+kRLReCFqVx4uy0rt9XMpgw4G0X0iyDvR0kfgLDKfZEV4bUowfwo9DxUMdjRn2ijEiUInLfuyjgRCZhuoL7fq6nGSFgELGJxmkwfzYZaugPD/GfslZrXogm9pKKgsMe69h6nGIE6HX+NpIhIeG9SaRE1MM38UD3c4jAgJx+oUP9zqoM/cew9J1KaGDzNWObaLvSjik4Gkoyb3AF4U3rvz+SX8xSKoaJuQgcJ6fezf6psUQ30Bcn6TM0fSkakJ2oDHgIg7jouqRsRThaZ9zsi3CfpkWIEu97g==
X-Forefront-Antispam-Report: CIP:201.217.50.26;CTRY:PY;LANG:es;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.ips.gov.py;PTR:mail.ips.gov.py;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(2906002)(6862004)(8936002)(86362001)(66899021)(41300700001)(70206006)(70586007)(186003)(36756003)(316002)(55236004)(7336002)(7416002)(47076005)(224303003)(26005)(7366002)(7276002)(7406005)(356005)(82310400005)(4744005)(5660300002)(83380400001)(40480700001)(36860700001)(2616005)(66574015)(336012)(478600001)(7596003)(82740400003)(40460700003)(567454004)(17680700008)(487294008);DIR:OUT;SFP:1501;
X-OriginatorOrg: ips.gov.py
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 07:58:57.0672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c08420c-cc1f-4e39-8ad1-08db30f49d66
X-MS-Exchange-CrossTenant-Id: 601d630b-0433-4b64-9f43-f0b9b1dcab7f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=601d630b-0433-4b64-9f43-f0b9b1dcab7f;Ip=[201.217.50.26];Helo=[mail.ips.gov.py]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM10FT028.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPTP152MB4406
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I have a project offer for you. contact my private email below.

E-Mail: :drcc7072@gmail.com


for more information.??

































































































































MAESTR=CDA
Maestr=EDa en Direcci=F3n y Administraci=F3n de Empresas (ver+)
Maestr=EDa en Asuntos P=FAblicos y Gobernabilidad (ver+)
Maestr=EDa en Gesti=F3n P=FAblica (ver+)
Maestr=EDa en Prevenci=F3n de Riesgos Laborales (ver+)
Maestr=EDa en Derecho Penal y Procesal Penal (ver+)
ESPECIALIZACI=D3N
Especializaci=F3n en Cirug=EDa Dentoalveolar (ver+)


PUBLICACI=D3N DEL DEPARTAMENTO DE COMUNICACI=D3N SOCIAL Y PRENSA DEL IPS??
