Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860046A24E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 00:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBXXKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 18:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjBXXKa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 18:10:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291921630B;
        Fri, 24 Feb 2023 15:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=PWlxtCRdEYf+JZg4eqY+Ghwyo/skTEHHEw79y59hqkA=; b=0/Tor7OOrFQUrrKwtxamtltx11
        nKDIVjdsIQ0gcNotQUCZhG8ECjAKhIBhvT3EStnMoaGsUPNqn0mgb4ZNh4qc3MVSt4HlxYcMVbJHV
        FcAL4x6XaOSHfXi5IZ4txQCLonRG2UoF/uOzi56GM1rKkuVPtqF6bCvWpDcLpEijZLuBmRmIkYKV8
        f2ZaohLjFfmyuZqV2HlL5q0ikn01WleytaBoP378s41z0gdnmms6oecbmKLlSaZ2tW5Q3SM+/NiLA
        FCRZyB/gPI/aj6PCnv6VCkCFC5QANTD0gbbPFijxoT9SCGDpTQDPAuRJ1OJLAOoya6ui+gjUOU3GL
        ud7yYcYw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVhCs-004G7y-Iv; Fri, 24 Feb 2023 23:10:26 +0000
Date:   Fri, 24 Feb 2023 15:10:26 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org
Subject: [ANN]: kdevops v6.2 released devices
Message-ID: <Y/lD4kVcPqUppMwm@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'd like to announce the release of kdevops v6.2 [0] [1]. I had already written
about most of the new features on the v6.2-rc1 release in the December 2022
notes [2], but since a new features cannot regress we've seen a few more new
features sneak in since then. I'll re-iterate a few of the newest major
features added since our last release (v5.0.2):

  * ZNS
  * CXL
  * NFS
  * Initial Kernel selftests suport: firmware, sysctl, kmod
  * OCI cloud support
  * libvirt use 9p now for local builds
  * PCI-passthrough support including a new dynamic kconfig interface for it
  * Building qemu for you
  * 12 btrfs profiles to test
  * Results for tests are now archived see workflows/fstests/results/
    for an example namespace

For more details of release notes you can refer to the v6.2-rc1 [3] and
v6.2 [4] git tags.

Thanks a lot to the developers who have contributed:

  Adam Manzanares
  Amir Goldstein
  Chandan Babu R
  Jeff Layton
  Joel Granados
  Josef Bacik
  Luis Chamberlain
  Pankaj Raghav

*If* it makes sense, we may set up a stable brach for v6.2.y releases so
which could fixate on the vagrant setup, so that folks using libvirt
can get fixes. If we do that it would make sense to just merge fixes
to the master branch first before the stable branch as well just as we
do in upstream linux / stable branches.

  Luis

[0] https://github.com/linux-kdevops/kdevops
[1] https://gitlab.com/linux-kdevops/kdevops
[2] https://people.kernel.org/mcgrof/kdevops-v6-2-rc1-released
[3] https://github.com/linux-kdevops/kdevops/releases/tag/v6.2-rc1
[4] https://github.com/linux-kdevops/kdevops/releases/tag/v6.2
