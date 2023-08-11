Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A337797CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 21:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbjHKTbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 15:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbjHKTbW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:31:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0AE30E6;
        Fri, 11 Aug 2023 12:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p5qvQ+yzO9nazRIKAyXORjIabtCXmQCWDwI1BMoHGgE=; b=y9yj2T9iBuU7QR0NCC+wFIp5bT
        lbifkJx0QbnK/6cjOU6ilyHuw7vKWTpSLQ1GQYC0ArvwQ1TDxFzwqzbL1Lp1AEMz9UV74CM/MGIcK
        HCl6aleTnY+zFdw2I0h1v5nE3ZA4u6T2PO6cnfkT9vFe+vJbbz+dt3MBkC6WBnlBpnEK8jT9Dlaio
        6pTnn+9pI3lWEe07Bk5/+qojr9CPvrvi34qDa0fIMmrXsmqGYqFiNs32rcoKsES+prEe7x0UDYu5h
        r/Np5S5Co8OllWLqM3sSoNi1/EvzwOWwvHzfXHR9+80cxQrlCNZkTOOB7QJ5C8hfJdf1tWnkjndPk
        uIsLAatw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qUXqw-00BSyf-2F;
        Fri, 11 Aug 2023 19:31:18 +0000
Date:   Fri, 11 Aug 2023 12:31:18 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     corbet@lwn.net, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com, cem@kernel.org,
        sandeen@sandeen.net, chandan.babu@oracle.com, amir73il@gmail.com,
        leah.rumancik@gmail.com, zlang@kernel.org, fstests@vger.kernel.org,
        willy@infradead.org, shirley.ma@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 1/3] docs: add maintainer entry profile for XFS
Message-ID: <ZNaMhgqbLJGdateQ@bombadil.infradead.org>
References: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
 <169091990172.112530.13872332887678504055.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169091990172.112530.13872332887678504055.stgit@frogsfrogsfrogs>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 12:58:21PM -0700, Darrick J. Wong wrote:
> +Roles
> +-----
> +There are seven key roles in the XFS project.
> +- **Testing Lead**: This person is responsible for setting the test
> +  coverage goals of the project, negotiating with developers to decide
> +  on new tests for new features, and making sure that developers and
> +  release managers execute on the testing.
> +
> +  The testing lead should identify themselves with an ``M:`` entry in
> +  the XFS section of the fstests MAINTAINERS file.

I think breaking responsibility down is very sensible, and should hopefully
allow you to not burn out. Given I realize how difficult it is to do all
the tasks, and since I'm already doing quite a bit of testing of XFS
on linux-next I can volunteer to help with this task of testing lead
if folks also think it may be useful to the community.

The only thing is I'd like to also ask if Amir would join me on the
role to avoid conflicts of interest when and if it comes down to testing
features I'm involved in somehow.

  Luis
