Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DB27A0137
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 12:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbjINKGZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 06:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbjINKGZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:06:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7DC1BE5;
        Thu, 14 Sep 2023 03:06:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187C0C433C7;
        Thu, 14 Sep 2023 10:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694685981;
        bh=CkSRMYFBsTLwcaa6sUvfed0uk3s6qCHf4pFcXzRd/08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=od4pVKVex5S3GCUDUc8gRWljOzq2TbPiOeDnT6kHt9INkqBmAX5+EkIjluCtmHapm
         eGwfI6mgmrfjMTMAiTejPUBhSTQsOz4T45Lub0FfswDFnyg2cYanxLPpQEn409FZ0k
         MWMo1K1e88DLEXnjL0Kk+gM2k+T3M74EuMuS3V8CIrNTg2+voGROGIqHw5C+U4hGDU
         ipkDH86HAgdJ2irt158sHHBdRsDIpfTb/d8224NYgxG0TFkrttcBs9DkTMztwR1mzn
         t2KjGOfyfn5NyXnbm5t0KfOTXNeYb8hPHy9kV5koYubtnmBWlAJfeD4I+g5a+VG77K
         BBBlwP/JvzCew==
Date:   Thu, 14 Sep 2023 12:06:15 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 1/3] add unique mount ID
Message-ID: <20230914-zielbereich-wortlaut-94382f1c3b02@brauner>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-2-mszeredi@redhat.com>
 <20230914-himmel-imposant-546bd73250a8@brauner>
 <CAJfpegv8ZVyyZN7ppSYMD4g8i7rAP1_5UBxzSo869_SKmFhgvw@mail.gmail.com>
 <20230914-jeweiligen-normung-47816c153531@brauner>
 <CAJfpeguJ+H7HkZOgZrJ7VmTY_GhQ5uqueZH+DL9EuEeX5kgXQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpeguJ+H7HkZOgZrJ7VmTY_GhQ5uqueZH+DL9EuEeX5kgXQw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> But I'd still leave the 2^32 offset for human confusion avoidance.

Sure, it's really not worth arguing about.
