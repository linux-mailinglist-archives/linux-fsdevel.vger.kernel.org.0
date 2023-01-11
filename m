Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF9E666101
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 17:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjAKQyf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 11:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbjAKQy1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:54:27 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C1E140F9;
        Wed, 11 Jan 2023 08:54:26 -0800 (PST)
Date:   Wed, 11 Jan 2023 16:54:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1673456065; bh=X4HEKEi5ch87AlkCFdW3Lvwmp1IKLp0vo7TehUhbszQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=OtEW+cP8oqzoONx/P5LC5EF4BEIG1d+li3K+xa4H2gtIEWmKcT+dJD9wdWEtyMJ6/
         K+Ut/WaEx+2d/C+boRCN+5ZIsDQHg2t4QEwvI+/COm8H5ABEX+6Lj8/I6HzdiXAcf/
         rpK1pvYr5deU8o66+slW7stP4OFnI/324/bBGx2E=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrey Vagin <avagin@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] nsfs: add compat ioctl handler
Message-ID: <20230111165423.j4s7ze2cywdaeglq@t-8ch.de>
References: <20221214-nsfs-ioctl-compat-v1-1-3180bf297a02@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221214-nsfs-ioctl-compat-v1-1-3180bf297a02@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 11, 2023 at 04:42:07PM +0000, Thomas Weißschuh wrote:
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 3506f6074288..4d2644507364 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -21,6 +21,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
>  static const struct file_operations ns_file_operations = {
>  	.llseek		= no_llseek,
>  	.unlocked_ioctl = ns_ioctl,
> +	.compat_ioctl   = ns_ioctl,
>  };

Please disregard this patch. It was a resend of a wrong revision.
The correct revision was v3 which I also resent.

Sorry for the noise.
