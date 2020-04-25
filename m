Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10A41B87F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 19:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDYRHO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 13:07:14 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60381 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbgDYRHN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 13:07:13 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B8385C0172;
        Sat, 25 Apr 2020 13:07:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 25 Apr 2020 13:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm2; bh=+C2VjyQ2cmYFmQIGbS0PPo36mP
        R3PNjT64EnXqiAICA=; b=eGgl9IwMZh5zq6lvo3Ao7SMrzL20kG8RvjcZ/Bcy8U
        7ZoSmdobk8QW7FRVzefYd/KLyH2Hk1jeYHcpEExViJHcF/jnk+5gITxpFBl39Mbe
        c1tZZaqk+Q8Ys5Eby+utZFrBqbXK1q4orbPlEsvVzOXHbU8sCiuFRV4pGZVAz1jz
        V2xJfohWHfZXc5ZWzFm6eJzJfETIc94xE0/0qvFPMyYNU2JwKwJ9s07bt8VD9/zu
        S+Z1c3grdqzPYdp1DQmt7kF5ZAIoRN9p7PSilh/hS96K0Z+J2jm8WV78qtTPefMu
        Hl7cBia0+eIsFnM/Ka6iZO9d+CSg2B6j+bZVPsa8j6Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=+C2Vjy
        Q2cmYFmQIGbS0PPo36mPR3PNjT64EnXqiAICA=; b=RY113c8Omdc0T/KoVapopj
        TqOwNuJ+M7Bt7R8R5e2utKXIW8SZT4L0XUgPjhjFyr+yOvoFaDW8jEyR+ZfgOgKA
        NMemI8FeirXwMrixWsgHj/r3f6etRmXpn4DMJvNuK40PdjsoZYtEujcm3f1gr1qo
        x9g+yUiS7DcmN7c4KNCoVxfH/AjWBZ2/pu5zdi5kJn3SB2OC+7hSAGdp2Lnkow2g
        C8qbB8IgU7lh02r7wTNRo10JBtTW6b7Hy9uOjsjKl9nxOTRtCzH6bD2OiGFRFV3w
        foMzt56xFWDdvSKb3me9RZSuUGaTzj424iz7UUv3jfTEo9mM40RPqVtfMIRNBJ1g
        ==
X-ME-Sender: <xms:QG6kXkrOOiidkOkxjcRGSpEFK_AQ907hCaxX_kDN59ZvdXd4HTOL7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrheeggdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgfgggtgfesthhqtddttd
    erjeenucfhrhhomheppfhikhholhgruhhsucftrghthhcuoefpihhkohhlrghushesrhgr
    thhhrdhorhhgqeenucfkphepudekhedrfedrleegrdduleegnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheppfhikhholhgruhhssehrrghthhdr
    ohhrgh
X-ME-Proxy: <xmx:QG6kXqPZ-VrTeIbwY4TBAQWLeVjjcJFv77S8I7_Ve4_R0FPYfSqANw>
    <xmx:QG6kXs-WdkpIwON_E8-1ucUZw4lUrGeNPRn5BLTaaMQmWNLWeyC4eA>
    <xmx:QG6kXgVn8cXqnAp9VVNrMGNMgFVpEzBbHEY3IkcLga456EyHvzupzQ>
    <xmx:QW6kXtcbUwuZxlwfTy_MYE7EMASvrD3CnoRUaNbxOVE7GZbuT2G_uQ>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9F4F03065DC2;
        Sat, 25 Apr 2020 13:07:12 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id AEF6F1BF;
        Sat, 25 Apr 2020 17:07:11 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 6C908E0096; Sat, 25 Apr 2020 18:06:16 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Subject: [fuse] Getting visibility into reads from page cache
Mail-Copies-To: never
Mail-Followup-To: linux-fsdevel@vger.kernel.org, fuse-devel
        <fuse-devel@lists.sourceforge.net>
Date:   Sat, 25 Apr 2020 18:06:16 +0100
Message-ID: <87k123h4vr.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

For debugging purposes, I would like to get information about read
requests for FUSE filesystems that are answered from the page cache
(i.e., that never make it to the FUSE userspace daemon).

What would be the easiest way to accomplish that?

For now I'd be happy with seeing regular reads and knowing when an
application uses mmap (so that I know that I might be missing reads).


Not having done any real kernel-level work, I would start by looking
into using some tracing framework to hook into the relevant kernel
function. However, I thought I'd ask here first to make sure that I'm
not heading into the completely wrong direction.


Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
