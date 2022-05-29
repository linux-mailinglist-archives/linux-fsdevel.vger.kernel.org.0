Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C33953725B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 May 2022 21:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiE2TgC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 May 2022 15:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiE2TgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 May 2022 15:36:01 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF65313BD;
        Sun, 29 May 2022 12:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy6XiZrUj/4dJe/pTnxRIu6PTjYDBm2E+EeCahBtnCFtXoreGQB4CjdFyIIk0J3hHJTjrbQ7/dshuhdecXamGXJyHEh9ytXBG0fDijq0pJL1fAJTMuOf+ByX9OsQnHLQBOV+LAl6BhvrTaBfRXCBWXVSjITb8RNsgWilyQV/7FWSu/nEB5D84oWAICmxscAHX1vICFshMuSUjTBQMHyNW4v3Lva7r7iCeU9EvoAWP5R+a9dO9hCTw2yra8HGZkSCg6NpstBBGU4e8Xp8Iym9hCkANd0tWeZaJE75UJfdMnW6gQelThiUw4LMiOo7pzAFo901mIz9qwK2VfN0xgDF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9kJQBVbtiCGCwifnJiCH2pL0196NSAbUOSWbj/PDQQ=;
 b=bVoHAcUQ4AuX4dRMKsbcot5rXmchESnKr1QC6FTpob7cfIOr2+PkxLZRZGPQ34IIBInpA8m6kOdvgbfS0Z+tEAi0eVbyLtvVecQ47JyeMVlTRC4rrJlTdzF+S6bMr2DNcW+l5z/ZzKeHV/n6dfIHI+tdZZVRrxlfNEkS73HbnSU7w+t0UPkK9D0ibOm5W0xm46a2O7EvumJjcn+nFLDs/qcZuium8grLIC8vYqPNR2tIkMROK9ZXD0QXnQSNdpXE/gJLfPd9AM+Torq7axXaZJmBe+CtATCd6Iw4ga1/WlPth4iCbDVwKOVa3CDQbPGIkAJtTrSpKX0x/hefP33glw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=hallyn.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9kJQBVbtiCGCwifnJiCH2pL0196NSAbUOSWbj/PDQQ=;
 b=alsYUzsgfu2kBBz35rf4S6GkS2MFpfUzHIf6Y+VpBRN4uBO7qwppOQKJyF6gCVFtLB8+35PKMIoNRRaXqrqkc7Mm01tURYCS2dFojY6zJqUmNOdcpJfXkVFNEG3P2hTDAtCI2QfCRrovYUv5dQqqAOPjorcHcQA1EWi6AFXqAm10VQ1HX7rUB/nvNc/A6uSlra3LOOsgrYls2bv2EjV3F4ibIenoaJJBWeJE/5QzuPBhH7o6xOe4MPjTEp85xavtLTuLGQO7Rwbu45+00yo69fURMlTVVf0omwkH0IiACYxHGCdZEcalfpSAi9UnjPfvT3A+LJjZzd1Bu1QUv3Td+g==
Received: from AS8PR04CA0063.eurprd04.prod.outlook.com (2603:10a6:20b:313::8)
 by DB8PR10MB3925.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Sun, 29 May
 2022 19:35:56 +0000
Received: from VE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:313:cafe::c6) by AS8PR04CA0063.outlook.office365.com
 (2603:10a6:20b:313::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19 via Frontend
 Transport; Sun, 29 May 2022 19:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT034.mail.protection.outlook.com (10.152.2.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Sun, 29 May 2022 19:35:55 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Sun, 29 May 2022 21:35:55 +0200
Received: from [167.87.34.31] (167.87.34.31) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Sun, 29 May
 2022 21:35:53 +0200
Message-ID: <0e817424-51db-fe0b-a00e-ac7933e8ac1d@siemens.com>
Date:   Sun, 29 May 2022 21:35:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] binfmt_misc: enable sandboxed mounts
Content-Language: en-US
To:     "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <brauner@kernel.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Laurent Vivier <laurent@vivier.eu>,
        <linux-fsdevel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>,
        Henning Schild <henning.schild@siemens.com>,
        Andrei Vagin <avagin@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <containers@lists.linux.dev>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20211216112659.310979-1-brauner@kernel.org>
 <20211216112659.310979-2-brauner@kernel.org>
 <20211226133140.GA8064@mail.hallyn.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20211226133140.GA8064@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.34.31]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.946000-8.000000
X-TMASE-MatchedRID: v0a9hlk/Xh45QaOxwNGfvo9bHfxDWoibsKJhEY/Irgz+xRIVoKNMvKm9
        /6ObPjnDg62QWKBoZ9TlMvpqkHcOyp1jW0/FUy0zn6XhnzyfSWSAD7KBteVG1ioiRKlBVkYIPxk
        7jhVM+bOYeMTPaAHLLTLf00XtmskBkC5ztdHXy0pYuisaQSdueGEDtoQuhPs/MIxbvM3AVojMBI
        NgV4CMFzL/GHoao0dVlMa9Q0Vx5vQkjt4B/PGyfZd5YU45dgpqjGg0sQh4KI74AIbmhYnu0hA5w
        xKjT3bqWAuSz3ewb21l/QxSCU7NR2JnSJIXzk8FNhKiZ9p2PIYLYCfOeHh8DpCANcFtZ7wTAajW
        +EL+laNrvf5eVgMu7Akqr8zBserxsTRfLgN3cZpkCpQcBhVJgLUJAFSGapxPGjzBgnFZvQ5BJ1C
        xuVkwjVjUiKW+wxBSsfhXNEQHdCDIwJSEVGBiRl7CaG3JM2oE7O9PFKJckb8Yw0T6R7qoWggY7K
        Pzv1XI5+/DWPKjFkASYyrEXZm9SbPtzDaZR+XxWO3sffakmrS1nqCE1B9P3G1rAlJKwOBJIxU1J
        siU5bE/gf7afIrQU5OGmTuYwVRQK+fbv4M7+TC1M6vEQZCbhnDWCEZXvYIHdo0n+JPFcJp9LQin
        Z4QefL6qvLNjDYTwsuf7RWbvUtz3/q0E8NSuagtuKBGekqUpIG4YlbCDECtruV6hT84yE1iwJpr
        BIi4pIOuw+qM+2ugcAPnkPggSbWg+KZ/cASGZjJqJTyMz1Id+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.946000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 80085A176D2C6BA744A189C1094A6A35B294B5C35EFD23971290D668586B11AF2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ae1696e-3fd2-4e92-91dd-08da41aa72eb
X-MS-TrafficTypeDiagnostic: DB8PR10MB3925:EE_
X-Microsoft-Antispam-PRVS: <DB8PR10MB3925B44FBE09F5025AE528DE95DA9@DB8PR10MB3925.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNsjHRVqs7QMwqgI71b0y4PFvDg2BInBCPuj79jY+n+vN5vTeAC05WV9tfjDIojflfnnR6YQtxtAdSQKu7FehXRH+eeZJOeu/NxM8Y6JQMmOEe9RxjWr32P5ujs3oCpOIC0ih0CBWvAyDGXjXOcJnr4WRZY426+TjndvtiSxF4njcUJeDuPFfTI0c6WP261DOBSe4uUO9C+mwQyDiaa9ubi4GXLjMmwXXdLdLlLvwg6VAD566FBSvhl+x7d7G0Yar444f3Aaj1B/AO8ILIa3jQoue/p8BXdK1lmSAZWSX9As0Ti23BuQz+Atwd3X+V0OboRhn0Hl0fegEWNZWvirnur8Xat9Kc/DZBE6wxCnCV87DzC2zK/nHh1yD8iZ1yBmlGFG8KIM0/JAFbDqqRQyFsdDwBLZMxTJ17dG/DEDeYovBYKk+DB9+FF6YKCHBpRuOzYYuvg0kuBXq5g6xXyeCKMBxoGyyD0k7CSdmZdvYS4jBJvZuY/I1tlpv6ColmM5tfkRzCRtlOedbCSlW4PpCdaavt/ZkMfL6SsstupNdWorIvWUs6239Fl4hXni3ZUkb1WYqJN7ouC/245bCJ6a0Km8oTy5YuPhn2DbGQ6QCAe4hDTHQmtXCs4tbm0rxprA3/VYZZpzzK7RJEhMmH9lxQk8dHROL3xAqREXIGw6a0PIfopgCSPXG2hkhyO8IoTFZOm5sOmy1TFj3oO3TMtqGVUbQWiXJ2y1sgFaSzrl51U2xot6snGZ+BpbeJYaXV7jOrzrtMWP/TBZ5FwxIcjVkvH9SUtK9kGfjmpb8sXPBbiDpqXM1kBItvN5MBevsjFw
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(44832011)(5660300002)(8936002)(53546011)(31696002)(7416002)(86362001)(966005)(40460700003)(6666004)(26005)(2906002)(36860700001)(7636003)(7596003)(82960400001)(356005)(82310400005)(956004)(2616005)(47076005)(336012)(16526019)(186003)(83380400001)(31686004)(316002)(4326008)(8676002)(6706004)(110136005)(54906003)(36756003)(16576012)(70586007)(70206006)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2022 19:35:55.4164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae1696e-3fd2-4e92-91dd-08da41aa72eb
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3925
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26.12.21 14:31, Serge E. Hallyn wrote:
> On Thu, Dec 16, 2021 at 12:26:59PM +0100, Christian Brauner wrote:
>> From: Christian Brauner <christian.brauner@ubuntu.com>
>>
>> Enable unprivileged sandboxes to create their own binfmt_misc mounts.
>> This is based on Laurent's work in [1] but has been significantly
>> reworked to fix various issues we identified in earlier versions.
>>
>> While binfmt_misc can currently only be mounted in the initial user
>> namespace, binary types registered in this binfmt_misc instance are
>> available to all sandboxes (Either by having them installed in the
>> sandbox or by registering the binary type with the F flag causing the
>> interpreter to be opened right away). So binfmt_misc binary types are
>> already delegated to sandboxes implicitly.
>>
>> However, while a sandbox has access to all registered binary types in
>> binfmt_misc a sandbox cannot currently register its own binary types
>> in binfmt_misc. This has prevented various use-cases some of which were
>> already outlined in [1] but we have a range of issues associated with
>> this (cf. [3]-[5] below which are just a small sample).
>>
>> Extend binfmt_misc to be mountable in non-initial user namespaces.
>> Similar to other filesystem such as nfsd, mqueue, and sunrpc we use
>> keyed superblock management. The key determines whether we need to
>> create a new superblock or can reuse an already existing one. We use the
>> user namespace of the mount as key. This means a new binfmt_misc
>> superblock is created once per user namespace creation. Subsequent
>> mounts of binfmt_misc in the same user namespace will mount the same
>> binfmt_misc instance. We explicitly do not create a new binfmt_misc
>> superblock on every binfmt_misc mount as the semantics for
>> load_misc_binary() line up with the keying model. This also allows us to
>> retrieve the relevant binfmt_misc instance based on the caller's user
>> namespace which can be done in a simple (bounded to 32 levels) loop.
>>
>> Similar to the current binfmt_misc semantics allowing access to the
>> binary types in the initial binfmt_misc instance we do allow sandboxes
>> access to their parent's binfmt_misc mounts if they do not have created
>> a separate binfmt_misc instance.
>>
>> Overall, this will unblock the use-cases mentioned below and in general
>> will also allow to support and harden execution of another
>> architecture's binaries in tight sandboxes. For instance, using the
>> unshare binary it possible to start a chroot of another architecture and
>> configure the binfmt_misc interpreter without being root to run the
>> binaries in this chroot and without requiring the host to modify its
>> binary type handlers.
>>
>> Henning had already posted a few experiments in the cover letter at [1].
>> But here's an additional example where an unprivileged container
>> registers qemu-user-static binary handlers for various binary types in
>> its separate binfmt_misc mount and is then seamlessly able to start
>> containers with a different architecture without affecting the host:
>>
>> root    [lxc monitor] /var/snap/lxd/common/lxd/containers f1
>> 1000000  \_ /sbin/init
>> 1000000      \_ /lib/systemd/systemd-journald
>> 1000000      \_ /lib/systemd/systemd-udevd
>> 1000100      \_ /lib/systemd/systemd-networkd
>> 1000101      \_ /lib/systemd/systemd-resolved
>> 1000000      \_ /usr/sbin/cron -f
>> 1000103      \_ /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
>> 1000000      \_ /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
>> 1000104      \_ /usr/sbin/rsyslogd -n -iNONE
>> 1000000      \_ /lib/systemd/systemd-logind
>> 1000000      \_ /sbin/agetty -o -p -- \u --noclear --keep-baud console 115200,38400,9600 vt220
>> 1000107      \_ dnsmasq --conf-file=/dev/null -u lxc-dnsmasq --strict-order --bind-interfaces --pid-file=/run/lxc/dnsmasq.pid --liste
>> 1000000      \_ [lxc monitor] /var/lib/lxc f1-s390x
>> 1100000          \_ /usr/bin/qemu-s390x-static /sbin/init
>> 1100000              \_ /usr/bin/qemu-s390x-static /lib/systemd/systemd-journald
>> 1100000              \_ /usr/bin/qemu-s390x-static /usr/sbin/cron -f
>> 1100103              \_ /usr/bin/qemu-s390x-static /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-ac
>> 1100000              \_ /usr/bin/qemu-s390x-static /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
>> 1100104              \_ /usr/bin/qemu-s390x-static /usr/sbin/rsyslogd -n -iNONE
>> 1100000              \_ /usr/bin/qemu-s390x-static /lib/systemd/systemd-logind
>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud console 115200,38400,9600 vt220
>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/0 115200,38400,9600 vt220
>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/1 115200,38400,9600 vt220
>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/2 115200,38400,9600 vt220
>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/3 115200,38400,9600 vt220
>> 1100000              \_ /usr/bin/qemu-s390x-static /lib/systemd/systemd-udevd
>>
>> [1]: https://lore.kernel.org/all/20191216091220.465626-1-laurent@vivier.eu
>> [2]: https://discuss.linuxcontainers.org/t/binfmt-misc-permission-denied
>> [3]: https://discuss.linuxcontainers.org/t/lxd-binfmt-support-for-qemu-static-interpreters
>> [4]: https://discuss.linuxcontainers.org/t/3-1-0-binfmt-support-service-in-unprivileged-guest-requires-write-access-on-hosts-proc-sys-fs-binfmt-misc
>> [5]: https://discuss.linuxcontainers.org/t/qemu-user-static-not-working-4-11
>>
>> Link: https://lore.kernel.org/r/20191216091220.465626-2-laurent@vivier.eu (origin)
>> Link: https://lore.kernel.org/r/20211028103114.2849140-2-brauner@kernel.org (v1)
>> Cc: Sargun Dhillon <sargun@sargun.me>
>> Cc: Serge Hallyn <serge@hallyn.com>
> 
> (one typo below)
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>
> 

What happened to this afterwards? Any remaining issues?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
