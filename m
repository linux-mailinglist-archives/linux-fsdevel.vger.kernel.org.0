Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974EC39D928
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 11:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFGJ6T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 05:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGJ6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:58:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371EFC061766;
        Mon,  7 Jun 2021 02:56:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a11so24939942ejf.3;
        Mon, 07 Jun 2021 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AvcnTN1BHdD3Kt4RvDykE6ZAznmWeLO+Zb93ck1zaJM=;
        b=YZXBhqajoh4npRPJENJ7kH/mbGbbRTaTW0ky0sLDEHNyCTWciqHZthrVlsxXLWv0tM
         K32YA8IMM8Bo3oAAaPy2rrzBBxn/jtZ6LlcgqUM7Dj0Um2TviYjyj/2nCDmreyCUCn/F
         gpznxPlICcar4NJeC3BuXXb8JrxBGSpTvjiQJ3v+ZQaJvHUZEgDEKMpzUmC0PSJU4oTL
         dorkA27Gkhi5Sm6siw8WJLn8Ygp96NJU33+Drijf5GzjnzLEC7gqSxGoM/O/btKzLrkB
         stjqqLDUVWVLRWxhSfUyvzAOxfqihWB5J68qZkYkCevnw+uIXTdhz2L/ND52a4G0Ct7h
         hIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AvcnTN1BHdD3Kt4RvDykE6ZAznmWeLO+Zb93ck1zaJM=;
        b=ajFgg9ixC6Q2mBgY+HNLddASAFO0hDRYNtOUvEjElVh5wWSho4qiiA6KALsgZCvMnv
         Q4jMIXFPIHelLO4OMOk6lUXk3K3qsSH9aF4fZuUYf7XW7i7nyMRcc7rBbNGL9p+qFXAf
         nys6Xir9+w34F3MggzLqlOII2k2nzv9GZ1LTT+tSsYIGwNMykBxRLptE1bOBxxfJV+F2
         Qu8WDTBxd/i682+jigE2n33KMjGXjImZV2Mhtyh2M8YalUqlDInLwGtYUr5QKi5Y1zd9
         TQtjE3CMIRYQ5Z7S0oTrVPLLke2dKI4Epi91m7ruv1xL6ckBSPiIYqyUy8KN5LqsK85r
         w6Xw==
X-Gm-Message-State: AOAM53100eab9pQEXxDQNkYwQx7sXnmzl7zUTyPEecMb5I7d7nu+WWMI
        58SJnUXwiZ5hWJ1H5gtI/a2GXWj04x77xD5D9UU=
X-Google-Smtp-Source: ABdhPJzFfoswyH7JwPtkE63RJU+Sfbhdn3mp/4t02QbPN4nzkfnKGuiwz31ebyn909ixLI8DyqOkLxZkF6yP23pyNx4=
X-Received: by 2002:a17:906:c212:: with SMTP id d18mr17293083ejz.291.1623059770488;
 Mon, 07 Jun 2021 02:56:10 -0700 (PDT)
MIME-Version: 1.0
From:   Marius Cirsta <mforce2@gmail.com>
Date:   Mon, 7 Jun 2021 12:55:59 +0300
Message-ID: <CANO0Vk5++yd2TmJ9xDPe0-=gpeD5wXpdJpKVVibNVkQW4_czOQ@mail.gmail.com>
Subject: Re: [PATCH v26 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
To:     almaz.alexandrovich@paragon-software.com
Cc:     aaptel@suse.com, andy.lavr@gmail.com, anton@tuxera.com,
        dan.carpenter@oracle.com, dsterba@suse.cz, ebiggers@kernel.org,
        hch@lst.de, joe@perches.com, kari.argillander@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, mark@harmstone.com,
        nborisov@suse.com, oleksandr@natalenko.name, pali@kernel.org,
        rdunlap@infradead.org, viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I am just a user of the kernel but for me the ntfs support is really
important as I have shared drives that are in NTFS format and ntfs-3g
is not really the best as it has a high CPU usage.

What happened to this review ? I am not sure what the process is but
is no one really interested ?

I saw there were some comments initially but if those were solved then
is it ready for integration ? Is more testing required? I could help
with that if needed.
