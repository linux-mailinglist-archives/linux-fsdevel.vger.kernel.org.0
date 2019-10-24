Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55B4EE2A18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 07:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407066AbfJXFrC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 01:47:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:36860 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406898AbfJXFrC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 01:47:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 991ACB208;
        Thu, 24 Oct 2019 05:46:58 +0000 (UTC)
Subject: Re: [PATCH v2 7/8] scsi: sr: workaround VMware ESXi cdrom emulation
 bug
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1571834862.git.msuchanek@suse.de>
 <abf81ec4f8b6139fffc609df519856ff8dc01d0d.1571834862.git.msuchanek@suse.de>
 <08f1e291-0196-2402-1947-c0cdaaf534da@suse.de>
 <20191023162313.GE938@kitsune.suse.cz>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <2bc50e71-6129-a482-00bd-0425b486ce07@suse.de>
Date:   Thu, 24 Oct 2019 07:46:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191023162313.GE938@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/23/19 6:23 PM, Michal Suchánek wrote:
> On Wed, Oct 23, 2019 at 04:13:15PM +0200, Hannes Reinecke wrote:
>> On 10/23/19 2:52 PM, Michal Suchanek wrote:
>>> The WMware ESXi cdrom identifies itself as:
>>> sr 0:0:0:0: [sr0] scsi3-mmc drive: vendor: "NECVMWarVMware SATA CD001.00"
>>> model: "VMware SATA CD001.00"
>>> with the following get_capabilities print in sr.c:
>>>         sr_printk(KERN_INFO, cd,
>>>                   "scsi3-mmc drive: vendor: \"%s\" model: \"%s\"\n",
>>>                   cd->device->vendor, cd->device->model);
>>>
>>> So the model looks like reliable identification while vendor does not.
>>>
>>> The drive claims to have a tray and claims to be able to close it.
>>> However, the UI has no notion of a tray - when medium is ejected it is
>>> dropped in the floor and the user must select a medium again before the
>>> drive can be re-loaded.  On the kernel side the tray_move call to close
>>> the tray succeeds but the drive state does not change as a result of the
>>> call.
>>>
>>> The drive does not in fact emulate the tray state. There are two ways to
>>> get the medium state. One is the SCSI status:
>>>
>>> Physical drive:
>>>
>>> Fixed format, current; Sense key: Not Ready
>>> Additional sense: Medium not present - tray open
>>> Raw sense data (in hex):
>>>         70 00 02 00 00 00 00 0a  00 00 00 00 3a 02 00 00
>>>         00 00
>>>
>>> Fixed format, current; Sense key: Not Ready
>>> Additional sense: Medium not present - tray closed
>>>  Raw sense data (in hex):
>>>         70 00 02 00 00 00 00 0a  00 00 00 00 3a 01 00 00
>>>         00 00
>>>
>>> VMware ESXi:
>>>
>>> Fixed format, current; Sense key: Not Ready
>>> Additional sense: Medium not present
>>>   Info fld=0x0 [0]
>>>  Raw sense data (in hex):
>>>         f0 00 02 00 00 00 00 0a  00 00 00 00 3a 00 00 00
>>>         00 00
>>>
>>> So the tray state is not reported here. Other is medium status which the
>>> kernel prefers if available. Adding a print here gives:
>>>
>>> cdrom: get_media_event success: code = 0, door_open = 1, medium_present = 0
>>>
>>> door_open is interpreted as open tray. This is fine so long as tray_move
>>> would close the tray when requested or report an error which never
>>> happens on VMware ESXi servers (5.5 and 6.5 tested).
>>>
>>> This is a popular virtualization platform so a workaround is worthwhile.
>>>
>>> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>>> ---
>>>  drivers/scsi/sr.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
>>> index 4664fdf75c0f..8090c5bdec09 100644
>>> --- a/drivers/scsi/sr.c
>>> +++ b/drivers/scsi/sr.c
>>> @@ -867,6 +867,7 @@ static void get_capabilities(struct scsi_cd *cd)
>>>  	unsigned int ms_len = 128;
>>>  	int rc, n;
>>>  
>>> +	static const char *model_vmware = "VMware";
>>>  	static const char *loadmech[] =
>>>  	{
>>>  		"caddy",
>>> @@ -922,6 +923,11 @@ static void get_capabilities(struct scsi_cd *cd)
>>>  		  buffer[n + 4] & 0x20 ? "xa/form2 " : "",	/* can read xa/from2 */
>>>  		  buffer[n + 5] & 0x01 ? "cdda " : "", /* can read audio data */
>>>  		  loadmech[buffer[n + 6] >> 5]);
>>> +	if (!strncmp(cd->device->model, model_vmware, strlen(model_vmware))) {
>>> +		buffer[n + 6] &= ~(0xff << 5);
>>> +		sr_printk(KERN_INFO, cd,
>>> +			  "VMware ESXi bug workaround: tray -> caddy\n");
>>> +	}
>>>  	if ((buffer[n + 6] >> 5) == 0)
>>>  		/* caddy drives can't close tray... */
>>>  		cd->cdi.mask |= CDC_CLOSE_TRAY;
>>>
>> This looks something which should be handled via a blacklist flag, not
>> some inline hack which everyone forgets about it...
> 
> AFAIK we used to have a blacklist but don't have anymore. So either it
> has to be resurrected for this one flag or an inline hack should be good
> enough.
> 
But we do have one for generic scsi; cf drivers/scsi/scsi_devinfo.c.
And this pretty much falls into the category of SCSI quirks, so I'd
prefer have it hooked into that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      Teamlead Storage & Networking
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 247165 (AG München), GF: Felix Imendörffer
