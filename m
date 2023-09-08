Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36B379870E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 14:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241750AbjIHMed (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 08:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjIHMec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:34:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905A61BFB;
        Fri,  8 Sep 2023 05:34:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37F9C433C9;
        Fri,  8 Sep 2023 12:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694176468;
        bh=PFxXRPIRYU4HkCDbJ6QrM+afPNa1kHaLTJJcMZdosCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODJNb2yuNntoTQg6BLcfz/1FGh8iBcS+VizS8FHi4l5i6XCYI9C4XOKP3zdpVoeKm
         iz8T88Vq3AzAGdeFzrPGvgX0gJGw7UwK0OS1oMM/z2dHERHXwS/M8FDMC9BhFWr7Ja
         bbn8wJ2nZzEG4ZzO34kMuRDyAa5iCNSgCLNPOKqhXlggfMYe+A+BRmtwMeohn57Afm
         d+8pkngZUBEXZkYbbFPk5UIlg4GWRvMxxyhiuYA1KtNr2RAXaB7kOdS/NNbOkVaTFj
         ETtSx7jp9KAhkbHnesWrBSRqk/OWd+gEcUSt0sVlaQ1CGB9ZsaNCxZMuu+Yahs1ArU
         /e+mxl/8sfFRA==
Date:   Fri, 8 Sep 2023 14:34:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zdenek Kabelac <zdenek.kabelac@gmail.com>
Cc:     Zdenek Kabelac <zkabelac@redhat.com>, Jan Kara <jack@suse.cz>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
Message-ID: <20230908-planung-raumakustik-abf518a2f88a@brauner>
References: <818a3cc0-c17b-22c0-4413-252dfb579cca@redhat.com>
 <20230907094457.vcvmixi23dk3pzqe@quack3>
 <20230907-abgrenzen-achtung-b17e9a1ad136@brauner>
 <513f337e-d254-2454-6197-82df564ed5fc@redhat.com>
 <20230908073244.wyriwwxahd3im2rw@quack3>
 <86235d7a-a7ea-49da-968e-c5810cbf4a7b@redhat.com>
 <20230908102014.xgtcf5wth2l2cwup@quack3>
 <15c62097-d58f-4e66-bdf5-e0edb1306b2f@redhat.com>
 <20230908-bergwacht-bannen-1855c8afe518@brauner>
 <4a0952f8-32b1-46fc-a9f2-4be58ee41ace@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a0952f8-32b1-46fc-a9f2-4be58ee41ace@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> So can you please elaborate which new risks are we going to introduce by
> fixing this resource hole ?

I'm not quite sure why you need a personal summary of the various
reasons different people brought together in the thread.
