Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290AC4E6FD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 10:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356244AbiCYJMe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 05:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356245AbiCYJMc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 05:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFEAFCD33F
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648199458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QMxMPmZqVhEjq+z25uJtmZ8oxGgfdMtdpHWVpm7w/Uk=;
        b=WaUy2THuFWrMT/njrmlI7YM47hkMnMHVM8nd8EnyUQNVnMBB3A4wwWVp8y8ELfyUEhOQOS
        h7OdHpsPg06z1xHdxWXN9a5yOSD5Y8pAd2UHGJ5lH0LEccAU6vl9H7CIZfsknZ768aQIow
        PQ8Dk8M/rn4pbiU+KRMGEc2P53zNgPg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-thh7RGY_OnqkbS7LlDlomg-1; Fri, 25 Mar 2022 05:10:54 -0400
X-MC-Unique: thh7RGY_OnqkbS7LlDlomg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD6E71C06923;
        Fri, 25 Mar 2022 09:10:53 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B905E141DED5;
        Fri, 25 Mar 2022 09:10:51 +0000 (UTC)
Date:   Fri, 25 Mar 2022 10:10:49 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
Message-ID: <20220325091049.b5vcfahti56hopy2@ws.net.home>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <20220323225843.GI1609613@dread.disaster.area>
 <CAJfpegv6PmZ_RXipBs9UEjv_WfEUtTDE1uNZq+9fBkCzWPvXkw@mail.gmail.com>
 <20220324203116.GJ1609613@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324203116.GJ1609613@dread.disaster.area>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 25, 2022 at 07:31:16AM +1100, Dave Chinner wrote:
> > What about other objects' attributes, statistics?   Remember this
> > started out as a way to replace /proc/self/mountinfo with something
> > that can query individual mount.
> 
> For individual mount info, why do we even need to query something in
> /proc? I mean, every open file in the mount has access to the mount
> and the underlying superblock, so why not just make the query
> namespace accessable from any open fd on that mount?


The current most problematic situation is in systemd. We get
generic notification (poll() on mountinfo) that something has been
modified in the mount table, and then we need to parse all the file
to get details.

So, the ideal solution would be notification that points to the FS
and interface to read information (e.g. getvalues()) about the FS.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

