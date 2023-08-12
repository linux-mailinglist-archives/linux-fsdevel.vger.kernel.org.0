Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF336779E68
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 11:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjHLJFn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Aug 2023 05:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjHLJFm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Aug 2023 05:05:42 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1DA10DE;
        Sat, 12 Aug 2023 02:05:45 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-447d394d1ebso2494670137.1;
        Sat, 12 Aug 2023 02:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691831144; x=1692435944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ootNDDcWDg7u7h0P5IZQvhFRhWfwQhZIpwqSVndwKtY=;
        b=p3MnB1vmkuFkCRXQUyPTzFlLnWjxzioCkZ0WA0nk61GNrE5vj95vBGVFHw+y7UbZWI
         oSKF2mICVjy98MVWwbmfnlpMir5i1RiCU5tVUtGUAI9u02mc+olSyJ9EDVtsj4w7+Z5d
         RfLOo64aepaU/9ibCsXaz6A/vIH+0TE7QRtqAECOzEEySPjT8CxvXNNUIJicentg6GIO
         BN/lhudnBa+epXXTJiCiMnfn+wh1PrgYXSUj9IcL0JNH1xOgN8RLroMWyhK/IqX+UbWE
         XwC8l0rAX3+g5crdC+9hfr/JXp3PvrmMvidgCbETFsR+me8CBjMZ92wYqkazCD6KLSl8
         51Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691831144; x=1692435944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ootNDDcWDg7u7h0P5IZQvhFRhWfwQhZIpwqSVndwKtY=;
        b=IL78mLhl9UE5DVh9pS94N1w7K+bl75PmrbvkEsnBBPx5INUB/w6ax2d8ger+UG7ie1
         lKnxdI0PobjlaXVvUKfEQ/jF1rq5RNDSyJuY99sSABgurQ5QLlbQX0Bo7R9MEHNe+JIo
         nuar4xKY78nFP56qj6f0oS0WWm5zLIXg++g49AIzNJFNyXregmpcaUW9VvvC2ysiHNyj
         0mXQIMAH3JhmjPaV40AuBJUelWvJzBOtHENWnAtIgkey8DEDtPVnU23SjClrKLFOVvgP
         wOybbA/PTggWBcxB6BI3eNsa3Oc7WJ8b6AN4DQPoO8QmwB1sdjQh0OPXoWz27xQDicB5
         c8ag==
X-Gm-Message-State: AOJu0Yz9yOeblzOycZ+tycbZWsasHA7mJLowUIXc3xbzFPKGswA3s8U4
        pmInlT+89nIIWItX4l1uvbtLOGcZU4mJ9bwSQX/bkxqDfxM=
X-Google-Smtp-Source: AGHT+IEhngOewU82rbL/EXnFRAzyqLuEhLcvU2IISBQ34TYC2iHCHLbaOA2+aPRRW0Rm9kqZJzrmwftzkjvdvnkTbfM=
X-Received: by 2002:a05:6102:3b16:b0:439:3e26:990e with SMTP id
 x22-20020a0561023b1600b004393e26990emr4900072vsu.6.1691831144595; Sat, 12 Aug
 2023 02:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
 <169091990172.112530.13872332887678504055.stgit@frogsfrogsfrogs>
 <ZNaMhgqbLJGdateQ@bombadil.infradead.org> <20230812000456.GA2375177@frogsfrogsfrogs>
In-Reply-To: <20230812000456.GA2375177@frogsfrogsfrogs>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 12 Aug 2023 12:05:33 +0300
Message-ID: <CAOQ4uxibnPqE5qG9R53JyaMY1bd6j9OH0pq2eQxYpxDwf3xnGw@mail.gmail.com>
Subject: Re: [PATCH 1/3] docs: add maintainer entry profile for XFS
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, corbet@lwn.net,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, cem@kernel.org, sandeen@sandeen.net,
        chandan.babu@oracle.com, leah.rumancik@gmail.com, zlang@kernel.org,
        fstests@vger.kernel.org, willy@infradead.org,
        shirley.ma@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 12, 2023 at 3:04=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Fri, Aug 11, 2023 at 12:31:18PM -0700, Luis Chamberlain wrote:
> > On Tue, Aug 01, 2023 at 12:58:21PM -0700, Darrick J. Wong wrote:
> > > +Roles
> > > +-----
> > > +There are seven key roles in the XFS project.
> > > +- **Testing Lead**: This person is responsible for setting the test
> > > +  coverage goals of the project, negotiating with developers to deci=
de
> > > +  on new tests for new features, and making sure that developers and
> > > +  release managers execute on the testing.
> > > +
> > > +  The testing lead should identify themselves with an ``M:`` entry i=
n
> > > +  the XFS section of the fstests MAINTAINERS file.
> >
> > I think breaking responsibility down is very sensible, and should hopef=
ully
> > allow you to not burn out. Given I realize how difficult it is to do al=
l
> > the tasks, and since I'm already doing quite a bit of testing of XFS
> > on linux-next I can volunteer to help with this task of testing lead
> > if folks also think it may be useful to the community.
> >
> > The only thing is I'd like to also ask if Amir would join me on the
> > role to avoid conflicts of interest when and if it comes down to testin=
g
> > features I'm involved in somehow.
>
> Good question.  Amir?
>

I am more than happy to help, but I don't believe that I currently perform
or that I will have time to perform the official duties of **Testing
Lead** role.

I fully support the nomination of Luis and I think the **Release Manager**
should be able to resolve any conflict of interests of the **Testing Lead**
as feature developer should any such conflicts arise :)

Thanks,
Amir.
