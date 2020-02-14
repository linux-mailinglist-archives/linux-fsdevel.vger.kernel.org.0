Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9071515F158
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 19:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgBNSBx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 13:01:53 -0500
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:27480 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731105AbgBNSBv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:01:51 -0500
X-EEMSG-check-017: 56399755|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,441,1574121600"; 
   d="scan'208";a="56399755"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2020 18:01:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581703301; x=1613239301;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OBvX8TcgLji7a8VnRi0stkRmiT+GTHv2A0MgzinqleU=;
  b=d3B6JrzVm2lLCdyr9XB8ygZ3TAWOnvnDSVM7+PGiqgnA7Wt//wNXnFi3
   wgHvoaKprZ3N4xb2XTPY5wsG3Kwd1TihZ17MdxnxQyzLKLJUN3Epzry48
   8qJAq5T5iN3kJZ0VHRHy7TeOMPUpJviGY6SMhkAjO8h9qGhoGqu1mHMin
   V4VpycYbSUSvkrtD/nlTRpYeAhak9837DvRymnx/ObotOhVzYj6lMIXih
   VDBJ6fuY1/suf2As7lbONbeNFctb8ablGcrb2sNrnHjChwBbT1tFkEDg5
   B6ceMy0KFN21DF0rortc0+bOIfy5/Bmu2WZg4nraQTTjdj2dIDu4stkfH
   w==;
X-IronPort-AV: E=Sophos;i="5.70,441,1574121600"; 
   d="scan'208";a="39145150"
IronPort-PHdr: =?us-ascii?q?9a23=3A4jHv7x/tg6OZQv9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+1+8XIJqq85mqBkHD//Il1AaPAdyHra0cwLOO4+jJYi8p39WoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagbr5+Nhe7oRneusULnYdvKbs6xw?=
 =?us-ascii?q?fUrHdPZ+lZymRkKE6JkR3h/Mmw5plj8ypRu/Il6cFNVLjxcro7Q7JFEjkoKn?=
 =?us-ascii?q?g568L3uxbNSwuP/WYcXX4NkhVUGQjF7Qr1UYn3vyDnq+dywiiaPcnxTbApRT?=
 =?us-ascii?q?Sv6rpgRRH0hCsbMTMy7XragdJsgq1FvB2hpgR/w4/Kb4GTKPp+Zb7WcdcDSW?=
 =?us-ascii?q?ZcQspdSylND4WyYIsVC+oKIPhWoY/zqVATqReyHAmhCefqxjJOm3T437A10/?=
 =?us-ascii?q?45HA/bwgIgEdIAvnfaotr7O6gdU/y6wqbTwDXfbf5bwyvx5JTGfx0jp/yHQL?=
 =?us-ascii?q?J+cdDWyUkqDw7Lk0mQppL9PzOVyOsNtXWQ4fdlVe21j24nrx9+oziyzcorkY?=
 =?us-ascii?q?nGm5kVx0vY9SR53Ik1Jdq4RFR9Yd6/CpRcrS6aN4xoQs47RWxjpSU0yqUetJ?=
 =?us-ascii?q?KmcyUHx44ryh7CZ/CdbYSF7QzvWPyMLTp+mXlrYqiwhwyo/kil0uD8U86030?=
 =?us-ascii?q?tUoSddidnMs2wN1wTU6siaVvtx5keh1iiL1wDU8uxEPVo7lbDaK5482b48jJ?=
 =?us-ascii?q?sTsULNHi/xg0X5krOZel84+umo9+vnYrLmqoWaN4BokQHxLr4imsm+AeQ8Kg?=
 =?us-ascii?q?QOXm6b9vqg1LD74EH0T7pHguc2n6XEqpzWO8sWqrCjDwNIyooj7gywDzai0N?=
 =?us-ascii?q?QWh3kHK1dFdQqcj4f0IFHDO+z4DPejjFSslzdn3fbGPqb7DZnXIXjDl6nhca?=
 =?us-ascii?q?5n60FA0Aoz0cxf55VMB74cOv3zXFP+tNvcDhIiPAy0xOHnCNp51owAQ26AHq?=
 =?us-ascii?q?iZMKbKu1+S+u0vO/WMZJMSuDvlN/gl5vvujXokmV8HZ6mmx5sWZWu3HvRhJE?=
 =?us-ascii?q?WZbn7sjckbHWgWuQo+SfTgiEeeXj5Le3ayQ6U86ykgCI24CYfDR4atgKGO3S?=
 =?us-ascii?q?qgAJ1WaX5JCkqWHXfraYqEQfEMZzyWIsN7lTwET7ehQZc71R6yrA/616ZnLu?=
 =?us-ascii?q?3M9y0ctJLj0sV15uLKmREp6zN7E9md03uMT2FonmIEXjo23KdirkxgzleMz7?=
 =?us-ascii?q?N1g+JXFdNN/fNFSAQ6OoDGz+x8Fd/yXhjNftCTSFapWt+mGy0+Tsotw98SZE?=
 =?us-ascii?q?ZwA9GijhHF3yq3DL4ZjrKLBIcp/a3CwXj+OcJ9xm3Y1KkukVYmWNFDNW64ia?=
 =?us-ascii?q?5l8QjcGYrJn1+el6aweqQWxDTN+3ubzWqSoEFYVxZ9UaHEXXAZe0vXos315k?=
 =?us-ascii?q?DcQL+0D7QoLA9BxNWcKqtFdNLpl09KRPT9N9TEZWK+hWOwCQyPxrOWY4rgY3?=
 =?us-ascii?q?8d0znFCEgYjwAT+m6LNQsgBiekuG/eEjNuGkz1Y0/28ulxtmm7TkkqwAGOdU?=
 =?us-ascii?q?Fh0KC1+hENj/yGV/wTxq4EuDsmqzhsAla93sjWC92bqgtgYqpcZ9I94Eld2W?=
 =?us-ascii?q?Ldtgx9OIGgLq94il4ZaQR3sFni1wh0Co9Yi8glsGsqzBZuKaKfyF5BbymX3Y?=
 =?us-ascii?q?30OrDMMmn95g2va6rP1lHb19aW/b0P5+oip1r/uwGpE1Io82973NlNz3uc+p?=
 =?us-ascii?q?LKARIUUZL3UUY67Bd6p7bdYiky44Pby2dgPrWzsj/Hw9gpHvcqyg68f9dDN6?=
 =?us-ascii?q?OJDAvyE8oZB8ewM+wqm1epbhMZM+BI7qE5JMymd/yB2K6kOOZvgiiqgnhA4I?=
 =?us-ascii?q?B4gQqw8H9QQ+jJ0pJN6Pac1xCMVjD6gR/1vsnxkodATT4VGWW7xG7vA4sHNY?=
 =?us-ascii?q?NoeoNeMnujO826wJ1FgpfpX3NJvAq4C0guxN6ieR3UaUf0mwJXyxJE8jSchS?=
 =?us-ascii?q?KkwmkswHkSpa2F0XmLmrmzeQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BzAgAz4EZe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBe?=
 =?us-ascii?q?AWBbSASKoQUiQOGWQEBBAaBEiWJcJFKCQEBAQEBAQEBATcEAQGEQAKCJTgTA?=
 =?us-ascii?q?hABAQEFAQEBAQEFAwEBbIVDgjspAYMCAQUjFUEQCw4KAgImAgJXBg0GAgEBg?=
 =?us-ascii?q?mM/glclrjmBMoVKg1GBPoEOKow+eYEHgTgMA4JdPodbgl4EjhOCC4ZFZEaXb?=
 =?us-ascii?q?YJEgk+TfAYcmxisJyKBWCsIAhgIIQ+DJ1AYDY4pF45BIwMwkFgBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 14 Feb 2020 18:01:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01EI0Zuk224275;
        Fri, 14 Feb 2020 13:00:36 -0500
Subject: Re: [PATCH 2/3] Teach SELinux about anonymous inodes
To:     Daniel Colascione <dancol@google.com>
Cc:     Tim Murray <timmurray@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, paul@paul-moore.com,
        Nick Kralevich <nnk@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
References: <20200211225547.235083-1-dancol@google.com>
 <20200214032635.75434-1-dancol@google.com>
 <20200214032635.75434-3-dancol@google.com>
 <9ca03838-8686-0007-0971-ee63bf5031da@tycho.nsa.gov>
 <CAKOZuev-=7Lgu35E3tzpHQn0m_KAvvrqi+ZJr1dpqRjHERRSqg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <23f725ca-5b5a-5938-fcc8-5bbbfc9ba9bc@tycho.nsa.gov>
Date:   Fri, 14 Feb 2020 13:02:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKOZuev-=7Lgu35E3tzpHQn0m_KAvvrqi+ZJr1dpqRjHERRSqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/14/20 12:21 PM, Daniel Colascione wrote:
> On Fri, Feb 14, 2020 at 8:38 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> That's assuming you are ok with having to define these type_transition
>> rules for the userfaultfd case instead of having your own separate
>> security class.  Wondering how many different anon inode names/classes
>> there are in the kernel today and how much they change over time; for a
>> small, relatively stable set, separate classes might be ok; for a large,
>> dynamic set, type transitions should scale better.
> 
> I think we can get away without a class per anonymous-inode-type. I do
> wonder whether we need a class for all anonymous inodes, though: if we
> just give them the file class and use the anon inode type name for the
> type_transition rule, isn't it possible that the type_transition rule
> might also fire for plain files with the same names in the last path
> component and the same originating sid? (Maybe I'm not understanding
> type_transition rules properly.) Using a class to encompass all
> anonymous inodes would address this problem (assuming the problem
> exists in the first place).

It shouldn't fire for non-anon inodes because on a (non-anon) file 
creation, security_transition_sid() is passed the parent directory SID 
as the second argument and we only assign task SIDs to /proc/pid 
directories, which don't support (userspace) file creation anyway.

However, in the absence of a matching type_transition rule, we'll end up 
defaulting to the task SID on the anon inode, and without a separate 
class we won't be able to distinguish it from a /proc/pid inode.  So 
that might justify a separate anoninode or similar class.

This however reminded me that for the context_inode case, we not only 
want to inherit the SID but also the sclass from the context_inode. 
That is so that anon inodes created via device node ioctls inherit the 
same SID/class pair as the device node and a single allowx rule can 
govern all ioctl commands on that device.








