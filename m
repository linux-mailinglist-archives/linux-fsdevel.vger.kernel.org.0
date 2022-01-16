Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3832848FC1F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jan 2022 11:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiAPKOO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 05:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiAPKON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 05:14:13 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CDDC061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jan 2022 02:14:13 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id w9so17755699iol.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jan 2022 02:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lSY0/wEV3QNqe6WzJgUaf0aS6E8OCFSS9u7DD4iDCMQ=;
        b=Ohv6WX58H9nZTvkpYJs3p+rf4LyEFp7szc2mQOuR83fe5U7Dntt00Fsk6jKrjyD1b3
         04N6FkySLikxROHbHR7XRa9ogi4zVdthLmqNrf400+YogEyZ84G/O/d2ae5och2ULvZw
         4iiQh6xaajGBy235sQUM1zemrpsSvwXrnSZ2RVY5dfDak+ZxC7E+Ze7khFxjmPIJIdEH
         13cbdwFUMpC5tj0Vx9IuxSBRBsKupsNZJbNf2aj6dVHDT92oUuol4+ghH4pzq1/ZyDt5
         kzR+jaS+yUb8tQnHbq9029VbXL6fUdIwA5B/uokhiETRhh4Lz5qWHWMHQnpu2t/FJ2x+
         NVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSY0/wEV3QNqe6WzJgUaf0aS6E8OCFSS9u7DD4iDCMQ=;
        b=W7StCdJ6sVpJUwBx+iPOaii7M3UnIxuHcgnhIY9dQdChULpS6/qB17u0OfRXtt7QRB
         FECu6hNATMh8WlqzJ7LiNUjJQAYeJTr0zvWRDSXg3LFv4dGc5SBezqjMKimj6ZASYHBa
         ehptDZAX8dY5Rw6uB2cPKjO6YDOc4t/iyt09ipqIcMGB1PvCBZCZsfl3waWrg27zBdhC
         yIyEg9ffCC/UJf1tteS1C8n1Nygwu3YalwHNGuJwN+Ztju1hDkPFus+k5uohDPfAEqDo
         zKNYGoMG0nKbTvP93Fbjdul4YI5jp6qy77m6sg4EHuoIdb7MQpqlOb9MOKvxNSu4Cw+0
         26BA==
X-Gm-Message-State: AOAM532U5Qe1rB2NwuVkfHvvNIw3Yt55rgqkhOSrx2cO8k8UXsKhrryl
        Tb/AJ4hmCO/KCZV240+rv3Qcv9AChnT8WaFBCpc=
X-Google-Smtp-Source: ABdhPJx9JFYFvCm5Pc3hIBb/kdTmlV+zmp2Rj9LyB+ZwojrT+xMVMpMUXh19cyVqNE0YdBJaOplkvuuenaprWvd4TfU=
X-Received: by 2002:a02:a99d:: with SMTP id q29mr7308587jam.188.1642328052750;
 Sun, 16 Jan 2022 02:14:12 -0800 (PST)
MIME-Version: 1.0
References: <YeI7duagtzCtKMbM@visor> <CAOQ4uxjiFewan=kxBKRHr0FOmN2AJ-WKH3DT2-7kzMoBMNVWJA@mail.gmail.com>
 <YeNyzoDM5hP5LtGW@visor>
In-Reply-To: <YeNyzoDM5hP5LtGW@visor>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 16 Jan 2022 12:14:01 +0200
Message-ID: <CAOQ4uxhaSh4cUMENkaDJij4t2M9zMU9nCT4S8j+z+p-7h6aDnQ@mail.gmail.com>
Subject: Re: Potential regression after fsnotify_nameremove() rework in 5.3
To:     Ivan Delalande <colona@arista.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: multipart/mixed; boundary="0000000000003077da05d5b04cbc"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000003077da05d5b04cbc
Content-Type: text/plain; charset="UTF-8"

On Sun, Jan 16, 2022 at 3:20 AM Ivan Delalande <colona@arista.com> wrote:
>
> On Sat, Jan 15, 2022 at 09:50:20PM +0200, Amir Goldstein wrote:
> > On Sat, Jan 15, 2022 at 5:11 AM Ivan Delalande <colona@arista.com> wrote:
> >> Sorry to bring this up so late but we might have found a regression
> >> introduced by your "Sort out fsnotify_nameremove() mess" patch series
> >> merged in 5.3 (116b9731ad76..7377f5bec133), and that can still be
> >> reproduced on v5.16.
> >>
> >> Some of our processes use inotify to watch for IN_DELETE events (for
> >> files on tmpfs mostly), and relied on the fact that once such events are
> >> received, the files they refer to have actually been unlinked and can't
> >> be open/read. So if and once open() succeeds then it is a new version of
> >> the file that has been recreated with new content.
> >>
> >> This was true and working reliably before 5.3, but changed after
> >> 49246466a989 ("fsnotify: move fsnotify_nameremove() hook out of
> >> d_delete()") specifically. There is now a time window where a process
> >> receiving one of those IN_DELETE events may still be able to open the
> >> file and read its old content before it's really unlinked from the FS.
> >
> > This is a bit surprising to me.
> > Do you have a reproducer?
>
> Yeah, I was using the following one to bisect this. It will print a
> message every time it succeeds to read the file after receiving a
> IN_DELETE event when run with something like `mkdir /tmp/foo;
> ./indelchurn /tmp/foo`. It seems to hit pretty frequently and reliably
> on various systems after 5.3, even for different #define-parameters.
>

I see yes, it's a race between fsnotify_unlink() and d_delete()
fsnotify_unlink() in explicitly required to be called before d_delete(), so
it has the d_inode information and that leaves a windows for opening
the file from cached dentry before d_delete().

I would rather that we try to address this not as a regression until
there is proof of more users that expect the behavior you mentioned.
I would like to provide you an API to opt-in for this behavior, because
fixing it for everyone may cause other workloads to break.

Please test the attached patch on top of v5.16 and use
IN_DELETE|IN_EXCL_UNLINK as the watch mask for testing.

I am assuming that it would be possible for you to modify the application
and add the IN_EXCL_UNLINK flag and that your application does not
care about getting IN_OPEN events on unlinked files?

My patch overloads the existing flag IN_EXCL_UNLINK with a new
meaning. It's a bit of a hack and we can use some other flag if we need to
but it actually makes some sense that an application that does not care for
events on d_unlinked() files will be guaranteed to not get those events
after getting an IN_DELETE event. It is another form of the race that you
described.

Will that solution work out for you?

> >> I'm not very familiar with the VFS and fsnotify internals, would you
> >> consider this a regression, or was there never any intentional guarantee
> >> for that behavior and it's best we work around this change in userspace?
> >
> > It may be a regression if applications depend on behavior that changed,
> > but if are open for changes in your application please describe in more details
> > what it tries to accomplish using IN_DELETE and the ekernel your application
> > is running on and then I may be able to recommend a more reliable method.
>
> I can discuss it with our team and get more details on this but it may
> be pretty complicated and costly to change. My understanding is that
> these watched files are used as ID/version references for in-memory
> objects shared between multiple processes to synchronize state, and
> resynchronize when there are crashes or restarts. So they can be
> recreated in place with the same or a different content, and so their
> inode number or mtime etc. may not be useable as additonnal check.
>
> I think we can also have a very large number of these objects and files
> on some configurations, so waiting to see if we have a following
> IN_CREATE, or adding more checks/synchronization logic will probably
> have a significant impact at scale.
>
> And we're targeting 5.10 and building it with our own config.
>

I am not convinced that this is needed as a regression fix for stable
kernels, but since you are building your own kernel I can help you do the
backport - attached *untested* patch for v5.10 that also backport of
"fsnotify: pass dentry instead of inode data".

Thanks,
Amir.

--0000000000003077da05d5b04cbc
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="inotify-optionally-invalidate-dcache-before-IN_DELETE-5.10.patch"
Content-Disposition: attachment; 
	filename="inotify-optionally-invalidate-dcache-before-IN_DELETE-5.10.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kyh3dn511>
X-Attachment-Id: f_kyh3dn511

RnJvbSA3M2MxMzdkNmE0Y2FiNDQ1ZGVjNzZjNzMxYjJjNzYzZDQ1YWYwNjhlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUaHUsIDQgRmViIDIwMjEgMDk6MTE6MTEgKzAyMDAKU3ViamVjdDogW1BBVENIXSBpbm90
aWZ5OiBvcHRpb25hbGx5IGludmFsaWRhdGUgZGNhY2hlIGJlZm9yZSBJTl9ERUxFVEUgZXZlbnQK
CkRlZmluZSBhIG5ldyBkYXRhIHR5cGUgdG8gcGFzcyBmb3IgZXZlbnQgLSBGU05PVElGWV9FVkVO
VF9ERU5UUlkuClVzZSBpdCB0byBwYXNzIHRoZSBkZW50cnkgaW5zdGVhZCBvZiBkX2lub2RlLCB0
byBhbGxvdyBkX2Ryb3AoKQpiZWZvcmUgSU5fREVMRVRFIGV2ZW50LgoKU2lnbmVkLW9mZi1ieTog
QW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4KLS0tCiBmcy9ub3RpZnkvZnNub3Rp
ZnkuYyAgICAgICAgICAgICB8ICAyICsrCiBpbmNsdWRlL2xpbnV4L2Zzbm90aWZ5LmggICAgICAg
ICB8ICA0ICsrLS0KIGluY2x1ZGUvbGludXgvZnNub3RpZnlfYmFja2VuZC5oIHwgMTYgKysrKysr
KysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2ZzL25vdGlmeS9mc25vdGlmeS5jIGIvZnMvbm90aWZ5L2Zzbm90
aWZ5LmMKaW5kZXggOGQzYWQ1ZWYyOTI1Li41NWZiOTZjNDQ0NDkgMTAwNjQ0Ci0tLSBhL2ZzL25v
dGlmeS9mc25vdGlmeS5jCisrKyBiL2ZzL25vdGlmeS9mc25vdGlmeS5jCkBAIC0yNjAsNiArMjYw
LDggQEAgc3RhdGljIGludCBmc25vdGlmeV9oYW5kbGVfZXZlbnQoc3RydWN0IGZzbm90aWZ5X2dy
b3VwICpncm91cCwgX191MzIgbWFzaywKIAkJY2hpbGRfbWFyayA9IE5VTEw7CiAJCWRpciA9IE5V
TEw7CiAJCW5hbWUgPSBOVUxMOworCX0gZWxzZSBpZiAoaW5vZGVfbWFyay0+bWFzayAmIEZTX0VY
Q0xfVU5MSU5LICYmIG1hc2sgJiBGU19ERUxFVEUpIHsKKwkJZF9kcm9wKGZzbm90aWZ5X2RhdGFf
ZGVudHJ5KGRhdGEsIGRhdGFfdHlwZSkpOwogCX0KIAogCXJldCA9IG9wcy0+aGFuZGxlX2lub2Rl
X2V2ZW50KGlub2RlX21hcmssIG1hc2ssIGlub2RlLCBkaXIsIG5hbWUpOwpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9mc25vdGlmeS5oIGIvaW5jbHVkZS9saW51eC9mc25vdGlmeS5oCmluZGV4
IGY4YWNkZGNmNTRmYi4uYWEzNWYyNjFjYzNkIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2Zz
bm90aWZ5LmgKKysrIGIvaW5jbHVkZS9saW51eC9mc25vdGlmeS5oCkBAIC0zNiw3ICszNiw3IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBmc25vdGlmeV9uYW1lKHN0cnVjdCBpbm9kZSAqZGlyLCBfX3Uz
MiBtYXNrLAogc3RhdGljIGlubGluZSB2b2lkIGZzbm90aWZ5X2RpcmVudChzdHJ1Y3QgaW5vZGUg
KmRpciwgc3RydWN0IGRlbnRyeSAqZGVudHJ5LAogCQkJCSAgIF9fdTMyIG1hc2spCiB7Ci0JZnNu
b3RpZnlfbmFtZShkaXIsIG1hc2ssIGRfaW5vZGUoZGVudHJ5KSwgJmRlbnRyeS0+ZF9uYW1lLCAw
KTsKKwlmc25vdGlmeShtYXNrLCBkZW50cnksIEZTTk9USUZZX0VWRU5UX0RFTlRSWSwgZGlyLCAm
ZGVudHJ5LT5kX25hbWUsIE5VTEwsIDApOwogfQogCiBzdGF0aWMgaW5saW5lIHZvaWQgZnNub3Rp
ZnlfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSwgX191MzIgbWFzaykKQEAgLTc3LDcgKzc3LDcg
QEAgc3RhdGljIGlubGluZSBpbnQgZnNub3RpZnlfcGFyZW50KHN0cnVjdCBkZW50cnkgKmRlbnRy
eSwgX191MzIgbWFzaywKICAqLwogc3RhdGljIGlubGluZSB2b2lkIGZzbm90aWZ5X2RlbnRyeShz
dHJ1Y3QgZGVudHJ5ICpkZW50cnksIF9fdTMyIG1hc2spCiB7Ci0JZnNub3RpZnlfcGFyZW50KGRl
bnRyeSwgbWFzaywgZF9pbm9kZShkZW50cnkpLCBGU05PVElGWV9FVkVOVF9JTk9ERSk7CisJZnNu
b3RpZnlfcGFyZW50KGRlbnRyeSwgbWFzaywgZGVudHJ5LCBGU05PVElGWV9FVkVOVF9ERU5UUlkp
OwogfQogCiBzdGF0aWMgaW5saW5lIGludCBmc25vdGlmeV9maWxlKHN0cnVjdCBmaWxlICpmaWxl
LCBfX3UzMiBtYXNrKQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mc25vdGlmeV9iYWNrZW5k
LmggYi9pbmNsdWRlL2xpbnV4L2Zzbm90aWZ5X2JhY2tlbmQuaAppbmRleCBmODUyOWEzYTI5MjMu
LmM2N2QwZDc0MjU0ZSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9mc25vdGlmeV9iYWNrZW5k
LmgKKysrIGIvaW5jbHVkZS9saW51eC9mc25vdGlmeV9iYWNrZW5kLmgKQEAgLTI1MCw2ICsyNTAs
NyBAQCBlbnVtIGZzbm90aWZ5X2RhdGFfdHlwZSB7CiAJRlNOT1RJRllfRVZFTlRfTk9ORSwKIAlG
U05PVElGWV9FVkVOVF9QQVRILAogCUZTTk9USUZZX0VWRU5UX0lOT0RFLAorCUZTTk9USUZZX0VW
RU5UX0RFTlRSWSwKIH07CiAKIHN0YXRpYyBpbmxpbmUgc3RydWN0IGlub2RlICpmc25vdGlmeV9k
YXRhX2lub2RlKGNvbnN0IHZvaWQgKmRhdGEsIGludCBkYXRhX3R5cGUpCkBAIC0yNTcsNiArMjU4
LDggQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgaW5vZGUgKmZzbm90aWZ5X2RhdGFfaW5vZGUoY29u
c3Qgdm9pZCAqZGF0YSwgaW50IGRhdGFfdHlwZSkKIAlzd2l0Y2ggKGRhdGFfdHlwZSkgewogCWNh
c2UgRlNOT1RJRllfRVZFTlRfSU5PREU6CiAJCXJldHVybiAoc3RydWN0IGlub2RlICopZGF0YTsK
KwljYXNlIEZTTk9USUZZX0VWRU5UX0RFTlRSWToKKwkJcmV0dXJuIGRfaW5vZGUoZGF0YSk7CiAJ
Y2FzZSBGU05PVElGWV9FVkVOVF9QQVRIOgogCQlyZXR1cm4gZF9pbm9kZSgoKGNvbnN0IHN0cnVj
dCBwYXRoICopZGF0YSktPmRlbnRyeSk7CiAJZGVmYXVsdDoKQEAgLTI2NCw2ICsyNjcsMTkgQEAg
c3RhdGljIGlubGluZSBzdHJ1Y3QgaW5vZGUgKmZzbm90aWZ5X2RhdGFfaW5vZGUoY29uc3Qgdm9p
ZCAqZGF0YSwgaW50IGRhdGFfdHlwZSkKIAl9CiB9CiAKK3N0YXRpYyBpbmxpbmUgc3RydWN0IGRl
bnRyeSAqZnNub3RpZnlfZGF0YV9kZW50cnkoY29uc3Qgdm9pZCAqZGF0YSwgaW50IGRhdGFfdHlw
ZSkKK3sKKwlzd2l0Y2ggKGRhdGFfdHlwZSkgeworCWNhc2UgRlNOT1RJRllfRVZFTlRfREVOVFJZ
OgorCQkvKiBOb24gY29uc3QgaXMgbmVlZGVkIGZvciBkZ2V0KCkgKi8KKwkJcmV0dXJuIChzdHJ1
Y3QgZGVudHJ5ICopZGF0YTsKKwljYXNlIEZTTk9USUZZX0VWRU5UX1BBVEg6CisJCXJldHVybiAo
KGNvbnN0IHN0cnVjdCBwYXRoICopZGF0YSktPmRlbnRyeTsKKwlkZWZhdWx0OgorCQlyZXR1cm4g
TlVMTDsKKwl9Cit9CisKIHN0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IHBhdGggKmZzbm90aWZ5
X2RhdGFfcGF0aChjb25zdCB2b2lkICpkYXRhLAogCQkJCQkJICAgIGludCBkYXRhX3R5cGUpCiB7
Ci0tIAoyLjE2LjUKCg==
--0000000000003077da05d5b04cbc
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="inotify-optionally-invalidate-dcache-before-IN_DELETE-5.16.patch"
Content-Disposition: attachment; 
	filename="inotify-optionally-invalidate-dcache-before-IN_DELETE-5.16.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kyh3f4ec1>
X-Attachment-Id: f_kyh3f4ec1

RnJvbSBkNGQ5MWQ1YjQ2YzEzZGVmNDhiMzZiYjc3MzRiNWZjYThlMWMyMTI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBTdW4sIDE2IEphbiAyMDIyIDEwOjExOjQ1ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gaW5v
dGlmeTogb3B0aW9uYWxseSBpbnZhbGlkYXRlIGRjYWNoZSBiZWZvcmUgSU5fREVMRVRFIGV2ZW50
CgpBcHBhcmVudGx5LCB0aGVyZSBhcmUgc29tZSBhcHBsaWNhdGlvbnMgdGhhdCB1c2UgSU5fREVM
RVRFIGV2ZW50IGFzIGFuCmludmFsaWRhdGlvbiBtZWNoYW5pc20gYW5kIGV4cGVjdCB0aGF0IGlm
IHRoZXkgdHJ5IHRvIG9wZW4gYSBmaWxlIHdpdGgKdGhlIG5hbWUgcmVwb3J0ZWQgd2l0aCB0aGUg
ZGVsZXRlIGV2ZW50LCB0aGF0IGl0IHNob3VsZCBub3QgY29udGFpbiB0aGUKY29udGVudCBvZiB0
aGUgZGVsZXRlZCBmaWxlLgoKQ29tbWl0IDQ5MjQ2NDY2YTk4OSAoImZzbm90aWZ5OiBtb3ZlIGZz
bm90aWZ5X25hbWVyZW1vdmUoKSBob29rIG91dCBvZgpkX2RlbGV0ZSgpIikgbW92ZWQgdGhlIGZz
bm90aWZ5IGRlbGV0ZSBob29rIGJlZm9yZSBkX2RlbGV0ZSgpCmludGVudGlvbmFsbHksIHNvIGZz
bm90aWZ5IHdpbGwgaGF2ZSBhY2Nlc3MgdG8gYSBwb3NpdGl2ZSBkZW50cnkuCgpUaGlzIGFsbG93
ZWQgYSByYWNlIHdoZXJlIG9wZW5pbmcgdGhlIGRlbGV0ZWQgZmlsZSB2aWEgY2FjaGVkIGRlbnRy
eQppcyBub3cgcG9zc2libGUgYWZ0ZXIgcmVjZWl2aW5nIHRoZSBJTl9ERUxFVEUgZXZlbnQuCgpJ
biBvcmRlciB0byBwcm92aWRlIHRoZSAiaW52YWxpZGF0ZSIgZnVuY3Rpb25hbGl0eSB3aXRob3V0
IGNoYW5naW5nCmJlaGF2aW9yIGZvciBvdGhlciB3b3JrbG9hZCwgb3ZlcmxvYWQgdGhlIG9yaWdp
bmFsIG1lYW5pbmcgb2YgdGhlCklOX0VYQ0xfVU5MSU5LIGZsYWcgd2l0aCB0aGUgYWRkaXRpb25h
bCBtZWFuaW5nIHRoYXQgdGhlIGZpbGUgc2hvdWxkCm5vdCBiZSBhY2Nlc3NlZCB2aWEgdGhhdCBu
YW1lIGFmdGVyIHJlY2VpdmluZyBhbiBJTl9ERUxFVEUgZXZlbnQgYW5kCmRyb3AgZGVudHJ5IGZy
b20gY2FjaGUgYmVmb3JlIElOX0RFTEVURSBpcyByZXBvcnRlZC4KClRoaXMgd2lsbCBhbGxvdyBh
cHBsaWNhdGlvbnMgdG8gb3B0LWluIGZvciB0aGUgImludmFsaWRhdGUiIGJlaGF2aW9yLgoKTGlu
azogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZnNkZXZlbC9ZZU55em9ETTVoUDVMdEdX
QHZpc29yLwpTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29t
PgotLS0KIGZzL25vdGlmeS9mc25vdGlmeS5jIHwgMTggKysrKysrKysrKysrKysrLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9mcy9ub3RpZnkvZnNub3RpZnkuYyBiL2ZzL25vdGlmeS9mc25vdGlmeS5jCmluZGV4IDQwMzRj
YTU2NmY5NS4uODYzMzcyMjBmMjVjIDEwMDY0NAotLS0gYS9mcy9ub3RpZnkvZnNub3RpZnkuYwor
KysgYi9mcy9ub3RpZnkvZnNub3RpZnkuYwpAQCAtMjU1LDkgKzI1NSwyMSBAQCBzdGF0aWMgaW50
IGZzbm90aWZ5X2hhbmRsZV9pbm9kZV9ldmVudChzdHJ1Y3QgZnNub3RpZnlfZ3JvdXAgKmdyb3Vw
LAogCWlmIChXQVJOX09OX09OQ0UoIWlub2RlICYmICFkaXIpKQogCQlyZXR1cm4gMDsKIAotCWlm
ICgoaW5vZGVfbWFyay0+bWFzayAmIEZTX0VYQ0xfVU5MSU5LKSAmJgotCSAgICBwYXRoICYmIGRf
dW5saW5rZWQocGF0aC0+ZGVudHJ5KSkKLQkJcmV0dXJuIDA7CisJaWYgKGlub2RlX21hcmstPm1h
c2sgJiBGU19FWENMX1VOTElOSykgeworCQlpZiAocGF0aCAmJiBkX3VubGlua2VkKHBhdGgtPmRl
bnRyeSkpCisJCQlyZXR1cm4gMDsKKworCQkvKgorCQkgKiBGaWxlIG1heSBiZSB1bmxpbmtlZCBp
biBmaWxlc3lzdGVtLCBidXQgc3RpbGwgYWNjZXNpYmxlIHZpYQorCQkgKiBkY2FjaGUsIHNvIHVz
ZXIgbWF5IGJlIGFibGUgdG8gb2JzZXJ2ZSBhbmQgb3BlbiB0aGUgZmlsZQorCQkgKiBhZnRlciBy
ZWNlaXZpbmcgYW4gSU5fREVMRVRFIGV2ZW50LgorCQkgKiBPdmVybG9hZCB0aGUgb3JpZ2luYWwg
bWVhbmluZyBvZiB0aGUgSU5fRVhDTF9VTkxJTksgZmxhZworCQkgKiB3aXRoIHRoZSBhZGRpdGlv
bmFsIG1lYW5pbmcgdGhhdCB0aGUgZmlsZSBjYW5ub3QgYmUgYWNjZXNzZWQKKwkJICogdmlhIHRo
YXQgbmFtZSBhZnRlciByZWNlaXZpbmcgYW4gSU5fREVMRVRFIGV2ZW50LgorCQkgKi8KKwkJaWYg
KG1hc2sgJiBGU19ERUxFVEUpCisJCQlkX2Ryb3AoZnNub3RpZnlfZGF0YV9kZW50cnkoZGF0YSwg
ZGF0YV90eXBlKSk7CisJfQogCiAJLyogQ2hlY2sgaW50ZXJlc3Qgb2YgdGhpcyBtYXJrIGluIGNh
c2UgZXZlbnQgd2FzIHNlbnQgd2l0aCB0d28gbWFya3MgKi8KIAlpZiAoIShtYXNrICYgaW5vZGVf
bWFyay0+bWFzayAmIEFMTF9GU05PVElGWV9FVkVOVFMpKQotLSAKMi4zNC4xCgo=
--0000000000003077da05d5b04cbc--
