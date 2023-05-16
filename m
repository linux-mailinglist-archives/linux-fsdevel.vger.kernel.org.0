Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154677042A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 03:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245312AbjEPBJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 21:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242991AbjEPBJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 21:09:45 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7429055BD;
        Mon, 15 May 2023 18:09:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f26b109611so1125962e87.1;
        Mon, 15 May 2023 18:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1684199382; x=1686791382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzjVa+2yECYwamFWHBiBVCQ8GdRm39LxdVUQf9m8hdc=;
        b=NayRVEIV8d65B1nnZWIvK92bTlj4i9xKwaq8zRuXrE0RRfDbmNzWcJVV8VO4Uifqz6
         rJ/cu1sNXJWFC23iAIpmN1B7EfgzdMnclHCCD4qsMKDQSdL3Q7xx+2JmwkLawXSSq1C8
         Qvjq75QgAp//DRXkInWGLtum3VRi1vtGcG4T6BgwwBX3mPG6YaHPuWW96NyB6tNk+n0y
         Vr38ZaZLAEByZnGpBITPhCS+Z1rnoHrGkrXlFZqIcIKxIMshy9bmzpI6oiHS6mxFuohv
         wYHo5hPeNKH21HE9QP0eLy7e36snT84Ut0GiTouZ9G2wOlV2O5Alo2W6Ot41lvm9L5RP
         6qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684199382; x=1686791382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzjVa+2yECYwamFWHBiBVCQ8GdRm39LxdVUQf9m8hdc=;
        b=ggssTb+BCkMNOcz49XE49rAUSrT0M40BPQX9NHUqcJl+jSoonkz8cF5IAQpQ/b0Bmr
         ygOXxGSlZzr6kA0b3H6+QQ8qrjyjrW0BQ96a06npU918C7YU/rqMpUuGWzsgcT1/RWBn
         KNbzca/SiTYbe2UXCgtOmJ25nYoWfcqJzAkC41SgVbouJaMjhUtX/aFn5gL8Y3dv0eRv
         x0AP6W8rJtK4IQ4bnCkYKTWNZ0bInqp0B7KZfq9u4X0e/uipCf37O52xsd6hhjTJHwoH
         FxQeiWv1Gl9A+oAp5vEOSl4km+JUsz+dnsUfXxE/JVGMgXTtmLhE4yEmAmcvmDIb/HgX
         ufDQ==
X-Gm-Message-State: AC+VfDzjI323NYQnyZqdRCC5dLbzxce/ZVG0woo/Z1JfN2w6BXFKTsxl
        f1fQym+u/3NHLGNUYe9jrfXmnlpKta6dEHFPdj7N8IzN
X-Google-Smtp-Source: ACHHUZ5R2MQj/XGNj51fHLPcSgZFzJi3SmmtunmKF3yELuguIZeRCQbzYIMlm+odSN0K8JL4iqcDmLjeY2aLqS+zQZ8=
X-Received: by 2002:a2e:a4d3:0:b0:2ad:b513:35a1 with SMTP id
 p19-20020a2ea4d3000000b002adb51335a1mr329549ljm.2.1684199381229; Mon, 15 May
 2023 18:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com>
 <1684110038-11266-5-git-send-email-dai.ngo@oracle.com> <CAN-5tyH0GM8xOnLVDMQMn-tmoE-w_7N9ARmcwHq6ocySeoA1MQ@mail.gmail.com>
 <392379f7-4e28-fae5-a799-00b4e35fe6fd@oracle.com> <5318a050cbe6e89ae0949c654545ae8998ff7795.camel@kernel.org>
 <CAN-5tyFE3=DF+48SBGrC2u3y-MNr+1nM+xFM4CXaYv23AMZvew@mail.gmail.com>
 <30df13a02cbe9d7c72d0518c011e066e563bcbc8.camel@kernel.org>
 <17E187C9-60D6-4882-B928-E7826AA68F45@oracle.com> <927e6aaab9e4c30add761ac6754ba91457c048c7.camel@kernel.org>
 <D970A651-1D60-4019-8E91-A1791D3AAF6F@oracle.com>
In-Reply-To: <D970A651-1D60-4019-8E91-A1791D3AAF6F@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 15 May 2023 21:09:26 -0400
Message-ID: <CAN-5tyE22TR7tg_0Q4NuhdiVfhvXWe-zzdcTaoWwwA8YN61SWQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] NFSD: handle GETATTR conflict with write delegation
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 15, 2023 at 8:06=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On May 15, 2023, at 6:53 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On Mon, 2023-05-15 at 21:37 +0000, Chuck Lever III wrote:
> >>
> >>> On May 15, 2023, at 4:21 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >>>
> >>> On Mon, 2023-05-15 at 16:10 -0400, Olga Kornievskaia wrote:
> >>>> On Mon, May 15, 2023 at 2:58=E2=80=AFPM Jeff Layton <jlayton@kernel.=
org> wrote:
> >>>>>
> >>>>> On Mon, 2023-05-15 at 11:26 -0700, dai.ngo@oracle.com wrote:
> >>>>>> On 5/15/23 11:14 AM, Olga Kornievskaia wrote:
> >>>>>>> On Sun, May 14, 2023 at 8:56=E2=80=AFPM Dai Ngo <dai.ngo@oracle.c=
om> wrote:
> >>>>>>>> If the GETATTR request on a file that has write delegation in ef=
fect
> >>>>>>>> and the request attributes include the change info and size attr=
ibute
> >>>>>>>> then the request is handled as below:
> >>>>>>>>
> >>>>>>>> Server sends CB_GETATTR to client to get the latest change info =
and file
> >>>>>>>> size. If these values are the same as the server's cached values=
 then
> >>>>>>>> the GETATTR proceeds as normal.
> >>>>>>>>
> >>>>>>>> If either the change info or file size is different from the ser=
ver's
> >>>>>>>> cached values, or the file was already marked as modified, then:
> >>>>>>>>
> >>>>>>>>   . update time_modify and time_metadata into file's metadata
> >>>>>>>>     with current time
> >>>>>>>>
> >>>>>>>>   . encode GETATTR as normal except the file size is encoded wit=
h
> >>>>>>>>     the value returned from CB_GETATTR
> >>>>>>>>
> >>>>>>>>   . mark the file as modified
> >>>>>>>>
> >>>>>>>> If the CB_GETATTR fails for any reasons, the delegation is recal=
led
> >>>>>>>> and NFS4ERR_DELAY is returned for the GETATTR.
> >>>>>>> Hi Dai,
> >>>>>>>
> >>>>>>> I'm curious what does the server gain by implementing handling of
> >>>>>>> GETATTR with delegations? As far as I can tell it is not strictly
> >>>>>>> required by the RFC(s). When the file is being written any attemp=
t at
> >>>>>>> querying its attribute is immediately stale.
> >>>>>>
> >>>>>> Yes, you're right that handling of GETATTR with delegations is not
> >>>>>> required by the spec. The only benefit I see is that the server
> >>>>>> provides a more accurate state of the file as whether the file has
> >>>>>> been changed/updated since the client's last GETATTR. This allows
> >>>>>> the app on the client to take appropriate action (whatever that
> >>>>>> might be) when sharing files among multiple clients.
> >>>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>> From RFC 8881 10.4.3:
> >>>>>
> >>>>> "It should be noted that the server is under no obligation to use
> >>>>> CB_GETATTR, and therefore the server MAY simply recall the delegati=
on to
> >>>>> avoid its use."
> >>>>
> >>>> This is a "MAY" which means the server can choose to not to and just
> >>>> return the info it currently has without recalling a delegation.
> >>>>
> >>>>
> >>>
> >>> That's not at all how I read that. To me, it sounds like it's saying
> >>> that the only alternative to implementing CB_GETATTR is to recall the
> >>> delegation. If that's not the case, then we should clarify that in th=
e
> >>> spec.
> >>
> >> The meaning of MAY is spelled out in RFC 2119. MAY does not mean
> >> "the only alternative". I read this statement as alerting client
> >> implementers that a compliant server is permitted to skip
> >> CB_GETATTR, simply by recalling the delegation. Technically
> >> speaking this compliance statement does not otherwise restrict
> >> server behavior, though the author might have had something else
> >> in mind.
> >>
> >> I'm leery of the complexity that CB_GETATTR adds to NFSD and
> >> the protocol. In addition, section 10.4 is riddled with errors,
> >> albeit minor ones; that suggests this part of the protocol is
> >> not well-reviewed.
> >>
> >> It's not apparent how much gain is provided by CB_GETATTR.
> >> IIRC NFSD can recall a delegation on the same nfsd thread as an
> >> incoming request, so the turnaround for a recall from a local
> >> client is going to be quick.
> >>
> >> It would be good to know how many other server implementations
> >> support CB_GETATTR.
> >
> >> I'm rather leaning towards postponing 3/4 and 4/4 and instead
> >> taking a more incremental approach. Let's get the basic Write
> >> delegation support in, and possibly add a counter or two to
> >> find out how often a GETATTR on a write-delegated file results
> >> in a delegation recall.
> >>
> >> We can then take some time to disambiguate the spec language and
> >> look at other implementations to see if this extra protocol is
> >> really of value.
> >>
> >> I think it would be good to understand whether Write delegation
> >> without CB_GETATTR can result in a performance regression (say,
> >> because the server is recalling delegations more often for a
> >> given workload).
> >
> > Ganesha has had write delegation and CB_GETATTR support for years.
>
> Does OnTAP support write delegation? I heard a rumor NetApp
> disabled it because of the volume of customer calls involving
> delegation with the Linux client, but that could be old news.

ONTAP supports delegations (though i'm not sure if the default is on.
So I'm not sure if the current recommendation is not to enable it due
to known issues). ONTAP does not send any CB_GETATTR. Whether or not
it makes it a non-spec compliant I'm not sure as the spec isn't too
clear (at least to me). We as a linux team did raise the issue with
ONTAP about them not implementing CB_GETATTR. But so far no complaints
have been made about lacking CB_GETATTR.

I raised the question because I was really curious what real
usefulness really comes from it? or perhaps what are the expectations
that the server can guarantee or what conclusions can the 2nd client
can make? As I mentioned in my initial posting, the information that
the server (and then the 2nd client) gets is (possibly) stale as soon
as it gets it because the client with delegation keeps writing to the
file after getting the CB_GETATTR. The complexity that's being added
to the server (and to the client) doesn't seem to be worth it.

> How about Solaris? My close contact with the Solaris NFS team
> as the Linux NFS client implementation matured has colored my
> experience with write delegation. It is complex and subtle.
>
>
> > Isn't CB_GETATTR the main benefit of a write delegation in the first
> > place? A write deleg doesn't really give any benefit otherwise, as you
> > can buffer writes anyway without one.
> >
> > AIUI, the point of a write delegation is to allow other clients (and
> > potentially the server) to get up to date information on file sizes and
> > change attr when there is a single, active writer.
>
> The benefits of write delegation depend on the client implementation
> and the workload. A client may use a write delegation to indicate
> that it can handle locking requests for a file locally, for example.

I thought the benefits of delegations have always been the savings
gotten from doing local opens and locking. Open is an expensive server
operation.

Because the (linux) client is flushing the writes exactly the same way
whether or not it's holding a delegation so the server's view is the
same (with or without delegation). Now of course I'm speaking about
the linux client so one can speculate what if there is a client
implementation that uses delegation to do more caching? Sure... But I
still don't really see how the 2nd client can expect to rely/make
critical decisions based on the information it gets from a GETATTR.

> > Without CB_GETATTR, your first stat() against the file will give you
> > fairly up to date info (since you'll have to recall the delegation), bu=
t
> > then you'll be back to the server just reporting the size and change
> > attr that it has at the time.
>
> Which is the current behavior, yes? As long as behavior is not
> regressing, I don't foresee a problem with doing CB_GETATTR in 6.6
> or later.
>
>
> --
> Chuck Lever
>
>
