Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0802E693AFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 00:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBLXJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Feb 2023 18:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBLXJv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Feb 2023 18:09:51 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E75D51E
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Feb 2023 15:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676243389; x=1707779389;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EIcynABI6eV7+ZrIO/d7OvBozPHAy0oWjn5B/BE+VHk=;
  b=CofGS/v2gxsto2X9/Mc5jJsGoZ9zdQSyFYv77ne8hByxg1ul1n68SNBs
   hpvl72P133Do/oUUS7Ypaaq/6CPmEM/lyC6rGZHiFZvqwxAXL4+nVY0/K
   LseHvH/Ol5ya3KrI9ULYMX7mPhm3On8yrpziJFFkfT7Q60TQyNrnI0+lZ
   gPVfaPUqxQyD0I8ApnBUbG/5VWitmUYEd3ovNAG+uJEejBaayznCgamJY
   qgzbo7EAlvybpqeA6G2tf0pwTIcpbjzQKZMmxRGWAABgd0mI0hedm6Mn4
   Ffl1a3K65GxV+RtPiDJac7BuvOKwqjPfz7m0uNFtPOK2aDwacXVC46q+y
   A==;
X-IronPort-AV: E=Sophos;i="5.97,291,1669046400"; 
   d="scan'208";a="223155000"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2023 07:09:48 +0800
IronPort-SDR: a9LUWgALYQYefpFSLoycWVYQpyeD66c6ihwaDQxO2oiciFFdn7Dlb30/K7qMqUzRWydSg5Ify5
 TP4NhyHd7eZhsdsVImZxxBcoQoXC6RQ4ro4gOzvQeybcHIQ5KWRW0+piiEucsH5l5rRS4+8EXW
 ZW5K8ntESKbScY5jxIGSdPcwnKRH93UOGQWZumxHNPxn6eyVDNnxZagb9CVlUdGEhozCuded8Q
 l5SYVgiHz//YRf0QjUGyWTyCDITL7mjDEcBdgmi1eUnWGRbT3Jr/A/bLKW7rXdkvGwvT2R2vBs
 c6A=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2023 14:26:59 -0800
IronPort-SDR: m7eWKuyEOLHwWUQX5tudq0QtJD/4XOdWied0I3HAK3RhBMa4U4W0EMM9ZnBPlQ+4ncXiy0j/TM
 amwIey9jQjxEJ5TtS5GDqMV7xnpWAU+URP41ZyWAwMWLoXX5rnscZU0CbyS72VX0o7qdZPUAci
 gvgAtUgmOn8sSV9GU4FWlLbPkov9FpiExVm2X/nnv/H8LEsivuxZLveBBeuckdLje7banWSYc9
 nqZ5zatGaJo9ZZjN8YmtEqEMIWFxKnmufea+glUOQxiQXt8H8y6mNvxr6MvF1mZdRc7iRs4nJo
 lH4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2023 15:09:49 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PFNTm42zlz1RvTp
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Feb 2023 15:09:48 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676243388; x=1678835389; bh=EIcynABI6eV7+ZrIO/d7OvBozPHAy0oWjn5
        B/BE+VHk=; b=R3BdfjIlgGQd6D9DnacNqGwJd4/VNEAdS44OIRJlhLvnOxT+/Ne
        xX7judt+N4DV7p7eHk33DET9vvNqEljU3OOeP/xFEIX8LpxVht3BYL/QwfjtChct
        VfroetTFvrISrj0ajONeSld/flwekuPkfFwRddSUZIMJ+CrznO3Z0B3A/pv00UkF
        1vsEYblfQA9B54aUyaN4ntsCxPKqXBNTM6dsvEMq8TS/RgPb7EvrdkjTJVpNryKV
        mEYlyFNSSZvHKrUKYUqUuSO0PPZqCtgQAHTi71v9nQLFqiRDX17VKfoS/17ESEjM
        aV1gidLqN7vtS2lIdPUmJZZrMNSNI3scb6w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DSjJlAKHyKdd for <linux-fsdevel@vger.kernel.org>;
        Sun, 12 Feb 2023 15:09:48 -0800 (PST)
Received: from [10.225.163.110] (unknown [10.225.163.110])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PFNTl2p37z1RvLy;
        Sun, 12 Feb 2023 15:09:47 -0800 (PST)
Message-ID: <665f4223-8de2-a268-b072-f01b2b1317e5@opensource.wdc.com>
Date:   Mon, 13 Feb 2023 08:09:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] zonefs: make kobj_type structure constant
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230210-kobj_type-zonefs-v1-1-9a9c5b40e037@weissschuh.net>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230210-kobj_type-zonefs-v1-1-9a9c5b40e037@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/10/23 11:14, Thomas Wei=C3=9Fschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
>=20
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Applied to for-6.3. Thanks !

--=20
Damien Le Moal
Western Digital Research

