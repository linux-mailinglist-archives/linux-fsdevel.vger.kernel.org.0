Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86CAB192EC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 17:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCYQ4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 12:56:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38845 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgCYQ4A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:56:00 -0400
Received: by mail-io1-f67.google.com with SMTP id m15so2978985iob.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2020 09:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lMSF7jRqIGmyJHhkA0RkE0voWyheyNp2HZ2xiFdbaKs=;
        b=J1c1wSR38A35JJAmqKfnRUvMmZ+rFsEDCG6hSkyIl+lV8+2mWsfzqCMnyPNobaDyRq
         nfsIBJYCVEXEha7IGkzTyw19wmtvR4mHAP0BHd0Nk+N2FyYL/3Yf0pyoTmAVGRPbyETT
         jD28WDNwF9IwFSz1wnNNgbCe9GqjVERoGfroY0ZJX2IAaNhU/CIV+L5ktd7APzcZ3+TW
         UAoB0dGKc3Mm3PgF6bmdZDeU1Z1TazkaG8ClQvF4BOgXcMfGfKU/tz8f6Km5iODifMQz
         EBLR0hyXToXhV28tVVNwsrb87ObdXZqY7KvCvBzXAp40ffaBdd1f1kxd8tO5ZO3w6c8B
         Q02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMSF7jRqIGmyJHhkA0RkE0voWyheyNp2HZ2xiFdbaKs=;
        b=txSzyfqp2Q7XEr4pVcWnviZctsQLTKzE0O3j4EdZTsoRnNShM3e38QRgGMxXDEUig8
         KlEOjeOVZM+CdSIAdolHECShZgYV1GnyDlgrrOa9XzEtvHoUJ+bEemYJG2r6CX0iq9QB
         H2b/dYRRdsvzXPdT30YrVtWbrnVYwzEcg7fZx4Fw3mbxQvwiqV7DIBBbP1blEdZD70f2
         Y1bTPQPx9ltND/K3x2tWgqijk4BC7fBopFX52Kf5qIOeA/WYuDyH7Tgc4lLlyrgIy4PQ
         LbJXj1d1sZCZJ8Tiv40cOA5q8HpVtqt7dr/86jWui5n5QQTqcj0/cu+L9NWweSuEGfBO
         Pw/Q==
X-Gm-Message-State: ANhLgQ06U9V12ItUcZrz8aTPZYEWsnYzf36qidp0AvdgdtejJo1tjwmQ
        F9nWvCYrqrv7bn67ZuWqc4657NOXDJseYYPQ1+VwZA==
X-Google-Smtp-Source: ADFU+vtEmbqnGQHFjOyxI2k+AYHkeHt7tZkHaaVmmLovWYPY4N+ytgO6AO7J0oAwIgBW4koHBn+853OUNRbZzswesWs=
X-Received: by 2002:a6b:f718:: with SMTP id k24mr3768479iog.186.1585155357939;
 Wed, 25 Mar 2020 09:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200319151022.31456-1-amir73il@gmail.com> <20200325155436.GL28951@quack2.suse.cz>
In-Reply-To: <20200325155436.GL28951@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Mar 2020 18:55:46 +0200
Message-ID: <CAOQ4uxiBxjsyZ0ZR6OH29xCTjBEde9u00LfXu58DX9gYR6cwcw@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] fanotify directory modify event
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000000637d405a1b0be06"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000000637d405a1b0be06
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 25, 2020 at 5:54 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi,
>
> On Thu 19-03-20 17:10:08, Amir Goldstein wrote:
> > Jan,
> >
> > This v3 posting is a trimmed down version of v2 name info patches [1].
> > It includes the prep/fix patches and the patches to add support for
> > the new FAN_DIR_MODIFY event, but leaves out the FAN_REPORT_NAME
> > patches. I will re-post those as a later time.
> >
> > The v3 patches are available on my github branch fanotify_dir_modify [2].
> > Same branch names for LTP tests [3], man page draft [6] and a demo [7].
> > The fanotify_name branches in those github trees include the additional
> > FAN_REPORT_NAME related changes.
> >
> > Main changes since v2:
> > - Split fanotify_path_event fanotify_fid_event and fanotify_name_event
> > - Drop the FAN_REPORT_NAME patches
>
> So I have pushed out the result to my tree (fsnotify branch and also pulled
> it to for_next branch).

Great!

Liked the cleanups.
Suggest to squash the attached simplification to "record name info" patch.
I will start try to get to finalizing man page patch next week.

Thanks,
Amir.

--0000000000000637d405a1b0be06
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fanotify-simplify-record-name-info.patch"
Content-Disposition: attachment; 
	filename="0001-fanotify-simplify-record-name-info.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k87kibk70>
X-Attachment-Id: f_k87kibk70

RnJvbSBkNDJkMzg4ZWQxYTlmOTBhNjIzNTUyZTZmYWJmYTM0MThjZWI0MGFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBXZWQsIDI1IE1hciAyMDIwIDE4OjUwOjE2ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZmFu
b3RpZnk6IHNpbXBsaWZ5IHJlY29yZCBuYW1lIGluZm8KCi0tLQogZnMvbm90aWZ5L2Zhbm90aWZ5
L2Zhbm90aWZ5LmMgfCAyMiArKysrKysrKy0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9ub3RpZnkv
ZmFub3RpZnkvZmFub3RpZnkuYyBiL2ZzL25vdGlmeS9mYW5vdGlmeS9mYW5vdGlmeS5jCmluZGV4
IDdhODg5ZGExZWUxMi4uNGMxYTRlYjU5N2Q1IDEwMDY0NAotLS0gYS9mcy9ub3RpZnkvZmFub3Rp
ZnkvZmFub3RpZnkuYworKysgYi9mcy9ub3RpZnkvZmFub3RpZnkvZmFub3RpZnkuYwpAQCAtMjgy
LDYgKzI4Miw5IEBAIHN0YXRpYyB2b2lkIGZhbm90aWZ5X2VuY29kZV9maChzdHJ1Y3QgZmFub3Rp
ZnlfZmggKmZoLCBzdHJ1Y3QgaW5vZGUgKmlub2RlLAogCXZvaWQgKmJ1ZiA9IGZoLT5idWY7CiAJ
aW50IGVycjsKIAorCWlmICghaW5vZGUpCisJCWdvdG8gb3V0OworCiAJZHdvcmRzID0gMDsKIAll
cnIgPSAtRU5PRU5UOwogCXR5cGUgPSBleHBvcnRmc19lbmNvZGVfaW5vZGVfZmgoaW5vZGUsIE5V
TEwsICZkd29yZHMsIE5VTEwpOwpAQCAtMzE1LDYgKzMxOCw3IEBAIHN0YXRpYyB2b2lkIGZhbm90
aWZ5X2VuY29kZV9maChzdHJ1Y3QgZmFub3RpZnlfZmggKmZoLCBzdHJ1Y3QgaW5vZGUgKmlub2Rl
LAogCQkJICAgIHR5cGUsIGJ5dGVzLCBlcnIpOwogCWtmcmVlKGV4dF9idWYpOwogCSpmYW5vdGlm
eV9maF9leHRfYnVmX3B0cihmaCkgPSBOVUxMOworb3V0OgogCS8qIFJlcG9ydCB0aGUgZXZlbnQg
d2l0aG91dCBhIGZpbGUgaWRlbnRpZmllciBvbiBlbmNvZGUgZXJyb3IgKi8KIAlmaC0+dHlwZSA9
IEZJTEVJRF9JTlZBTElEOwogCWZoLT5sZW4gPSAwOwpAQCAtNDI5LDIyICs0MzMsMTIgQEAgc3Ry
dWN0IGZhbm90aWZ5X2V2ZW50ICpmYW5vdGlmeV9hbGxvY19ldmVudChzdHJ1Y3QgZnNub3RpZnlf
Z3JvdXAgKmdyb3VwLAogCWlmIChmc2lkICYmIGZhbm90aWZ5X2V2ZW50X2ZzaWQoZXZlbnQpKQog
CQkqZmFub3RpZnlfZXZlbnRfZnNpZChldmVudCkgPSAqZnNpZDsKIAotCWlmIChmYW5vdGlmeV9l
dmVudF9vYmplY3RfZmgoZXZlbnQpKSB7Ci0JCXN0cnVjdCBmYW5vdGlmeV9maCAqb2JqX2ZoID0g
ZmFub3RpZnlfZXZlbnRfb2JqZWN0X2ZoKGV2ZW50KTsKKwlpZiAoZmFub3RpZnlfZXZlbnRfb2Jq
ZWN0X2ZoKGV2ZW50KSkKKwkJZmFub3RpZnlfZW5jb2RlX2ZoKGZhbm90aWZ5X2V2ZW50X29iamVj
dF9maChldmVudCksIGlkLCBnZnApOwogCi0JCWlmIChpZCkKLQkJCWZhbm90aWZ5X2VuY29kZV9m
aChvYmpfZmgsIGlkLCBnZnApOwotCQllbHNlCi0JCQlvYmpfZmgtPmxlbiA9IDA7Ci0JfQotCWlm
IChmYW5vdGlmeV9ldmVudF9kaXJfZmgoZXZlbnQpKSB7Ci0JCXN0cnVjdCBmYW5vdGlmeV9maCAq
ZGlyX2ZoID0gZmFub3RpZnlfZXZlbnRfZGlyX2ZoKGV2ZW50KTsKKwlpZiAoZmFub3RpZnlfZXZl
bnRfZGlyX2ZoKGV2ZW50KSkKKwkJZmFub3RpZnlfZW5jb2RlX2ZoKGZhbm90aWZ5X2V2ZW50X2Rp
cl9maChldmVudCksIGlkLCBnZnApOwogCi0JCWlmIChpZCkKLQkJCWZhbm90aWZ5X2VuY29kZV9m
aChkaXJfZmgsIGlkLCBnZnApOwotCQllbHNlCi0JCQlkaXJfZmgtPmxlbiA9IDA7Ci0JfQogCWlm
IChmYW5vdGlmeV9ldmVudF9oYXNfcGF0aChldmVudCkpIHsKIAkJc3RydWN0IHBhdGggKnAgPSBm
YW5vdGlmeV9ldmVudF9wYXRoKGV2ZW50KTsKIAotLSAKMi4xNy4xCgo=
--0000000000000637d405a1b0be06--
