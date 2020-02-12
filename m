Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06EF2159FBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgBLEFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727602AbgBLEFE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:05:04 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3889E20842;
        Wed, 12 Feb 2020 04:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581480303;
        bh=cT6+dtC55BJaR5cUKfCHoEPq+Ej5UCJLskJcDP2ADh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X4NpwaUNd25oASQc7FweEativ5f0k8QbzmjAnT2nCZPm7kEDGoDkViY0cDpU0Utmy
         lOV+Y9H9DdVgafYwZDuYPEKlR32dwqaleUWm8RS9DFU7SEEHJYLJXK/qNl0LFOP9m/
         ipU6NFNXfqsUvCwTNI+BpnC4iigbHbgiuRaoU4iE=
Date:   Tue, 11 Feb 2020 20:05:01 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v7 3/8] f2fs: Use generic casefolding support
Message-ID: <20200212040501.GE870@sol.localdomain>
References: <20200208013552.241832-1-drosen@google.com>
 <20200208013552.241832-4-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208013552.241832-4-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 05:35:47PM -0800, Daniel Rosenberg wrote:
> This switches f2fs over to the generic support provided in
> commit 65832afbeaaf ("fs: Add standard casefolding support")

Referring to earlier patches in a series by commit ID isn't a good idea because
the commit ID is unknown until the patch is applied.

- Eric
