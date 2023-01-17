Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E7F66E835
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 22:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjAQVLr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 16:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjAQVJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:09:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919EF6B999
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 11:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673984030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SaoPtBG814dLGHyMXINuN35PchsE3987LhkDMQdYqfk=;
        b=Vr2UhBZsUGkKbNXS/jDn0ZVIJmcIniTQhrzT7viVie6PQhql/njw1NkBJOt2nwrwXGGppM
        mjrWb48c/sZyGp3yDO8smR6xsliRdG3KJIKV4dfSNAQ8v9B4VNiillQecPlCMDO2GL3+z8
        /Gc0KwNMmTFlpauvQWL4FoMaYHT7ls8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-tGLWhuguNquX2AdcLvJtHw-1; Tue, 17 Jan 2023 14:33:49 -0500
X-MC-Unique: tGLWhuguNquX2AdcLvJtHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A78283C14858;
        Tue, 17 Jan 2023 19:33:48 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF35640C2064;
        Tue, 17 Jan 2023 19:33:46 +0000 (UTC)
Date:   Tue, 17 Jan 2023 14:33:44 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v5 2/3] fanotify: define struct members to hold response
 decision context
Message-ID: <Y8b4GHkrw2spVwUX@madcap2.tricolour.ca>
References: <cover.1670606054.git.rgb@redhat.com>
 <45da8423b9b1e8fc7abd68cd2269acff8cf9022a.1670606054.git.rgb@redhat.com>
 <20221216164342.ojcbdifdmafq5njw@quack3>
 <Y6TCWe4/nR957pFh@madcap2.tricolour.ca>
 <20230103124201.iopasddbtb6vi362@quack3>
 <Y8W2tcXFoUajzojc@madcap2.tricolour.ca>
 <20230117082723.7g3ig6ernoslt7ub@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117082723.7g3ig6ernoslt7ub@quack3>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-01-17 09:27, Jan Kara wrote:
> On Mon 16-01-23 15:42:29, Richard Guy Briggs wrote:
> > On 2023-01-03 13:42, Jan Kara wrote:
> > > On Thu 22-12-22 15:47:21, Richard Guy Briggs wrote:
> > > > > > +
> > > > > > +	if (info_len != sizeof(*friar))
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	if (copy_from_user(friar, info, sizeof(*friar)))
> > > > > > +		return -EFAULT;
> > > > > > +
> > > > > > +	if (friar->hdr.type != FAN_RESPONSE_INFO_AUDIT_RULE)
> > > > > > +		return -EINVAL;
> > > > > > +	if (friar->hdr.pad != 0)
> > > > > > +		return -EINVAL;
> > > > > > +	if (friar->hdr.len != sizeof(*friar))
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	return info_len;
> > > > > > +}
> > > > > > +
> > > > > 
> > > > > ...
> > > > > 
> > > > > > @@ -327,10 +359,18 @@ static int process_access_response(struct fsnotify_group *group,
> > > > > >  		return -EINVAL;
> > > > > >  	}
> > > > > >  
> > > > > > -	if (fd < 0)
> > > > > > +	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
> > > > > >  		return -EINVAL;
> > > > > >  
> > > > > > -	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
> > > > > > +	if (response & FAN_INFO) {
> > > > > > +		ret = process_access_response_info(fd, info, info_len, &friar);
> > > > > > +		if (ret < 0)
> > > > > > +			return ret;
> > > > > > +	} else {
> > > > > > +		ret = 0;
> > > > > > +	}
> > > > > > +
> > > > > > +	if (fd < 0)
> > > > > >  		return -EINVAL;
> > > > > 
> > > > > And here I'd do:
> > > > > 
> > > > > 	if (fd == FAN_NOFD)
> > > > > 		return 0;
> > > > > 	if (fd < 0)
> > > > > 		return -EINVAL;
> > > > > 
> > > > > As we talked in previous revisions we'd specialcase FAN_NOFD to just verify
> > > > > extra info is understood by the kernel so that application writing fanotify
> > > > > responses has a way to check which information it can provide to the
> > > > > kernel.
> > > > 
> > > > The reason for including it in process_access_response_info() is to make
> > > > sure that it is included in the FAN_INFO case to detect this extension.
> > > > If it were included here
> > > 
> > > I see what you're getting at now. So the condition
> > > 
> > >  	if (fd == FAN_NOFD)
> > >  		return 0;
> > > 
> > > needs to be moved into 
> > > 
> > > 	if (response & FAN_INFO)
> > > 
> > > branch after process_access_response_info(). I still prefer to keep it
> > > outside of the process_access_response_info() function itself as it looks
> > > more logical to me. Does it address your concerns?
> > 
> > Ok.  Note that this does not return zero to userspace, since this
> > function's return value is added to the size of the struct
> > fanotify_response when there is no error.
> 
> Right, good point. 0 is not a good return value in this case.
> 
> > For that reason, I think it makes more sense to return -ENOENT, or some
> > other unused error code that fits, unless you think it is acceptable to
> > return sizeof(struct fanotify_response) when FAN_INFO is set to indicate
> > this.
> 
> Yeah, my intention was to indicate "success" to userspace so I'd like to
> return whatever we return for the case when struct fanotify_response is
> accepted for a normal file descriptor - looks like info_len is the right
> value. Thanks!

Ok, I hadn't thought of that.  So, to confirm, when FAN_INFO is set, if
FAN_NOFD is also set, return info_len from process_access_response() and
then immediately return sizeof(struct fanotify_response) plus info_len
to userspace without issuing an audit record should indicate support for
FAN_INFO and the specific info type supplied.

Thanks for helping work through this.

> 								Honza
> -- 
> Jan Kara <jack@suse.com>

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

